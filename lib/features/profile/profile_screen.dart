import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/analytics/analytics.dart';
import '../../data/notifications/notification_service.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../shared/avatars.dart';
import '../groups/blocked_members_screen.dart';
import '../legal/legal_screens.dart';
import 'edit_profile_sheet.dart';
import 'profile_sync.dart';
import 'safety_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    final t = Theme.of(context).textTheme;
    final name = settings.displayName;
    final tier = settings.subscriptionTier;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(Insets.lg),
        children: [
          // ── Identity header ────────────────────────────────────────────
          Row(
            children: [
              _Avatar(
                name: name,
                locked: settings.profileLocked,
                avatarId: settings.avatarId,
                onTap: () => showAvatarPickerSheet(context, ref),
              ),
              const SizedBox(width: Insets.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? 'Add your name',
                        style: t.titleLarge?.copyWith(
                            color: name == null ? AppColors.inkFaint : null)),
                    const SizedBox(height: 2),
                    Text(
                      settings.bio?.isNotEmpty == true
                          ? settings.bio!
                          : 'A quiet climber.',
                      style: t.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: () => showEditProfileSheet(context, ref),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          const SizedBox(height: Insets.lg),

          // ── Privacy: profile lock ──────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: Radii.card,
              border: Border.all(color: AppColors.border),
            ),
            child: SwitchListTile(
              value: settings.profileLocked,
              onChanged: (v) async {
                await settings.setProfileLocked(v);
                await pushIdentityToCloud(ref); // reflect lock for pod members now
              },
              secondary: Icon(
                settings.profileLocked
                    ? Icons.lock_outline_rounded
                    : Icons.lock_open_rounded,
                color: AppColors.primary,
              ),
              title: const Text('Lock my profile'),
              subtitle: Text(settings.profileLocked
                  ? 'Hidden — pod members can\'t open your details.'
                  : 'Pod members can tap your avatar to see your details.'),
            ),
          ),
          const SizedBox(height: Insets.lg),

          // ── Plan ───────────────────────────────────────────────────────
          _Tile(
            icon: Icons.workspace_premium_outlined,
            title: 'Your plan',
            subtitle: tier.label,
            onTap: () => context.go(Routes.subscription),
            trailingText: tier.isPremium ? 'Premium' : 'Upgrade',
          ),
          const Divider(height: Insets.lg),

          Text('Your tone', style: t.titleMedium),
          const SizedBox(height: Insets.sm),
          Text(
            'Rung speaks gently by default. If your anxiety is more situational, '
            'a slightly bolder tone may suit you better.',
            style: t.bodyMedium,
          ),
          const SizedBox(height: Insets.md),
          SegmentedButton<ToneMode>(
            segments: const [
              ButtonSegment(
                  value: ToneMode.introvert,
                  label: Text('Introvert'),
                  icon: Icon(Icons.spa_outlined)),
              ButtonSegment(
                  value: ToneMode.situational,
                  label: Text('Situational'),
                  icon: Icon(Icons.bolt_outlined)),
            ],
            selected: {settings.toneMode},
            onSelectionChanged: (s) => settings.setToneMode(s.first),
          ),
          const SizedBox(height: Insets.xl),
          Text('Appearance', style: t.titleMedium),
          const SizedBox(height: Insets.md),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('System')),
              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (s) => settings.setThemeMode(s.first),
          ),
          const SizedBox(height: Insets.xl),
          const _NotificationControls(),
          const SizedBox(height: Insets.lg),
          const _ReminderControl(),
          const Divider(height: Insets.lg),
          _Tile(
            icon: Icons.health_and_safety_outlined,
            title: 'Is this right for me?',
            subtitle: 'How Rung fits — and when to seek more',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const SafetyScreen()),
            ),
          ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.block_rounded,
              title: 'Blocked members',
              subtitle: "See and unblock people you've blocked",
              onTap: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (_) => const BlockedMembersScreen()),
              ),
            ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.cloud_sync_rounded,
              title: 'Restore my progress',
              subtitle: 'Pull your streak & challenges from the cloud',
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final sync = ref.read(syncServiceProvider);
                messenger.showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Restoring…'),
                ));
                final ok = await sync.restoreFromCloud();
                messenger.hideCurrentSnackBar();
                messenger.showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 6),
                  content: Text(ok
                      ? 'Progress restored from the cloud.'
                      : 'Restore failed: ${sync.lastError ?? "unknown error"}'),
                ));
              },
            ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.logout_rounded,
              title: 'Log out',
              subtitle:
                  ref.watch(authUserProvider).asData?.value?.email ?? 'Signed in',
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (dialogCtx) => AlertDialog(
                    title: const Text('Log out?'),
                    content: const Text(
                        'Your progress is saved to the cloud and comes back '
                        'when you sign in again.'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(false),
                          child: const Text('Cancel')),
                      FilledButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(true),
                          child: const Text('Log out')),
                    ],
                  ),
                );
                if (confirmed != true) return;
                HapticFeedback.mediumImpact();
                messenger.showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Logging out…'),
                ));
                // Flush any unsaved progress to the cloud BEFORE logging out, so
                // it can be restored next sign-in (no lost rungs on switch), and
                // remove this device's push token so it stops getting pushes.
                await ref.read(syncServiceProvider).backupNow();
                await ref.read(pushServiceProvider).unregister();
                await ref.read(purchaseServiceProvider).logOut();
                ref.read(analyticsProvider).reset();
                await ref.read(authRepositoryProvider).signOut();
              },
            ),
          const Divider(height: Insets.lg),
          _Tile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'What we store — and what stays on your device',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
            ),
          ),
          _Tile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'The agreement for using Rung',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const TermsScreen()),
            ),
          ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.delete_outline_rounded,
              iconColor: AppColors.intensityHigh,
              title: 'Delete account',
              subtitle: 'Permanently erase your account and data',
              onTap: () => _deleteAccount(context, ref),
            ),
          const SizedBox(height: Insets.lg),
          Center(
            child: Text(
              'Rung · practice, not therapy. Your data is yours.',
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete account?'),
        content: const Text(
            'This permanently deletes your account, your pod messages, and your '
            'saved progress. This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(false),
              child: const Text('Cancel')),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.intensityHigh),
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    messenger.showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Deleting your account…'),
    ));
    try {
      await ref.read(cloudRepositoryProvider).deleteAccount();
    } catch (_) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Could not delete your account. Try again.'),
      ));
      return;
    }
    // Wipe everything local so nothing of the deleted account lingers, then
    // sign out — the gate sends us back to the sign-in screen.
    final settings = ref.read(settingsRepositoryProvider);
    ref.read(databaseProvider).resetUserData();
    await settings.setLastUserId(null);
    await settings.setDisplayName(null);
    await settings.setBio(null);
    await settings.setProfileLocked(false);
    await settings.setSubscriptionTier(SubscriptionTier.free);
    ref.read(analyticsProvider).reset();
    await ref.read(authRepositoryProvider).signOut();
  }
}

