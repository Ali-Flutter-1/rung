import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/safety/content_guard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/remote/cloud_models.dart';
import '../../data/remote/cloud_repository.dart';
import '../../shared/avatars.dart';
import '../../shared/support_sheet.dart';
import 'member_sheet.dart';
import 'pod_models.dart';

/// Supportive quick-reactions offered on each message (kept warm + kind). The
/// picker is a Wrap, so this list can grow freely.
const _reactionEmojis = [
  '👏', '🎉', '❤️', '💪', '🌱', '🙌', '🤗', '😊', '🔥', '⭐', '👍', '🥹',
  '🥰', '🤩', '😌', '🫶', '🙏', '💛', '💯', '🫂', '🥳', '👌', '🤝', '😄',
  '🌟', '🎊', '✨', '💚', '🌈', '🕊️',
];

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
  final _inputFocus = FocusNode();
  final _scroll = ScrollController();
  Map<String, CloudProfile> _profiles = {};
  bool _membersLoaded = false; // gate the list so names resolve before render
  List<CloudMessage> _lastMessages = const []; // keep list mounted across swaps
  final Set<String> _blocked = {};

  // Reactions, aggregated per message from a realtime stream of the pod's rows.
  StreamSubscription<List<CloudReaction>>? _reactionSub;
  Map<String, Map<String, int>> _reactionCounts = {}; // msgId → emoji → count
  Map<String, Set<String>> _myReactions = {}; // msgId → emojis I've added
  String? _uid;
  CloudPodPrompt? _prompt;
  int _todayCheckIns = 0;
  bool _checkedInToday = false;

  // Compose extras: the message being replied to, or the one being edited.
  CloudMessage? _replyingTo;
  CloudMessage? _editing;

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
    _uid = ref.read(authRepositoryProvider).currentUser?.id;
    _loadMembers();
    _loadEngagement();
    unawaited(ref.read(cloudRepositoryProvider).markPodSeen(widget.pod.id));
    _reactionSub = ref
        .read(cloudRepositoryProvider)
        .watchReactions(widget.pod.id)
        .listen(_applyReactions);
  }

  void _applyReactions(List<CloudReaction> rows) {
    final counts = <String, Map<String, int>>{};
    final mine = <String, Set<String>>{};
    for (final r in rows) {
      (counts[r.messageId] ??= {})
          .update(r.emoji, (v) => v + 1, ifAbsent: () => 1);
      if (r.userId == _uid) (mine[r.messageId] ??= {}).add(r.emoji);
    }
    if (mounted) {
      setState(() {
        _reactionCounts = counts;
        _myReactions = mine;
      });
    }
  }

  void _toggleReaction(String messageId, String emoji) {
    HapticFeedback.selectionClick();
    final repo = ref.read(cloudRepositoryProvider);
    final mineNow = _myReactions[messageId]?.contains(emoji) ?? false;

    // Optimistic local update so add/unsend feels instant; the realtime stream
    // then overwrites these maps with the authoritative counts.
    final mine = {...(_myReactions[messageId] ?? const <String>{})};
    final counts = {...(_reactionCounts[messageId] ?? const <String, int>{})};
    if (mineNow) {
      mine.remove(emoji);
      final c = (counts[emoji] ?? 1) - 1;
      if (c <= 0) {
        counts.remove(emoji);
      } else {
        counts[emoji] = c;
      }
    } else {
      mine.add(emoji);
      counts[emoji] = (counts[emoji] ?? 0) + 1;
    }
    setState(() {
      _myReactions = {..._myReactions, messageId: mine};
      _reactionCounts = {..._reactionCounts, messageId: counts};
    });

    if (mineNow) {
      repo.removeReaction(messageId, emoji);
    } else {
      repo.addReaction(messageId, widget.pod.id, emoji);
    }
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
    } catch (_) {
      /* roster is best-effort */
    } finally {
      // Flag it either way so the chat doesn't wait forever if the roster fails.
      if (mounted) setState(() => _membersLoaded = true);
    }
  }

  Future<void> _loadEngagement() async {
    final repo = ref.read(cloudRepositoryProvider);
    try {
      final promptF = repo.todaysPrompt(widget.pod.id);
      final stateF = repo.todaysCheckInState(widget.pod.id);
      final prompt = await promptF;
      final state = await stateF;
      if (!mounted) return;
      setState(() {
        _prompt = prompt;
        _todayCheckIns = state.count;
        _checkedInToday = state.checkedIn;
      });
    } catch (_) {/* best-effort */}
  }

  @override
  void dispose() {
    unawaited(ref.read(cloudRepositoryProvider).markPodSeen(widget.pod.id));
    _reactionSub?.cancel();
    _scroll.removeListener(_onScroll);
    _input.dispose();
    _inputFocus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty) return;

    // Soft-block obvious abuse before it ever leaves the device (send or edit).
    if (ContentGuard.isAbusive(text)) {
      _snack("Let's keep pods kind — please rephrase that.");
      return;
    }
    final editing = _editing;
    final replyingTo = _replyingTo;
    _input.clear();
    setState(() {
      _editing = null;
      _replyingTo = null;
    });
    try {
      final repo = ref.read(cloudRepositoryProvider);
      if (editing != null) {
        await repo.editMessage(editing.id, text);
      } else {
        await repo.sendMessage(widget.pod.id, text, replyTo: replyingTo?.id);
        unawaited(repo.markPodSeen(widget.pod.id));
        ref.read(analyticsProvider).capture(Ev.messageSent); // never log body
      }
    } on CloudActionException catch (e) {
      _snack(e.message);
      return;
    }
    // Surface support if a NEW message signals distress (never blocks sending).
    if (mounted && editing == null && ContentGuard.isDistress(text)) {
      await showSupportSheet(context);
    }
  }

  Future<void> _checkInToday() async {
    if (_checkedInToday) return;
    try {
      final res = await ref.read(cloudRepositoryProvider).checkInToday(widget.pod.id);
      if (!mounted) return;
      setState(() {
        _checkedInToday = res.checkedIn;
        _todayCheckIns = res.count;
      });
      _snack('Nice work. Pod check-in posted.');
    } catch (_) {
      _snack('Could not check in right now. Try again.');
    }
  }

  void _startReply(CloudMessage m) {
    setState(() {
      _replyingTo = m;
      _editing = null;
    });
    _inputFocus.requestFocus();
  }

  void _startEdit(CloudMessage m) {
    setState(() {
      _editing = m;
      _replyingTo = null;
      _input.text = m.body;
      _input.selection =
          TextSelection.collapsed(offset: _input.text.length);
    });
    _inputFocus.requestFocus();
  }

  void _cancelCompose() {
    setState(() {
      _replyingTo = null;
      if (_editing != null) _input.clear();
      _editing = null;
    });
  }

  Future<void> _deleteMessage(CloudMessage m) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Delete message?'),
        content: const Text('This removes it for everyone in the pod.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(d).pop(false),
              child: const Text('Cancel')),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.intensityHigh),
              onPressed: () => Navigator.of(d).pop(true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ref.read(cloudRepositoryProvider).deleteMessage(m.id);
    } on CloudActionException catch (e) {
      _snack(e.message);
    }
  }

  /// Long-press menu: reply to any message; edit/delete only your own.
  void _messageActions(CloudMessage m, bool mine) {
    if (m.isDeleted) return;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      useRootNavigator: true,
      builder: (sheetCtx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick reactions — one scrollable row (keeps the sheet short even
            // with many emojis; swipe sideways for more).
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: Insets.md),
                children: [
                  for (final e in _reactionEmojis)
                    _ReactPick(
                      emoji: e,
                      selected: _myReactions[m.id]?.contains(e) ?? false,
                      onTap: () {
                        Navigator.of(sheetCtx).pop();
                        _toggleReaction(m.id, e);
                      },
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.reply_rounded),
              title: const Text('Reply'),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                _startReply(m);
              },
            ),
            if (mine) ...[
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.of(sheetCtx).pop();
                  _startEdit(m);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.intensityHigh),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.of(sheetCtx).pop();
                  _deleteMessage(m);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _snack(String msg) {
    if (!mounted) return; // guard: called after awaits / from callbacks
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)),
    );
  }

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
            avatarId: p.avatarId,
            isPremium: p.isPremium,
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
      avatarId: p.avatarId,
      isPremium: p.isPremium,
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
          if (_prompt != null)
            Container(
              margin: const EdgeInsets.fromLTRB(Insets.md, Insets.sm, Insets.md, 0),
              padding: const EdgeInsets.all(Insets.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: Radii.card,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.wb_twilight_outlined,
                          size: 18, color: AppColors.primaryDeep),
                      const SizedBox(width: Insets.xs),
                      Text('Daily pod prompt',
                          style: t.titleSmall?.copyWith(
                              color: AppColors.primaryDeep,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: Insets.xs),
                  Text(_prompt!.prompt, style: t.bodyMedium),
                  const SizedBox(height: Insets.sm),
                  Row(
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: _checkedInToday ? null : _checkInToday,
                        icon: Icon(_checkedInToday
                            ? Icons.check_circle_rounded
                            : Icons.task_alt_outlined),
                        label: Text(_checkedInToday
                            ? 'Checked in today'
                            : "I did my step"),
                      ),
                      const SizedBox(width: Insets.sm),
                      Text('$_todayCheckIns checked in', style: t.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: StreamBuilder<List<CloudMessage>>(
              stream: stream,
              builder: (context, snap) {
                // First-load spinner only: wait for the roster AND the first
                // batch. After that, keep showing the last messages even while
                // the stream reconnects (load-more swaps the stream) so the
                // ListView is NEVER torn down mid-scroll — tearing it down while
                // scrolling caused "ScrollController attached to multiple scroll
                // views" and a scroll-offset save on a dead context.
                if (!_membersLoaded || (!snap.hasData && _lastMessages.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                }
                final raw = snap.hasData ? snap.data! : _lastMessages;
                _lastMessages = raw;
                _lastCount = raw.length; // gauge whether more pages exist
                final byId = {for (final m in raw) m.id: m}; // reply-parent lookup
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
                    final parent = m.replyTo == null ? null : byId[m.replyTo];
                    String? replyLabel;
                    String? replyText;
                    if (parent != null) {
                      replyLabel = parent.userId == uid
                          ? 'You'
                          : _memberFor(parent.userId).name;
                      replyText =
                          parent.isDeleted ? 'deleted message' : parent.body;
                    }
                    final bubble = _Bubble(
                      message: m,
                      mine: mine,
                      member: member,
                      replyLabel: replyLabel,
                      replyText: replyText,
                      reactions: _reactionCounts[m.id] ?? const {},
                      myReactions: _myReactions[m.id] ?? const {},
                      onToggleReaction: (e) => _toggleReaction(m.id, e),
                      onAvatarTap:
                          member == null ? null : () => _openMember(m),
                      onLongPress:
                          m.isDeleted ? null : () => _messageActions(m, mine),
                    );
                    // WhatsApp-style: swipe a message right to reply. Long-press
                    // still opens the full actions menu. Deleted messages don't
                    // swipe (nothing to reply to).
                    if (m.isDeleted) return bubble;
                    return _SwipeToReply(
                      onReply: () => _startReply(m),
                      child: bubble,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_replyingTo != null || _editing != null)
                    _ComposeBanner(
                      editing: _editing != null,
                      // Reply preview: whose message + a snippet.
                      label: _editing != null
                          ? 'Editing your message'
                          : 'Replying to ${(_replyingTo!.userId == (ref.read(authRepositoryProvider).currentUser?.id)) ? 'yourself' : _memberFor(_replyingTo!.userId).name}',
                      snippet: _editing != null ? null : _replyingTo!.body,
                      onCancel: _cancelCompose,
                    ),
                  Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      focusNode: _inputFocus,
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
    required this.message,
    required this.mine,
    this.member,
    this.replyLabel,
    this.replyText,
    this.reactions = const {},
    this.myReactions = const {},
    required this.onToggleReaction,
    this.onAvatarTap,
    this.onLongPress,
  });
  final CloudMessage message;
  final bool mine;
  final Member? member;
  final String? replyLabel; // sender of the replied-to message
  final String? replyText; // snippet of the replied-to message
  final Map<String, int> reactions; // emoji → count
  final Set<String> myReactions; // emojis the current user added
  final void Function(String emoji) onToggleReaction;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final m = member;
    final textColor =
        mine ? Colors.white : Theme.of(context).colorScheme.onSurface;

    Widget content;
    if (message.isDeleted) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.block_rounded,
              size: 15, color: textColor.withValues(alpha: 0.5)),
          const SizedBox(width: 6),
          Text('This message was deleted',
              style: t.bodyMedium?.copyWith(
                  color: textColor.withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic)),
        ],
      );
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!mine && m != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(m.locked ? 'Private member' : m.name,
                      overflow: TextOverflow.ellipsis,
                      style: t.bodyMedium?.copyWith(
                          color: AppColors.primaryDeep,
                          fontWeight: FontWeight.w700)),
                ),
                if (m.isPremium && !m.locked) ...[
                  const SizedBox(width: 3),
                  const Text('✨', style: TextStyle(fontSize: 11)),
                ],
              ],
            ),
          if (!mine && m != null) const SizedBox(height: 2),
          if (replyLabel != null) _replyQuote(context, textColor),
          Text(message.body, style: t.bodyLarge?.copyWith(color: textColor)),
          if (message.isEdited)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('edited',
                  style: t.bodySmall
                      ?.copyWith(color: textColor.withValues(alpha: 0.55))),
            ),
          if (reactions.isNotEmpty) _reactionChips(context),
        ],
      );
    }

    final bubble = GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(Insets.md),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
        decoration: BoxDecoration(
          color: message.isDeleted
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : (mine
                  ? AppColors.primary
                  : Theme.of(context).colorScheme.surface),
          borderRadius: BorderRadius.only(
            topLeft: Radii.md,
            topRight: Radii.md,
            bottomLeft: Radius.circular(mine ? 16 : 4),
            bottomRight: Radius.circular(mine ? 4 : 16),
          ),
          border: (mine || message.isDeleted)
              ? null
              : Border.all(color: AppColors.border),
        ),
        child: content,
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
            child: UserAvatar(
              radius: 16,
              locked: m?.locked ?? true,
              avatarId: m?.avatarId,
              name: m?.name,
            ),
          ),
          const SizedBox(width: Insets.sm),
          Flexible(child: bubble),
        ],
      ),
    );
  }

  Widget _reactionChips(BuildContext context) {
    final onBubble = mine; // teal bubble → light chips; else tinted chips
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          for (final entry in reactions.entries)
            GestureDetector(
              onTap: () => onToggleReaction(entry.key),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: Radii.pill,
                  color: myReactions.contains(entry.key)
                      ? (onBubble
                          ? Colors.white.withValues(alpha: 0.30)
                          : AppColors.primary.withValues(alpha: 0.18))
                      : (onBubble
                          ? Colors.white.withValues(alpha: 0.15)
                          : Theme.of(context).colorScheme.surface),
                  border: Border.all(
                    color: myReactions.contains(entry.key)
                        ? (onBubble ? Colors.white : AppColors.primary)
                        : (onBubble
                            ? Colors.white.withValues(alpha: 0.30)
                            : AppColors.border),
                  ),
                ),
                child: Text(
                  '${entry.key} ${entry.value}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: onBubble ? Colors.white : AppColors.primaryDeep,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _replyQuote(BuildContext context, Color textColor) {
    final t = Theme.of(context).textTheme;
    final accent = mine ? Colors.white : AppColors.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(replyLabel!,
              style: t.bodySmall
                  ?.copyWith(color: textColor, fontWeight: FontWeight.w700)),
          Text(replyText ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  t.bodySmall?.copyWith(color: textColor.withValues(alpha: 0.75))),
        ],
      ),
    );
  }
}

