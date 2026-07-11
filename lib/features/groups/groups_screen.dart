import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/errors.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/skeleton.dart';
import '../../data/remote/cloud_models.dart';
import '../../data/remote/cloud_repository.dart';
import '../../domain/entities/subscription.dart';
import '../auth/sign_in_screen.dart';
import '../profile/profile_sync.dart';
import 'cloud_chat_screen.dart';
import 'group_chat_screen.dart';
import 'pod_models.dart';
import 'pod_rules_sheet.dart';

/// Localized subscription-tier name (Free / Premium · Monthly / Premium · Yearly).
String tierLabelL10n(AppLocalizations l, SubscriptionTier tier) => switch (tier) {
      SubscriptionTier.free => l.tierFree,
      SubscriptionTier.monthly => l.tierMonthly,
      SubscriptionTier.yearly => l.tierYearly,
    };

/// Localized "how many pods" label for a tier ("1 pod" / "3 pods" / "unlimited pods").
String podsLabelL10n(AppLocalizations l, SubscriptionTier tier) {
  final max = GroupRules.maxGroups(tier);
  return max == null ? l.podsUnlimited : l.podsCount(max);
}

/// Tab 2 — pods of introverts. Capacity + how many pods you can join are gated
/// by subscription: free → 1 pod (≤25), monthly → 3 pods (≤50), yearly →
/// unlimited (≤50). The first pod is system-assigned. Enforced server-side.
class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cloud = ref.watch(cloudEnabledProvider);
    if (!cloud) return const _LocalGroupsShell();

    final user = ref.watch(authUserProvider).asData?.value;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).navGroups)),
      // Key by account id → switching accounts rebuilds a FRESH _CloudGroups
      // (re-runs bootstrap/ensureSystemPod), never reusing the old user's pods.
      body: user == null
          ? const _SignedOut()
          : _CloudGroups(key: ValueKey(user.id)),
    );
  }
}

// ── Signed-out CTA ──────────────────────────────────────────────────────────
class _SignedOut extends StatelessWidget {
  const _SignedOut();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Insets.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.groups_2_outlined,
                size: 56, color: AppColors.primary),
            const SizedBox(height: Insets.lg),
            Text(l.groupsSignedOutTitle, style: t.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: Insets.sm),
            Text(
              l.groupsSignedOutBody,
              textAlign: TextAlign.center,
              style: t.bodyMedium,
            ),
            const SizedBox(height: Insets.xl),
            FilledButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignInScreen())),
              child: Text(l.groupsSignInCta),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Cloud groups (signed in) ────────────────────────────────────────────────
class _CloudGroups extends ConsumerStatefulWidget {
  const _CloudGroups({super.key});
  @override
  ConsumerState<_CloudGroups> createState() => _CloudGroupsState();
}

class _CloudGroupsState extends ConsumerState<_CloudGroups> {
  bool _loading = true;
  String? _error;
  List<CloudPod> _mine = [];
  List<CloudPod> _discover = [];

  CloudRepository get _repo => ref.read(cloudRepositoryProvider);

  // ── "Last seen pods" cache: instant render on open, refresh in background ──
  String get _cacheKey {
    final uid = ref.read(authRepositoryProvider).currentUser?.id ?? '';
    return 'pods_cache_$uid';
  }

  bool _loadFromCache() {
    try {
      final raw = ref.read(databaseProvider).meta(_cacheKey);
      if (raw == null || raw.isEmpty) return false;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      List<CloudPod> pods(String k) => ((map[k] ?? []) as List)
          .map((e) => CloudPod.fromRow(e as Map<String, dynamic>))
          .toList();
      _mine = pods('mine');
      _discover = pods('discover');
      return _mine.isNotEmpty || _discover.isNotEmpty;
    } catch (_) {
      return false; // corrupt/old cache → fall back to the network path
    }
  }

  void _saveCache() {
    try {
      ref.read(databaseProvider).setMeta(
            _cacheKey,
            jsonEncode({
              'mine': _mine.map((p) => p.toJson()).toList(),
              'discover': _discover.map((p) => p.toJson()).toList(),
            }),
          );
    } catch (_) {/* cache is best-effort */}
  }

