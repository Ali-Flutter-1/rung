import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// A soft shimmering placeholder shown while real data settles — so the UI
/// never flashes a bare "0" or jumps. Theme-aware; works in light and dark.
class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.width, this.height = 14, this.radius = 8});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(radius),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(
          duration: 1100.ms,
          color: cs.onSurface.withValues(alpha: 0.05),
        );
  }
}

/// Loading placeholder matching the three headline stat cards.
class StatsRowSkeleton extends StatelessWidget {
  const StatsRowSkeleton({super.key});

  Widget _card(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: Insets.md, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Radii.card,
          border: Border.all(color: AppColors.border),
        ),
        child: const Column(
          children: [
            Skeleton(width: 40, height: 40, radius: 12),
            SizedBox(height: Insets.sm),
            Skeleton(width: 30, height: 22),
            SizedBox(height: 6),
            Skeleton(width: 56, height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _card(context),
        const SizedBox(width: Insets.md),
        _card(context),
        const SizedBox(width: Insets.md),
        _card(context),
      ],
    );
  }
}
