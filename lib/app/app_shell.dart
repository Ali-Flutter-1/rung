import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';

/// Maps a nav item's English label to the active language. "Rung" is the brand
/// name and stays untranslated.
String _localizedLabel(BuildContext context, String label) {
  final l = AppLocalizations.of(context);
  return switch (label) {
    'Home' => l.navHome,
    'Groups' => l.navGroups,
    'Premium' => l.navPremium,
    'Profile' => l.navProfile,
    _ => label,
  };
}

/// Bottom-nav shell. The daily practice ("Rung") sits at index 1 so it's one
/// tap away. Custom, calm, branded bar — a soft teal pill marks the selection.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const _items = <({IconData icon, IconData active, String label})>[
    (icon: Icons.dashboard_outlined, active: Icons.dashboard_rounded, label: 'Home'),
    (icon: Icons.stairs_outlined, active: Icons.stairs_rounded, label: 'Rung'),
    (icon: Icons.groups_2_outlined, active: Icons.groups_2_rounded, label: 'Groups'),
    (icon: Icons.workspace_premium_outlined, active: Icons.workspace_premium_rounded, label: 'Premium'),
    (icon: Icons.person_outline_rounded, active: Icons.person_rounded, label: 'Profile'),
  ];

  void _go(int index) {
    Haptics.selection();
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(contentSyncProvider); // refresh global content on sign-in/startup
    ref.watch(progressSyncProvider); // auto-restore/sync progress on start/switch
    ref.watch(pushRegistrationProvider); // register FCM token when signed in
    ref.watch(purchaseSyncProvider); // sync entitlement tier on sign-in
    ref.watch(streakProtectionProvider); // auto-protect streak (tier allowance)
    ref.watch(smartReminderPlannerProvider); // missed/risks/comeback reminders
    final unreadPods = ref.watch(unreadPodsProvider).asData?.value ?? 0;
    final surface = Theme.of(context).colorScheme.surface;
    // Use the theme's outline (dark-aware) — the hardcoded light border showed
    // as a pale ~1px line above the bar in dark mode.
    final topBorder = Theme.of(context).colorScheme.outline;
    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surface,
          border: Border(top: BorderSide(color: topBorder)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                for (var i = 0; i < _items.length; i++)
                  Expanded(
                    child: _NavItem(
                      data: _items[i],
                      selected: i == shell.currentIndex,
                      badgeCount: i == 2 ? unreadPods : 0,
                      onTap: () => _go(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.selected,
    required this.badgeCount,
    required this.onTap,
  });

  final ({IconData icon, IconData active, String label}) data;
  final bool selected;
  final int badgeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryDeep : AppColors.inkMuted;
    return InkResponse(
      onTap: onTap,
      radius: 48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Motion.fast,
            curve: Motion.ease,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.14)
                  : Colors.transparent,
              borderRadius: Radii.pill,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(selected ? data.active : data.icon,
                    color: color, size: 22),
                if (badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.intensityHigh,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        badgeCount > 9 ? '9+' : '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            _localizedLabel(context, data.label),
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
