import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
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
      appBar: AppBar(title: const Text('Groups')),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Insets.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.groups_2_outlined,
                size: 56, color: AppColors.primary),
            const SizedBox(height: Insets.lg),
            Text('Join a small, kind pod', style: t.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: Insets.sm),
            Text(
              'Groups need a quick account so pods are safe and yours. Your '
              'practice stays private and account-free.',
              textAlign: TextAlign.center,
              style: t.bodyMedium,
            ),
            const SizedBox(height: Insets.xl),
            FilledButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignInScreen())),
              child: const Text('Sign in to continue'),
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

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      // Identity only — never republish stats here (local may have just been
      // reset by an account switch; pushing would zero this account's stats).
      await pushIdentityToCloud(ref);
      await _repo.ensureSystemPod();
      await _reload();
    } catch (e) {
      if (mounted) setState(() => _error = 'Could not load pods. Pull to retry.\n$e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _reload() async {
    final mine = await _repo.myPods();
    final discover = await _repo.discoverPods();
    if (mounted) {
      setState(() {
        _mine = mine;
        _discover = discover;
      });
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
    if (!await _ensureRules()) return;
    try {
      await _repo.joinPod(pod.id);
      await _reload();
      _snack('Joined ${pod.name}. Say hi when you\'re ready.');
    } on CloudJoinException catch (e) {
      _snack(e.message);
    }
  }

  /// Joins the next open pod the server offers (matchmaking) — never runs dry,
  /// since the server creates a fresh pod when all are full. Tier-gated.
  Future<void> _joinAnother() async {
    if (!await _ensureRules()) return;
    try {
      final gid = await _repo.matchDiscoverPod();
      await _repo.joinPod(gid);
      await _reload();
      _snack('Joined a new pod. Say hi when you\'re ready.');
    } on CloudJoinException catch (e) {
      _snack(e.message);
    } catch (_) {
      _snack('Could not find a pod right now. Try again.');
    }
  }

  Future<void> _leave(CloudPod pod) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Leave ${pod.name}?'),
        content: const Text(
            "You'll stop seeing this pod's messages. You can join again later."),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.of(dialogCtx).pop(true),
              child: const Text('Leave')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _repo.leavePod(pod.id);
      await _reload();
      _snack('You left ${pod.name}.');
    } catch (_) {
      _snack('Could not leave the pod. Try again.');
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
          Text('Small pods, kind people', style: t.headlineSmall),
          const SizedBox(height: Insets.xs),
          Text(
            'On ${tier.label.toLowerCase()} you can be in '
            '${GroupRules.maxGroupsLabel(tier)}.',
            style: t.bodyMedium,
          ),
          const SizedBox(height: Insets.lg),
          Text('YOUR PODS', style: _section(t, AppColors.primary)),
          const SizedBox(height: Insets.sm),
          for (final pod in _mine) ...[
            _PodTile(
              name: pod.name,
              subtitle: '${pod.memberCount}/${pod.capacity} members',
              system: pod.isSystem,
              joined: true,
              onOpen: () => _open(pod),
              onLeave: () => _leave(pod),
            ),
            const SizedBox(height: Insets.sm),
          ],
          if (canJoinMore) ...[
            const SizedBox(height: Insets.xs),
            OutlinedButton.icon(
              onPressed: _joinAnother,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Join another pod'),
              style:
                  OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(46)),
            ),
          ],
          const SizedBox(height: Insets.md),
          Text('DISCOVER PODS', style: _section(t, AppColors.inkMuted)),
          const SizedBox(height: Insets.sm),
          if (!canJoinMore)
            _UpgradeBanner(tier: tier)
          else if (_discover.isEmpty)
            Text('No other pods to join right now.', style: t.bodyMedium)
          else
            for (final pod in _discover) ...[
              _PodTile(
                name: pod.name,
                subtitle: '${pod.memberCount}/${pod.capacity} members',
                joined: false,
                onJoin: () => _join(pod),
              ),
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
      appBar: AppBar(title: const Text('Groups')),
      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, Insets.xl),
        children: [
          Text('Small pods, kind people', style: t.headlineSmall),
          const SizedBox(height: Insets.xs),
          Text(
            'Up to $capacity per pod. On ${tier.label.toLowerCase()} you can be '
            'in ${GroupRules.maxGroupsLabel(tier)}.',
            style: t.bodyMedium,
          ),
          const SizedBox(height: Insets.lg),
          Text('YOUR PODS', style: _section(t, AppColors.primary)),
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
          Text('DISCOVER PODS', style: _section(t, AppColors.inkMuted)),
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
                      content: Text('Joined ${pod.name}.')));
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

class _PodTile extends StatelessWidget {
  const _PodTile({
    required this.name,
    required this.subtitle,
    required this.joined,
    this.system = false,
    this.onJoin,
    this.onOpen,
    this.onLeave,
  });
  final String name;
  final String subtitle;
  final bool joined;
  final bool system;
  final VoidCallback? onJoin;
  final VoidCallback? onOpen;
  final VoidCallback? onLeave;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: Radii.lgAll,
      onTap: joined ? onOpen : null,
      child: Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          color: joined
              ? AppColors.primary.withValues(alpha: 0.12)
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
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                  system
                      ? Icons.auto_awesome_outlined
                      : Icons.groups_2_outlined,
                  color: AppColors.primary),
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
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: t.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
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
                child: const Text('Join'),
              )
            else if (!system && onLeave != null)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded,
                    color: AppColors.inkFaint),
                tooltip: 'Pod options',
                onSelected: (v) {
                  if (v == 'leave') onLeave!();
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'leave',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.logout_rounded),
                      title: Text('Leave pod'),
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
                child: Text("You're in your ${GroupRules.maxGroupsLabel(tier)}",
                    style:
                        t.titleMedium?.copyWith(color: AppColors.accentDeep)),
              ),
            ],
          ),
          const SizedBox(height: Insets.sm),
          Text(
            'Go Premium to join more — monthly unlocks 3 pods, yearly unlocks '
            'as many as you like.',
            style: t.bodyMedium?.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: Insets.md),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.accentDeep),
            onPressed: () => context.go(Routes.subscription),
            child: const Text('See Premium'),
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
                  ? 'Be kind. You can report or block anyone from their profile. '
                      'Locked profiles stay private.'
                  : 'Preview. Pods become live, moderated chats once sign-in is '
                      'configured.',
              style: t.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
