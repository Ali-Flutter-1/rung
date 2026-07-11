import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/errors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../core/analytics/analytics.dart';
import '../../data/notifications/notification_service.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../shared/avatars.dart';
import '../feedback/rate_app_sheet.dart';
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
    final l = AppLocalizations.of(context);
    final name = settings.displayName;
    final tier = settings.subscriptionTier;

    return Scaffold(
      appBar: AppBar(title: Text(l.profileTitle)),
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
                    Text(name ?? l.profileAddName,
                        style: t.titleLarge?.copyWith(
                            color: name == null ? AppColors.inkFaint : null)),
                    const SizedBox(height: 2),
                    Text(
                      settings.bio?.isNotEmpty == true
                          ? settings.bio!
                          : l.profileBioPlaceholder,
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
              title: Text(l.profileLockTitle),
              subtitle: Text(settings.profileLocked
                  ? l.profileLockedSub
                  : l.profileUnlockedSub),
            ),
          ),
          const SizedBox(height: Insets.lg),

          // ── Plan ───────────────────────────────────────────────────────
          _Tile(
            icon: Icons.workspace_premium_outlined,
            title: l.profilePlanTitle,
            subtitle: switch (tier) {
              SubscriptionTier.free => l.tierFree,
              SubscriptionTier.monthly => l.tierMonthly,
              SubscriptionTier.yearly => l.tierYearly,
            },
            onTap: () => context.go(Routes.subscription),
            trailingText: tier.isPremium ? l.profilePremium : l.profileUpgrade,
          ),
          const Divider(height: Insets.lg),

          Text(l.yourTone, style: t.titleMedium),
          const SizedBox(height: Insets.sm),
          Text(
            l.profileToneDesc,
            style: t.bodyMedium,
          ),
          const SizedBox(height: Insets.md),
          SegmentedButton<ToneMode>(
            segments: [
              ButtonSegment(
                  value: ToneMode.introvert,
                  label: Text(l.profileToneIntrovert),
                  icon: const Icon(Icons.spa_outlined)),
              ButtonSegment(
                  value: ToneMode.situational,
                  label: Text(l.profileToneSituational),
                  icon: const Icon(Icons.bolt_outlined)),
            ],
            selected: {settings.toneMode},
            onSelectionChanged: (s) => settings.setToneMode(s.first),
          ),
          const SizedBox(height: Insets.xl),
          Text(l.appearance, style: t.titleMedium),
          const SizedBox(height: Insets.md),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(value: ThemeMode.system, label: Text(l.themeSystem)),
              ButtonSegment(value: ThemeMode.light, label: Text(l.themeLight)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l.themeDark)),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (s) => settings.setThemeMode(s.first),
          ),
          const SizedBox(height: Insets.xl),
          Text(l.language, style: t.titleMedium),
          const SizedBox(height: Insets.md),
          const _LanguageControl(),
          const SizedBox(height: Insets.xl),
          const _NotificationControls(),
          const SizedBox(height: Insets.lg),
          const _ReminderControl(),
          const SizedBox(height: Insets.lg),
          const _HapticsControl(),
          const Divider(height: Insets.lg),
          _Tile(
            icon: Icons.health_and_safety_outlined,
            title: l.menuIsThisRight,
            subtitle: l.profileSafetySub,
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const SafetyScreen()),
            ),
          ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.block_rounded,
              title: l.profileBlockedTitle,
              subtitle: l.profileBlockedSub,
              onTap: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (_) => const BlockedMembersScreen()),
              ),
            ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.cloud_sync_rounded,
              title: l.profileRestoreTitle,
              subtitle: l.profileRestoreSub,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final sync = ref.read(syncServiceProvider);
                messenger.showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(l.profileRestoring),
                ));
                final ok = await sync.restoreFromCloud();
                messenger.hideCurrentSnackBar();
                messenger.showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 6),
                  content: Text(ok
                      ? l.profileRestoreOk
                      : isOfflineError(sync.lastError)
                          ? l.errorOffline
                          : l.profileRestoreFail(
                              sync.lastError ?? 'unknown error')),
                ));
              },
            ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.logout_rounded,
              title: l.profileLogout,
              subtitle:
                  ref.watch(authUserProvider).asData?.value?.email ?? l.profileSignedIn,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (dialogCtx) => AlertDialog(
                    title: Text(l.profileLogoutConfirmTitle),
                    content: Text(l.profileLogoutConfirmBody),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(false),
                          child: Text(l.commonCancel)),
                      FilledButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(true),
                          child: Text(l.profileLogout)),
                    ],
                  ),
                );
                if (confirmed != true) return;
                Haptics.medium();
                messenger.showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(l.profileLoggingOut),
                ));
                // Flush any unsaved progress to the cloud BEFORE logging out, so
                // it can be restored next sign-in (no lost rungs on switch), and
                // remove this device's push token so it stops getting pushes.
                // Each step is best-effort: offline, the flush/unregister simply
                // don't happen, but signing out locally must still succeed — so
                // the whole chain is guarded and never crashes the app.
                try {
                  await ref.read(syncServiceProvider).backupNow();
                  await ref.read(pushServiceProvider).unregister();
                  await ref.read(purchaseServiceProvider).logOut();
                  ref.read(analyticsProvider).reset();
                  await ref.read(authRepositoryProvider).signOut();
                } catch (_) {
                  // signOut clears the local session even when offline; the
                  // auth stream will move us out regardless.
                }
              },
            ),
          const Divider(height: Insets.lg),
          _Tile(
            icon: Icons.star_outline_rounded,
            iconColor: AppColors.accent,
            title: l.profileRateTitle,
            subtitle: l.profileRateSub,
            onTap: () => showRateAppSheet(context, ref),
          ),
          _Tile(
            icon: Icons.privacy_tip_outlined,
            title: l.profilePrivacyTitle,
            subtitle: l.profilePrivacySub,
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
            ),
          ),
          _Tile(
            icon: Icons.description_outlined,
            title: l.profileTermsTitle,
            subtitle: l.profileTermsSub,
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const TermsScreen()),
            ),
          ),
          if (ref.watch(cloudEnabledProvider))
            _Tile(
              icon: Icons.delete_outline_rounded,
              iconColor: AppColors.intensityHigh,
              title: l.profileDeleteTitle,
              subtitle: l.profileDeleteSub,
              onTap: () => _deleteAccount(context, ref),
            ),
          const SizedBox(height: Insets.lg),
          Center(
            child: Text(
              l.profileFooter,
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
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l.profileDeleteConfirmTitle),
        content: Text(l.profileDeleteConfirmBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(false),
              child: Text(l.commonCancel)),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.intensityHigh),
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: Text(l.profileDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    messenger.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(l.profileDeleting),
    ));
    try {
      await ref.read(cloudRepositoryProvider).deleteAccount();
    } catch (_) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.profileDeleteFail),
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
/// Master haptics (vibration) on/off. Gates every haptic in the app.
/// Supported UI languages: locale code → native name. Add a language by adding
/// an app_<code>.arb and a line here.
const _languages = <String, String>{
  'en': 'English',
  'es': 'Español',
  'de': 'Deutsch',
  'fr': 'Français',
  'it': 'Italiano',
  'nl': 'Nederlands',
  'pl': 'Polski',
  'pt': 'Português (Brasil)',
  'pt_PT': 'Português (Portugal)',
  'sv': 'Svenska',
  'nb': 'Norsk',
  'da': 'Dansk',
  'ja': '日本語',
  'ko': '한국어',
  'ar': 'العربية',
  'id': 'Bahasa Indonesia',
  'ms': 'Bahasa Melayu',
};

