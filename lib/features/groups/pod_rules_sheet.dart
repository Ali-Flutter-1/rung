import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// Community rules shown before a user's first pod. Returns true if accepted.
/// Consent + clear rules are a baseline safety + store-review requirement.
Future<bool> showPodRulesSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) {
      final t = Theme.of(ctx).textTheme;
      final l = AppLocalizations.of(ctx);
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.podRulesTitle, style: t.headlineSmall),
              const SizedBox(height: Insets.xs),
              Text(l.podRulesIntro, style: t.bodyMedium),
              const SizedBox(height: Insets.lg),
              _Rule(icon: Icons.favorite_outline_rounded, text: l.podRule1),
              _Rule(icon: Icons.block_rounded, text: l.podRule2),
              _Rule(icon: Icons.flag_outlined, text: l.podRule3),
              _Rule(icon: Icons.lock_outline_rounded, text: l.podRule4),
              _Rule(
                  icon: Icons.health_and_safety_outlined, text: l.podRule5),
              const SizedBox(height: Insets.lg),
              FilledButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(l.podRulesAgree),
              ),
              const SizedBox(height: Insets.xs),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(l.commonNotNow),
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
