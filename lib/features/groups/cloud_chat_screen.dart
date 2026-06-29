import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/safety/content_guard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/remote/cloud_models.dart';
import '../../data/remote/cloud_repository.dart';
import '../../shared/support_sheet.dart';
import 'member_sheet.dart';
import 'pod_models.dart';

/// Live pod chat backed by Supabase realtime. Posting is restricted to pod
/// members by RLS; capacity/limits were enforced at join time.
class CloudChatScreen extends ConsumerStatefulWidget {
  const CloudChatScreen({super.key, required this.pod});
  final CloudPod pod;

  @override
  ConsumerState<CloudChatScreen> createState() => _CloudChatScreenState();
}

class _CloudChatScreenState extends ConsumerState<CloudChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  Map<String, CloudProfile> _profiles = {};
  final Set<String> _blocked = {};

  // The realtime message stream is cached and only rebuilt when the page size
  // changes — otherwise every setState (e.g. opening a member sheet) would
  // recreate it and flash the StreamBuilder back to its loading spinner.
  Stream<List<CloudMessage>>? _stream;
  int _streamLimit = -1;

  Stream<List<CloudMessage>> _messages() {
    if (_stream == null || _streamLimit != _limit) {
      _streamLimit = _limit;
      _stream = ref
          .read(cloudRepositoryProvider)
          .watchMessages(widget.pod.id, limit: _limit);
    }
    return _stream!;
  }

  // Pagination: stream the latest [_limit] messages; raise it to load older.
  static const _page = 20;
  int _limit = _page;
  int _lastCount = 0;
  bool _loadingMore = false;
  bool get _hasMore => _lastCount >= _limit;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _loadMembers();
  }

  void _onScroll() {
    if (!_scroll.hasClients || !mounted) return;
    final pos = _scroll.position;
    // Reverse list → maxScrollExtent is the OLDEST end. Near it, load more.
    if (pos.pixels >= pos.maxScrollExtent - 300 && _hasMore && !_loadingMore) {
      _loadingMore = true;
      setState(() => _limit += _page);
      Future.delayed(const Duration(milliseconds: 600),
          () => _loadingMore = false);
    }
  }

  Future<void> _loadMembers() async {
    final repo = ref.read(cloudRepositoryProvider);
    try {
      final ids = await repo.podMemberIds(widget.pod.id);
      final profiles = await repo.visibleProfiles(ids);
      if (mounted) setState(() => _profiles = profiles);
    } catch (_) {/* roster is best-effort */}
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty) return;

    // Soft-block obvious abuse before it ever leaves the device.
    if (ContentGuard.isAbusive(text)) {
      _snack("Let's keep pods kind — please rephrase that.");
      return;
    }
    _input.clear();
    try {
      await ref.read(cloudRepositoryProvider).sendMessage(widget.pod.id, text);
      ref.read(analyticsProvider).capture(Ev.messageSent); // never log body text
    } on CloudActionException catch (e) {
      _snack(e.message);
      return;
    }
    // Surface support if the message signals distress (never blocks sending).
    if (mounted && ContentGuard.isDistress(text)) {
      await showSupportSheet(context);
    }
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)),
      );

  Future<void> _leavePod() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Leave ${widget.pod.name}?'),
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
      await ref.read(cloudRepositoryProvider).leavePod(widget.pod.id);
      if (mounted) Navigator.of(context).pop(true); // tell the list to refresh
    } catch (_) {
      _snack('Could not leave the pod. Try again.');
    }
  }

  Future<void> _openMember(CloudMessage m) async {
    // Fetch the member's CURRENT profile so a just-applied lock / updated stats
    // are reflected immediately (RLS returns nothing for a locked member).
    CloudProfile? p;
    try {
      final map =
          await ref.read(cloudRepositoryProvider).visibleProfiles([m.userId]);
      p = map[m.userId];
      if (p != null && mounted) {
        setState(() => _profiles = {..._profiles, m.userId: p!});
      }
    } catch (_) {/* fall back to cache */}

    final member = (p == null || p.isLocked)
        ? const Member(name: 'Private member', locked: true)
        : Member(
            name: p.displayName ?? 'Member',
            bio: p.bio ?? '',
            streak: p.currentStreak,
            challenges: p.totalChallenges,
          );
    if (!mounted) return;
    showMemberSheet(
      context,
      member,
      userId: m.userId,
      messageId: m.id,
      groupId: widget.pod.id,
      onBlocked: (id) => setState(() => _blocked.add(id)),
    );
  }

  Member _memberFor(String userId) {
    final p = _profiles[userId];
    if (p == null || p.isLocked) {
      return const Member(name: 'Private member', locked: true);
    }
    return Member(
      name: p.displayName ?? 'Member',
      bio: p.bio ?? '',
      locked: false,
      streak: p.currentStreak,
      challenges: p.totalChallenges,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    // Read the CURRENT account each build (not cached) so message alignment is
    // always relative to who's signed in right now.
    final uid = ref.watch(authUserProvider).asData?.value?.id ??
        ref.read(authRepositoryProvider).currentUser?.id;
    final stream = _messages();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.pod.name, style: t.titleMedium),
            Text('${widget.pod.memberCount}/${widget.pod.capacity} · be kind',
                style: t.bodyMedium),
          ],
        ),
        actions: [
          if (!widget.pod.isSystem)
            PopupMenuButton<String>(
              tooltip: 'Pod options',
              onSelected: (v) {
                if (v == 'leave') _leavePod();
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
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<CloudMessage>>(
              stream: stream,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final raw = snap.data ?? const <CloudMessage>[];
                _lastCount = raw.length; // gauge whether more pages exist
                // Newest-first (matches the stream); blocked users filtered out.
                final messages =
                    raw.where((m) => !_blocked.contains(m.userId)).toList();
                if (messages.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(Insets.xl),
                      child: Text(
                        'No messages yet. A simple "hi" is a brave first rung.',
                        textAlign: TextAlign.center,
                        style: t.bodyMedium,
                      ),
                    ),
                  );
                }
                // reverse: true → newest at the bottom; the list stays pinned to
                // the newest message and scrolling up reveals older ones.
                return ListView.builder(
                  controller: _scroll,
                  reverse: true,
                  padding: const EdgeInsets.all(Insets.lg),
                  itemCount: messages.length + (_hasMore ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == messages.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: Insets.md),
                        child: Center(
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }
                    final m = messages[i];
                    final mine = m.userId == uid;
                    final member = mine ? null : _memberFor(m.userId);
                    return _Bubble(
                      text: m.body,
                      mine: mine,
                      member: member,
                      onAvatarTap:
                          member == null ? null : () => _openMember(m),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  Insets.md, Insets.sm, Insets.md, Insets.md),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Say something kind…',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Insets.md, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: Radii.pill,
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: Radii.pill,
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Insets.sm),
                  IconButton.filled(
                    style:
                        IconButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: _send,
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.text,
    required this.mine,
    this.member,
    this.onAvatarTap,
  });
  final String text;
  final bool mine;
  final Member? member;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final m = member;
    final bubble = Container(
      padding: const EdgeInsets.all(Insets.md),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
      decoration: BoxDecoration(
        color: mine ? AppColors.primary : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radii.md,
          topRight: Radii.md,
          bottomLeft: Radius.circular(mine ? 16 : 4),
          bottomRight: Radius.circular(mine ? 4 : 16),
        ),
        border: mine ? null : Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!mine && m != null)
            Text(m.locked ? 'Private member' : m.name,
                style: t.bodyMedium?.copyWith(
                    color: AppColors.primaryDeep,
                    fontWeight: FontWeight.w700)),
          if (!mine && m != null) const SizedBox(height: 2),
          Text(text,
              style:
                  t.bodyLarge?.copyWith(color: mine ? Colors.white : Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );

    if (mine) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.only(bottom: Insets.md), child: bubble),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: m == null ? null : onAvatarTap,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: (m?.locked ?? true)
                  ? const Icon(Icons.lock_outline_rounded,
                      size: 16, color: AppColors.primaryDeep)
                  : Text(m!.initial,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDeep)),
            ),
          ),
          const SizedBox(width: Insets.sm),
          Flexible(child: bubble),
        ],
      ),
    );
  }
}