/// The strip above the composer when replying to / editing a message.
class _ComposeBanner extends StatelessWidget {
  const _ComposeBanner({
    required this.editing,
    required this.label,
    required this.onCancel,
    this.snippet,
  });
  final bool editing;
  final String label;
  final String? snippet;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      padding: const EdgeInsets.fromLTRB(Insets.md, Insets.sm, 4, Insets.sm),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: Radii.card,
        border: const Border(
            left: BorderSide(color: AppColors.primary, width: 3)),
      ),
      child: Row(
        children: [
          Icon(editing ? Icons.edit_outlined : Icons.reply_rounded,
              size: 18, color: AppColors.primaryDeep),
          const SizedBox(width: Insets.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label,
                    style: t.bodyMedium?.copyWith(
                        color: AppColors.primaryDeep,
                        fontWeight: FontWeight.w700)),
                if (snippet != null && snippet!.isNotEmpty)
                  Text(snippet!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.bodySmall),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            onPressed: onCancel,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

/// One emoji in the quick-reaction row of the message actions sheet.
class _ReactPick extends StatelessWidget {
  const _ReactPick(
      {required this.emoji, required this.selected, required this.onTap});
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? AppColors.primary.withValues(alpha: 0.18)
              : Colors.transparent,
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

/// WhatsApp-style swipe-to-reply. Dragging a message to the right reveals a
/// reply icon; releasing past the threshold triggers [onReply] and springs the
/// bubble back. Uses Transform.translate (no layout change) so it's light and
/// coexists with the list's vertical scroll.
class _SwipeToReply extends StatefulWidget {
  const _SwipeToReply({required this.child, required this.onReply});
  final Widget child;
  final VoidCallback onReply;

  @override
  State<_SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<_SwipeToReply>
    with SingleTickerProviderStateMixin {
  static const _max = 76.0; // how far the bubble can slide
  static const _trigger = 52.0; // release past this → reply
  double _dx = 0;
  bool _armed = false; // crossed the trigger during this drag (for one haptic)

  // Created eagerly in initState (NOT `late final`): a lazy `late final` would
  // otherwise initialize on first access inside dispose() — building an
  // AnimationController (vsync: this → TickerMode lookup) on a dead context.
  late final AnimationController _spring;

  @override
  void initState() {
    super.initState();
    _spring = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  void dispose() {
    _spring.dispose();
    super.dispose();
  }

  void _onUpdate(DragUpdateDetails d) {
    final next = (_dx + d.delta.dx).clamp(0.0, _max);
    if (!_armed && next >= _trigger) {
      _armed = true;
      HapticFeedback.selectionClick();
    }
    setState(() => _dx = next);
  }

  void _onEnd(DragEndDetails _) {
    final triggered = _dx >= _trigger;
    _armed = false;
    final from = _dx;
    final anim = Tween<double>(begin: from, end: 0).animate(
        CurvedAnimation(parent: _spring, curve: Curves.easeOut));
    void tick() {
      if (mounted) setState(() => _dx = anim.value);
    }

    anim.addListener(tick);
    _spring
      ..reset()
      ..forward().whenComplete(() => anim.removeListener(tick));
    // Defer the reply trigger to after this frame so we don't rebuild the list
    // (and move focus) in the middle of the drag-end gesture.
    if (triggered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onReply();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final revealed = (_dx / _trigger).clamp(0.0, 1.0);
    return GestureDetector(
      onHorizontalDragUpdate: _onUpdate,
      onHorizontalDragEnd: _onEnd,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Opacity(
                  opacity: revealed,
                  child: Transform.scale(
                    scale: 0.5 + revealed * 0.5,
                    child: Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.16),
                      ),
                      child: const Icon(Icons.reply_rounded,
                          size: 18, color: AppColors.primaryDeep),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(_dx, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
