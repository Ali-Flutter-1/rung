import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// "Is this right for me?" — the non-negotiable safety framing (§1.9).
/// Reused in onboarding and reachable any time from Profile.
class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.safetyScreenTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Insets.lg),
          children: [
            Text(l.safetyPracticeTitle, style: t.headlineSmall),
            const SizedBox(height: Insets.md),
            Text(
              l.safetyIntro,
              style: t.bodyLarge,
            ),
            const SizedBox(height: Insets.lg),
            _Point(
              icon: Icons.self_improvement_rounded,
              text: l.safetyPoint1,
            ),
            _Point(
              icon: Icons.favorite_outline_rounded,
              text: l.safetyPoint2,
            ),
            _Point(
              icon: Icons.lock_outline_rounded,
              text: l.safetyPoint3,
            ),
            const SizedBox(height: Insets.lg),
            Container(
              padding: const EdgeInsets.all(Insets.md),
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: Radii.card,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.safetyMoreTitle,
                    style: t.titleMedium?.copyWith(color: AppColors.accentDeep),
                  ),
                  const SizedBox(height: Insets.sm),
                  Text(
                    l.safetyMoreBody,
                    style: t.bodyLarge?.copyWith(color: AppColors.ink),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.icon, required this.text});
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
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