  @override
  void initState() {
    super.initState();
    // Render the last-seen pods IMMEDIATELY (no shimmer) and refresh behind
    // them; first-ever open still shows the skeleton while the network runs.
    if (_loadFromCache()) _loading = false;
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    if (_loading) {
      // no cache — show the skeleton while we fetch
      setState(() => _error = null);
    }
    try {
      // Publish identity in the BACKGROUND — the pod list doesn't depend on it,
      // so don't make the user wait a round-trip for it. (Identity only — never
      // republish stats here; local may have just been reset by an account
      // switch, and pushing would zero this account's stats.)
      unawaited(pushIdentityToCloud(ref));
      await _repo.ensureSystemPod();
      await _reload();
    } catch (e) {
      // Only surface the error when there's nothing cached on screen.
      if (mounted && _mine.isEmpty && _discover.isEmpty) {
        setState(() => _error = isOfflineError(e)
            ? AppLocalizations.of(context).errorOffline
            : AppLocalizations.of(context).groupsLoadError);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _reload() async {
    // Fire both RPCs together (they don't depend on each other) → one round-trip
    // of latency instead of two. Future.wait awaits BOTH before completing, so
    // neither is orphaned if the other throws (awaiting them sequentially would
    // leave an unhandled rejection that crashes past the caller's try/catch).
    // Unlike record `.wait`, it rethrows the original exception, so the caller's
    // isOfflineError() check still recognises an offline failure.
    final results = await Future.wait([_repo.myPods(), _repo.discoverPods()]);
    final mine = results[0];
    final discover = results[1];
    if (mounted) {
      setState(() {
        _mine = mine;
        _discover = discover;
      });
      _saveCache();
    }
  }

  /// Shows the community rules before the first pod, once.
  Future<bool> _ensureRules() async {
    final settings = ref.read(settingsRepositoryProvider);
    if (settings.hasAcceptedPodRules) return true;
    final ok = await showPodRulesSheet(context);
    if (ok) await settings.setAcceptedPodRules(true);
    return ok;
  }

  Future<void> _join(CloudPod pod) async {
    final l = AppLocalizations.of(context);
    if (!await _ensureRules()) return;
    try {
      await _repo.joinPod(pod.id);
      await _reload();
      _snack(l.groupsJoined(pod.name));
    } on CloudJoinException catch (e) {
      _snack(e.message);
    }
  }

  /// Joins the next open pod the server offers (matchmaking) — never runs dry,
  /// since the server creates a fresh pod when all are full. Tier-gated.
  Future<void> _joinAnother() async {
    final l = AppLocalizations.of(context);
    if (!await _ensureRules()) return;
    try {
      final gid = await _repo.matchDiscoverPod();
      await _repo.joinPod(gid);
      await _reload();
      _snack(l.groupsJoinedNew);
    } on CloudJoinException catch (e) {
      _snack(e.message);
    } catch (_) {
      _snack(l.groupsNoPodFound);
    }
  }

  Future<void> _leave(CloudPod pod) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l.groupsLeaveTitle(pod.name)),
        content: Text(l.groupsLeaveBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(false),
              child: Text(l.commonCancel)),
          FilledButton(
              onPressed: () => Navigator.of(dialogCtx).pop(true),
              child: Text(l.groupsLeave)),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _repo.leavePod(pod.id);
      await _reload();
      _snack(l.groupsLeft(pod.name));
    } catch (_) {
      _snack(l.groupsLeaveError);
    }
  }

  Future<void> _open(CloudPod pod) async {
    if (!await _ensureRules()) return;
    if (!mounted) return;
    ref.read(analyticsProvider)
        .capture(Ev.podOpened, {'system': pod.isSystem});
    final left = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => CloudChatScreen(pod: pod),
    ));
    if (left == true && mounted) await _reload(); // they left from the chat
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)),
      );

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsChangesProvider);
    final tier = ref.watch(settingsRepositoryProvider).subscriptionTier;
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);

    if (_loading) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(
            Insets.lg, Insets.lg, Insets.lg, Insets.xl),
        children: [
          const Skeleton(width: 220, height: 24),
          const SizedBox(height: Insets.sm),
          const Skeleton(width: 280, height: 14),
          const SizedBox(height: Insets.lg),
          for (var i = 0; i < 4; i++) ...[
            const _PodSkeleton(),
            const SizedBox(height: Insets.sm),
          ],
        ],
      );
    }
    if (_error != null) {
      return RefreshIndicator(
        onRefresh: _bootstrap,
        child: ListView(children: [
          const SizedBox(height: 120),
          Center(child: Text(_error!, textAlign: TextAlign.center)),
        ]),
      );
    }

    final canJoinMore = GroupRules.canJoinAnother(tier, _mine.length);

    return RefreshIndicator(
      onRefresh: _reload,
      child: ListView(
        padding:
            const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, Insets.xl),
        children: [
          Text(l.groupsHeader, style: t.headlineSmall),
          const SizedBox(height: Insets.xs),
          Text(
            l.groupsTierPods(
                tierLabelL10n(l, tier).toLowerCase(), podsLabelL10n(l, tier)),
            style: t.bodyMedium,
          ),
          const SizedBox(height: Insets.lg),
          Text(l.groupsYourPods, style: _section(t, AppColors.primary)),
          const SizedBox(height: Insets.sm),
          for (final (i, pod) in _mine.indexed) ...[
            _PodTile(
              name: pod.name,
              subtitle: l.groupsMembers(pod.memberCount, pod.capacity),
              unreadCount: pod.unreadCount,
              system: pod.isSystem,
              joined: true,
              memberCount: pod.memberCount,
              capacity: pod.capacity,
              onOpen: () => _open(pod),
              onLeave: () => _leave(pod),
            )
                .animate()
                .fadeIn(duration: 260.ms, delay: (40 * i).ms)
                .slideY(begin: 0.06, end: 0, curve: Curves.easeOut),
            const SizedBox(height: Insets.sm),
          ],
          if (canJoinMore) ...[
            const SizedBox(height: Insets.xs),
            OutlinedButton.icon(
              onPressed: _joinAnother,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(l.groupsJoinAnother),
              style:
                  OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(46)),
            ),
          ],
          const SizedBox(height: Insets.md),
          Text(l.groupsDiscoverPods, style: _section(t, AppColors.inkMuted)),
          const SizedBox(height: Insets.sm),
          if (!canJoinMore)
            _UpgradeBanner(tier: tier)
          else if (_discover.isEmpty)
            Text(l.groupsNoOthers, style: t.bodyMedium)
          else
            for (final (i, pod) in _discover.indexed) ...[
              _PodTile(
                name: pod.name,
                subtitle: l.groupsMembers(pod.memberCount, pod.capacity),
                joined: false,
                memberCount: pod.memberCount,
                capacity: pod.capacity,
                onJoin: () => _join(pod),
              )
                  .animate()
                  .fadeIn(duration: 260.ms, delay: (40 * i).ms)
                  .slideY(begin: 0.06, end: 0, curve: Curves.easeOut),
              const SizedBox(height: Insets.sm),
            ],
          const SizedBox(height: Insets.lg),
          const _SafetyNote(live: true),
        ],
      ),
    );
  }
}

