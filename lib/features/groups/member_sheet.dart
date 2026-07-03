import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/avatars.dart';
import 'pod_models.dart';

/// WhatsApp-style member detail sheet. Honours the privacy lock, and (when
/// opened from a real cloud message) wires real Block + Report via Supabase.
Future<void> showMemberSheet(
  BuildContext context,
  Member member, {
  String? userId,
  String? messageId,
  String? groupId,
  void Function(String userId)? onBlocked,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    // Present on the ROOT navigator, not the tab's branch navigator. A sheet on
    // the branch navigator shares the semantics tree with the always-mounted
    // sibling tabs, and dismissing it mid-frame trips '!semantics.parentDataDirty'
    // (blank screen). Root presentation isolates it above the whole shell.
    useRootNavigator: true,
    builder: (_) => _MemberSheet(
      member: member,
      userId: userId,
      messageId: messageId,
      groupId: groupId,
      onBlocked: onBlocked,
    ),
  );
}

const _reportReasons = [
  'Harassment or bullying',
  'Hate or harmful language',
  'Spam or scam',
  'Makes me feel unsafe',
  'Something else',
];

class _MemberSheet extends ConsumerWidget {
  const _MemberSheet({
    required this.member,
    this.userId,
    this.messageId,
    this.groupId,
    this.onBlocked,
  });
  final Member member;
  final String? userId;
  final String? messageId;
  final String? groupId;
  final void Function(String userId)? onBlocked;

  bool get _cloudActions => userId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    final cloud = ref.watch(cloudEnabledProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(
              radius: 40,
              locked: member.locked,
              avatarId: member.avatarId,
              name: member.name,
            ),
            const SizedBox(height: Insets.md),
            if (member.locked) ...[
              Text('Private profile', style: t.titleLarge),
              const SizedBox(height: Insets.sm),
              Text(
                'This member keeps their profile private. You can still chat '
                'with them — and report or block if needed.',
                textAlign: TextAlign.center,
                style: t.bodyMedium,
              ),
            ] else ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Text(member.name,
                          overflow: TextOverflow.ellipsis,
                          style: t.headlineSmall)),
                  if (member.isPremium) ...[
                    const SizedBox(width: 6),
                    const _PremiumTag(),
                  ],
                ],
              ),
              if (member.bio.isNotEmpty) ...[
                const SizedBox(height: Insets.sm),
                Text(member.bio,
                    textAlign: TextAlign.center, style: t.bodyLarge),
              ],
              const SizedBox(height: Insets.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Chip(
                      icon: Icons.local_fire_department_rounded,
                      text: '${member.streak}-day streak'),
                  const SizedBox(width: Insets.sm),
                  _Chip(
                      icon: Icons.done_all_rounded,
                      text: '${member.challenges} challenges'),
                ],
              ),
              if (member.climbing.isNotEmpty) ...[
                const SizedBox(height: Insets.sm),
                _Chip(
                    icon: Icons.stairs_rounded,
                    text: 'Climbing: ${member.climbing}'),
              ],
            ],
            const SizedBox(height: Insets.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _report(context, ref, cloud),
                    icon: const Icon(Icons.flag_outlined, size: 18),
                    label: const Text('Report'),
                  ),
                ),
                const SizedBox(width: Insets.md),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.intensityHigh),
                    onPressed: () => _block(context, ref, cloud),
                    icon: const Icon(Icons.block_rounded, size: 18),
                    label: const Text('Block'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _report(BuildContext context, WidgetRef ref, bool cloud) async {
    if (!_cloudActions || !cloud) {
      _soon(context, 'Reporting');
      return;
    }
    final reason = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      useRootNavigator: true,
      builder: (_) => _ReasonPicker(),
    );
    if (reason == null) return;
    final repo = ref.read(cloudRepositoryProvider);
    try {
      if (messageId != null) {
        await repo.reportMessage(messageId!, reason);
      } else if (groupId != null) {
        await repo.reportUser(userId!, groupId!, reason);
      }
      if (context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop(); // close the member sheet
        messenger.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 6),
          content: const Text("Thanks — we'll review this."),
          action: SnackBarAction(
            label: 'Block too',
            onPressed: () async {
              try {
                await repo.blockUser(userId!);
                onBlocked?.call(userId!);
                messenger.showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Blocked. You won't see their messages."),
                ));
              } catch (_) {
                messenger.showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Could not block. Try again.'),
                ));
              }
            },
          ),
        ));
      }
    } catch (_) {
      if (context.mounted) _toast(context, 'Could not send report. Try again.');
    }
  }

  Future<void> _block(BuildContext context, WidgetRef ref, bool cloud) async {
    if (!_cloudActions || !cloud) {
      _soon(context, 'Blocking');
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      useRootNavigator: true,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Block this member?'),
        content: const Text(
            "You won't see each other's messages. You can undo this later."),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.of(dialogCtx).pop(true),
              child: const Text('Block')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final repo = ref.read(cloudRepositoryProvider);
    // Capture messenger + navigator BEFORE popping — after pop the sheet's
    // context is deactivated and looking either up would throw.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await repo.blockUser(userId!);
      onBlocked?.call(userId!);
      navigator.pop();
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Blocked. You won't see their messages."),
      ));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Could not block. Try again.'),
      ));
    }
  }

  void _soon(BuildContext context, String what) {
    Navigator.of(context).pop();
    _toast(context, '$what goes live in moderated pods (sign in to use it).');
  }

  void _toast(BuildContext context, String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)),
      );
}

class _PremiumTag extends StatelessWidget {
  const _PremiumTag();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.18),
        borderRadius: Radii.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('✨', style: TextStyle(fontSize: 11)),
          const SizedBox(width: 3),
          Text('Premium',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.accentDeep, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _ReasonPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.sm),
            child: Text("What's wrong?", style: t.titleLarge),
          ),
          for (final r in _reportReasons)
            ListTile(
              title: Text(r),
              onTap: () => Navigator.of(context).pop(r),
            ),
          const SizedBox(height: Insets.sm),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, this.icon = Icons.stairs_rounded});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Insets.md, vertical: Insets.sm),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: Radii.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryDeep),
          const SizedBox(width: 6),
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryDeep)),
        ],
      ),
    );
  }
}