/// Language picker — sets the app locale (null = follow the device). Changing it
/// re-localizes the whole app live via settingsChanges → MaterialApp rebuild.
class _LanguageControl extends ConsumerWidget {
  const _LanguageControl();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    final l = AppLocalizations.of(context);
    final code = settings.localeCode;
    final current =
        code == null ? l.languageSystemDefault : (_languages[code] ?? code);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: const Icon(Icons.language_rounded, color: AppColors.primary),
        title: Text(current),
        trailing: const Icon(Icons.expand_more_rounded),
        onTap: () => _pick(context, ref, code),
      ),
    );
  }

  Future<void> _pick(BuildContext context, WidgetRef ref, String? current) {
    final settings = ref.read(settingsRepositoryProvider);
    final l = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (sheetCtx) {
        Widget row(String? value, String label) => ListTile(
              title: Text(label),
              trailing: value == current
                  ? const Icon(Icons.check_rounded, color: AppColors.primary)
                  : null,
              onTap: () {
                settings.setLocaleCode(value);
                Navigator.of(sheetCtx).pop();
              },
            );
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              row(null, l.languageSystemDefault),
              const Divider(height: 1),
              for (final e in _languages.entries) row(e.key, e.value),
            ],
          ),
        );
      },
    );
  }
}

class _HapticsControl extends ConsumerWidget {
  const _HapticsControl();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    final l = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: SwitchListTile(
        secondary:
            const Icon(Icons.vibration_rounded, color: AppColors.primary),
        title: Text(l.profileHaptics),
        subtitle: Text(l.profileHapticsSub),
        value: settings.hapticsEnabled,
        onChanged: (v) async {
          Haptics.enabled = v;
          await settings.setHapticsEnabled(v);
          if (v) Haptics.selection(); // a little confirmation buzz
        },
      ),
    );
  }
}

class _NotificationControls extends ConsumerWidget {
  const _NotificationControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    if (!ref.watch(cloudEnabledProvider)) return const SizedBox.shrink();
    final settings = ref.watch(settingsRepositoryProvider);
    final pushOn = settings.pushEnabled;
    final l = AppLocalizations.of(context);
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
            title: Text(l.profileNotifications),
            subtitle: Text(l.profileNotificationsSub),
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
            title: Text(l.profilePodAlerts),
            subtitle: Text(l.profilePodAlertsSub),
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
    final l = AppLocalizations.of(context);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.profileEnableNotifs),
      ));
      return;
    }
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: l.profileReminderHelp,
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
    final l = AppLocalizations.of(context);
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
        title: Text(l.profileReminderTitle),
        subtitle: Text(on
            ? l.profileReminderOn(time.format(context))
            : l.profileReminderOff),
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
            Text(AppLocalizations.of(sheetCtx).profileAvatarTitle,
                style: Theme.of(sheetCtx).textTheme.titleLarge),
            const SizedBox(height: Insets.xs),
            Text(AppLocalizations.of(sheetCtx).profileAvatarSub,
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