TextStyle? _section(TextTheme t, Color c) => t.bodyMedium?.copyWith(
    color: c, fontWeight: FontWeight.w700, letterSpacing: 0.5, fontSize: 11);

// ── Local sample shell (when cloud is off) ──────────────────────────────────
class _LocalGroupsShell extends ConsumerStatefulWidget {
  const _LocalGroupsShell();
  @override
  ConsumerState<_LocalGroupsShell> createState() => _LocalGroupsShellState();
}

class _LocalGroupsShellState extends ConsumerState<_LocalGroupsShell> {
  final Set<String> _joinedExtra = {};

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsChangesProvider);
    final tier = ref.watch(settingsRepositoryProvider).subscriptionTier;
    final capacity = GroupRules.podCapacity(tier);
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final system = systemPod(capacity);
    final joinedCount = 1 + _joinedExtra.length;
    final canJoinMore = GroupRules.canJoinAnother(tier, joinedCount);
    final discover = discoverablePods(capacity)
        .where((p) => !_joinedExtra.contains(p.name))
        .toList();

    void open(Pod pod) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GroupChatScreen(
            podName: pod.name,
            memberCount: pod.memberCount,
            capacity: pod.capacity)));

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).navGroups)),
      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, Insets.xl),
        children: [
          Text(l.groupsHeader, style: t.headlineSmall),
          const SizedBox(height: Insets.xs),
          Text(
            l.groupsCapacityTierPods(capacity,
                tierLabelL10n(l, tier).toLowerCase(), podsLabelL10n(l, tier)),
            style: t.bodyMedium,
          ),
          const SizedBox(height: Insets.lg),
          Text(l.groupsYourPods, style: _section(t, AppColors.primary)),
          const SizedBox(height: Insets.sm),
          _PodTile(
              name: system.name,
              subtitle: '${system.memberCount}/${system.capacity} · ${system.blurb}',
              system: true,
              joined: true,
              onOpen: () => open(system)),
          for (final pod in discoverablePods(capacity)
              .where((p) => _joinedExtra.contains(p.name))) ...[
            const SizedBox(height: Insets.sm),
            _PodTile(
                name: pod.name,
                subtitle: '${pod.memberCount}/${pod.capacity} · ${pod.blurb}',
                joined: true,
                onOpen: () => open(pod)),
          ],
          const SizedBox(height: Insets.md),
          Text(l.groupsDiscoverPods, style: _section(t, AppColors.inkMuted)),
          const SizedBox(height: Insets.sm),
          if (!canJoinMore)
            _UpgradeBanner(tier: tier)
          else
            for (final pod in discover) ...[
              _PodTile(
                name: pod.name,
                subtitle: '${pod.memberCount}/${pod.capacity} · ${pod.blurb}',
                joined: false,
                onJoin: () {
                  setState(() => _joinedExtra.add(pod.name));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(l.groupsJoinedShort(pod.name))));
                },
              ),
              const SizedBox(height: Insets.sm),
            ],
          const SizedBox(height: Insets.lg),
          const _SafetyNote(live: false),
        ],
      ),
    );
  }
}

