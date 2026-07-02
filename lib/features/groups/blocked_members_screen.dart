import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/remote/cloud_models.dart';
import '../../shared/avatars.dart';

/// See and unblock people you've blocked. Values come from the server
/// (blocked ids + their visible profiles). Deliberately simple render widgets —
/// a fixed-width SizedBox + Row + tappable Text — so no button min-size can ever
/// be handed an unbounded width (which was blanking the screen).
class BlockedMembersScreen extends ConsumerStatefulWidget {
  const BlockedMembersScreen({super.key});

  @override
  ConsumerState<BlockedMembersScreen> createState() =>
      _BlockedMembersScreenState();
}

class _BlockedMembersScreenState extends ConsumerState<BlockedMembersScreen> {
  bool _loading = true;
  List<String> _ids = [];
  Map<String, CloudProfile> _profiles = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final repo = ref.read(cloudRepositoryProvider);
      final ids = await repo.blockedUserIds();
      final profiles = await repo.visibleProfiles(ids);
      if (!mounted) return;
      setState(() {
        _ids = ids;
        _profiles = profiles;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _unblock(String id) async {
    HapticFeedback.selectionClick();
    final messenger = ScaffoldMessenger.of(context);
    final name = _nameFor(id);
    setState(() => _ids = _ids.where((x) => x != id).toList());
    try {
      await ref.read(cloudRepositoryProvider).unblockUser(id);
    } catch (_) {
      // Put it back if the server call failed.
      if (mounted && !_ids.contains(id)) setState(() => _ids = [..._ids, id]);
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Could not unblock. Try again.'),
      ));
      return;
    }
    messenger.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text("Unblocked $name. You'll see their messages again."),
    ));
  }

  String _nameFor(String id) {
    final n = _profiles[id]?.displayName?.trim();
    return (n == null || n.isEmpty) ? 'Member' : n;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(title: const Text('Blocked members')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _ids.isEmpty
              ? const _EmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                      Insets.lg, Insets.md, Insets.lg, Insets.xl),
                  itemCount: _ids.length + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) return const _Intro();
                    final id = _ids[i - 1];
                    // Fixed finite width — never let an unbounded layout pass
                    // through to the row.
                    return SizedBox(
                      width: width - Insets.lg * 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: Insets.sm),
                        child: _BlockedCard(
                          name: _nameFor(id),
                          avatarId: _profiles[id]?.avatarId,
                          onUnblock: () => _unblock(id),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Text(
        "Blocking hides a member's messages from you — and yours from them, "
        'both ways. Unblock anyone below to undo it.',
        style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
      ),
    );
  }
}

class _BlockedCard extends StatelessWidget {
  const _BlockedCard(
      {required this.name, this.avatarId, required this.onUnblock});
  final String name;
  final String? avatarId;
  final VoidCallback onUnblock;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.md, vertical: Insets.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          UserAvatar(avatarId: avatarId, name: name, radius: 22),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.titleSmall),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.block_rounded,
                        size: 13, color: AppColors.inkMuted),
                    const SizedBox(width: 4),
                    Text('Blocked',
                        style:
                            t.bodySmall?.copyWith(color: AppColors.inkMuted)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: Insets.sm),
          // Tappable pill — a GestureDetector (no button min-size) styled to
          // look like an outlined action.
          GestureDetector(
            onTap: onUnblock,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: Radii.pill,
                border: Border.all(color: AppColors.primary),
              ),
              child: Text(
                'Unblock',
                style: t.labelLarge?.copyWith(
                    color: AppColors.primaryDeep, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Insets.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.10),
              ),
              child: const Icon(Icons.verified_user_outlined,
                  size: 34, color: AppColors.primary),
            ),
            const SizedBox(height: Insets.lg),
            Text('No one blocked', style: t.titleLarge),
            const SizedBox(height: Insets.sm),
            Text(
              "You haven't blocked anyone. Blocking hides a member's messages "
              'from you, both ways — and you can always undo it here.',
              textAlign: TextAlign.center,
              style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
            ),
          ],
        ),
      ),
    );
  }
}
