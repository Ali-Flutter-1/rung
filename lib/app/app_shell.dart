import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import 'providers.dart';

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
    HapticFeedback.selectionClick();
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(contentSyncProvider); // refresh global content on sign-in/startup
    ref.watch(progressSyncProvider); // auto-restore/sync progress on start/switch
    final surface = Theme.of(context).colorScheme.surface;
    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surface,
          border: Border(top: BorderSide(color: AppColors.border)),
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
    required this.onTap,
  });

  final ({IconData icon, IconData active, String label}) data;
  final bool selected;
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
            child: Icon(selected ? data.active : data.icon,
                color: color, size: 22),
          ),
          const SizedBox(height: 3),
          Text(
            data.label,
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