// ── Shared bits ─────────────────────────────────────────────────────────────
class _PodSkeleton extends StatelessWidget {
  const _PodSkeleton();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Skeleton(width: 44, height: 44, radius: 14),
          SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 150, height: 16),
                SizedBox(height: 8),
                Skeleton(width: 96, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Calm gradient pairs for pod icons — picked by the pod's name so each pod
/// keeps a stable, recognisable colour (a little identity per pod).
const _podGradients = <List<Color>>[
  [Color(0xFF3AA8A0), Color(0xFF23736D)], // teal
  [Color(0xFF6B8FC9), Color(0xFF33507E)], // dusk blue
  [Color(0xFF4C9A6B), Color(0xFF2C6B48)], // forest
  [Color(0xFFF2A65A), Color(0xFFC97B3D)], // amber
  [Color(0xFFB187C9), Color(0xFF7C5296)], // lavender
  [Color(0xFFE0899C), Color(0xFFAF5A72)], // rose
];

class _PodTile extends StatelessWidget {
  const _PodTile({
    required this.name,
    required this.subtitle,
    required this.joined,
    this.system = false,
    this.unreadCount = 0,
    this.memberCount,
    this.capacity,
    this.onJoin,
    this.onOpen,
    this.onLeave,
  });
  final String name;
  final String subtitle;
  final bool joined;
  final bool system;
  final int unreadCount;
  final int? memberCount; // with [capacity], draws the little fill bar
  final int? capacity;
  final VoidCallback? onJoin;
  final VoidCallback? onOpen;
  final VoidCallback? onLeave;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final gradient = _podGradients[name.hashCode.abs() % _podGradients.length];
    final fill = (memberCount != null && capacity != null && capacity! > 0)
        ? (memberCount! / capacity!).clamp(0.0, 1.0)
        : null;
    return InkWell(
      borderRadius: Radii.lgAll,
      onTap: joined ? onOpen : null,
      child: Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          color: joined
              ? AppColors.primary.withValues(alpha: 0.10)
              : Theme.of(context).colorScheme.surface,
          borderRadius: Radii.lgAll,
          border: Border.all(
              color: joined
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: gradient.last.withValues(alpha: 0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                  system
                      ? Icons.auto_awesome_outlined
                      : Icons.groups_2_outlined,
                  color: Colors.white,
                  size: 24),
            ),
            const SizedBox(width: Insets.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(name, style: t.titleMedium)),
                      if (system) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.verified_rounded,
                            size: 15, color: AppColors.primary),
                      ],
                      if (joined && unreadCount > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 1.5),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(999)),
                          ),
                          child: Text('$unreadCount',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: t.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  if (fill != null) ...[
                    const SizedBox(height: 7),
                    // How alive the pod is, at a glance.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: SizedBox(
                        height: 4,
                        child: LinearProgressIndicator(
                          value: fill,
                          backgroundColor:
                              gradient.first.withValues(alpha: 0.15),
                          valueColor: AlwaysStoppedAnimation(gradient.first),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: Insets.sm),
            if (!joined)
              FilledButton(
                onPressed: onJoin,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(72, 40),
                  padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                ),
                child: Text(AppLocalizations.of(context).groupsJoin),
              )
            else if (!system && onLeave != null)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded,
                    color: AppColors.inkFaint),
                tooltip: AppLocalizations.of(context).groupsPodOptions,
                onSelected: (v) {
                  if (v == 'leave') onLeave!();
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'leave',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.logout_rounded),
                      title: Text(AppLocalizations.of(context).groupsLeavePod),
                    ),
                  ),
                ],
              )
            else
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}

class _UpgradeBanner extends StatelessWidget {
  const _UpgradeBanner({required this.tier});
  final SubscriptionTier tier;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: Radii.lgAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium_outlined,
                  color: AppColors.accentDeep),
              const SizedBox(width: Insets.sm),
              Expanded(
                child: Text(l.groupsInYourPods(podsLabelL10n(l, tier)),
                    style:
                        t.titleMedium?.copyWith(color: AppColors.accentDeep)),
              ),
            ],
          ),
          const SizedBox(height: Insets.sm),
          Text(
            l.groupsUpgradeBody,
            style: t.bodyMedium?.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: Insets.md),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.accentDeep),
            onPressed: () => context.go(Routes.subscription),
            child: Text(l.shareSeePremium),
          ),
        ],
      ),
    );
  }
}

class _SafetyNote extends StatelessWidget {
  const _SafetyNote({required this.live});
  final bool live;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: Radii.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shield_outlined, color: AppColors.inkMuted),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Text(
              live
                  ? AppLocalizations.of(context).groupsSafetyLive
                  : AppLocalizations.of(context).groupsSafetyPreview,
              style: t.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
