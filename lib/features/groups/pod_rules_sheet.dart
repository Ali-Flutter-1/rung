import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Community rules shown before a user's first pod. Returns true if accepted.
/// Consent + clear rules are a baseline safety + store-review requirement.
Future<bool> showPodRulesSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) {
      final t = Theme.of(ctx).textTheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pod rules', style: t.headlineSmall),
              const SizedBox(height: Insets.xs),
              Text('Pods only work if everyone feels safe. By joining you agree:',
                  style: t.bodyMedium),
              const SizedBox(height: Insets.lg),
              const _Rule(
                  icon: Icons.favorite_outline_rounded,
                  text: 'Be kind. Everyone here is practicing something hard.'),
              const _Rule(
                  icon: Icons.block_rounded,
                  text:
                      'No harassment, hate, or harmful content. Ever.'),
              const _Rule(
                  icon: Icons.flag_outlined,
                  text:
                      'Report or block anyone who makes you uncomfortable.'),
              const _Rule(
                  icon: Icons.lock_outline_rounded,
                  text:
                      'Respect privacy — what\'s shared here stays here.'),
              const _Rule(
                  icon: Icons.health_and_safety_outlined,
                  text:
                      'Pods are peer support, not a crisis service. In an '
                      'emergency, contact a professional or local crisis line.'),
              const SizedBox(height: Insets.lg),
              FilledButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('I agree — take me in'),
              ),
              const SizedBox(height: Insets.xs),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Not now'),
              ),
            ],
          ),
        ),
      );
    },
  );
  return result ?? false;
}

class _Rule extends StatelessWidget {
  const _Rule({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: Insets.md),
          Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
