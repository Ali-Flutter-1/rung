import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// "Is this right for me?" — the non-negotiable safety framing (§1.9).
/// Reused in onboarding and reachable any time from Profile.
class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Is this right for me?')),
      body: ListView(
        padding: const EdgeInsets.all(Insets.lg),
        children: [
          Text('Rung is practice, not therapy.', style: t.headlineSmall),
          const SizedBox(height: Insets.md),
          Text(
            'Rung is a confidence and practice tool. It helps you face everyday '
            'social situations gradually, at your own pace. It is not therapy, '
            'not a medical treatment, and not a diagnosis.',
            style: t.bodyLarge,
          ),
          const SizedBox(height: Insets.lg),
          _Point(
            icon: Icons.self_improvement_rounded,
            text: 'The goal is manageable dread — feeling more comfortable in the '
                'moments you used to avoid. Not becoming a different person.',
          ),
          _Point(
            icon: Icons.favorite_outline_rounded,
            text: 'Skipping is always okay and never counts against you. There '
                'are no shame mechanics here.',
          ),
          _Point(
            icon: Icons.lock_outline_rounded,
            text: 'Your data is yours. Everything works offline, with no account '
                'required.',
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
                Text('If this is more than nerves',
                    style: t.titleMedium
                        ?.copyWith(color: AppColors.accentDeep)),
                const SizedBox(height: Insets.sm),
                Text(
                  'If anxiety is severely affecting your daily life, or you ever '
                  'have thoughts of harming yourself, please reach out to a '
                  'qualified professional or a local crisis line. That is a '
                  'strong, healthy step — and Rung is not a substitute for it.',
                  style: t.bodyLarge?.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
        ],
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
              child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