/// Notification switches: a master push toggle (off removes the device token),
/// and a finer "pod message alerts" toggle (mirrored to the cloud so the notify
/// function skips muted users). Hidden entirely when cloud is off.
class _NotificationControls extends ConsumerWidget {
  const _NotificationControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    if (!ref.watch(cloudEnabledProvider)) return const SizedBox.shrink();
    final settings = ref.watch(settingsRepositoryProvider);
    final pushOn = settings.pushEnabled;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined,
                color: AppColors.primary),
            title: const Text('Notifications'),
            subtitle: const Text('Alerts from Rung on this device'),
            value: pushOn,
            onChanged: (v) async {
              await settings.setPushEnabled(v);
              final push = ref.read(pushServiceProvider);
              if (v) {
                await push.registerForUser();
              } else {
                await push.unregister();
              }
            },
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary:
                const Icon(Icons.forum_outlined, color: AppColors.primary),
            title: const Text('Pod message alerts'),
            subtitle: const Text('Tell me when someone posts in my pods'),
            value: pushOn && settings.podAlertsEnabled,
            onChanged: pushOn
                ? (v) async {
                    await settings.setPodAlertsEnabled(v);
                    await ref.read(cloudRepositoryProvider).setPodAlerts(v);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

/// Opt-in gentle daily reminder — schedules a local notification (§7.4).
class _ReminderControl extends ConsumerWidget {
  const _ReminderControl();

  Future<void> _enable(BuildContext context, WidgetRef ref) async {
    final granted = await NotificationService.instance.requestPermission();
    if (!context.mounted) return;
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Enable notifications in Settings to get reminders.'),
      ));
      return;
    }
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: 'When should we nudge you?',
    );
    if (picked == null) return;
    await NotificationService.instance.scheduleDaily(picked);
    await ref.read(settingsRepositoryProvider).setReminderTime(picked);
    ref.read(analyticsProvider).capture(Ev.reminderEnabled,
        {'hour': picked.hour});
  }

  Future<void> _disable(WidgetRef ref) async {
    await NotificationService.instance.cancelDaily();
    await ref.read(settingsRepositoryProvider).setReminderTime(null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    final time = ref.watch(settingsRepositoryProvider).reminderTime;
    final on = time != null;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: SwitchListTile(
        value: on,
        onChanged: (v) => v ? _enable(context, ref) : _disable(ref),
        secondary: const Icon(Icons.notifications_none_rounded,
            color: AppColors.primary),
        title: const Text('Gentle daily reminder'),
        subtitle: Text(on
            ? 'Every day at ${time.format(context)} · tap the switch to turn off'
            : 'A calm, no-guilt nudge to take one small step'),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.name,
    required this.locked,
    this.avatarId,
    this.onTap,
  });
  final String? name;
  final bool locked;
  final String? avatarId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Own profile: always show my avatar (not the lock icon); the badge signals
    // locked / that it's tappable to change.
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          UserAvatar(avatarId: avatarId, name: name, radius: 32),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).colorScheme.surface, width: 2),
              ),
              child: Icon(locked ? Icons.lock_rounded : Icons.edit_rounded,
                  size: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom-sheet grid to pick an avatar (or "my initial"). Saves locally +
/// pushes to the cloud profile so pod-mates see it.
Future<void> showAvatarPickerSheet(BuildContext context, WidgetRef ref) {
  final settings = ref.read(settingsRepositoryProvider);
  final name = settings.displayName;
  final current = settings.avatarId;

  void choose(String? id) {
    settings.setAvatarId(id);
    pushIdentityToCloud(ref); // fire-and-forget; UI updates via settings change
  }

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useRootNavigator: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (sheetCtx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose your avatar',
                style: Theme.of(sheetCtx).textTheme.titleLarge),
            const SizedBox(height: Insets.xs),
            Text('Only you can change it — pod-mates see it too.',
                style: Theme.of(sheetCtx)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.inkMuted)),
            const SizedBox(height: Insets.lg),
            // Scroll if the grid is taller than the sheet (avoids a Column
            // overflow when there are many avatars / a short sheet).
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: Insets.md,
                  runSpacing: Insets.md,
                  children: [
                    _AvatarOption(
                      name: name,
                      selected: current == null,
                      onTap: () {
                        Navigator.of(sheetCtx).pop();
                        choose(null);
                      },
                    ),
                    for (final e in Avatars.options)
                      _AvatarOption(
                        avatarId: e.key,
                        selected: current == e.key,
                        onTap: () {
                          Navigator.of(sheetCtx).pop();
                          choose(e.key);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _AvatarOption extends StatelessWidget {
  const _AvatarOption({
    this.avatarId,
    this.name,
    required this.selected,
    required this.onTap,
  });
  final String? avatarId;
  final String? name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            UserAvatar(avatarId: avatarId, name: name, radius: 26),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailingText,
    this.iconColor,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final String? trailingText;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailingText != null
          ? Text(trailingText!,
              style: const TextStyle(
                  color: AppColors.primaryDeep, fontWeight: FontWeight.w700))
          : const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
      onTap: onTap,
    );
  }
}
