import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../domain/entities/track.dart';
import 'track_visuals.dart';

/// A calm, offline cover for a rung — a soft track-tinted gradient with the
/// track's motif and a difficulty badge. (A per-rung photo via CDN can replace
/// the gradient later without touching callers.)
class RungCover extends StatelessWidget {
  const RungCover({
    super.key,
    required this.track,
    required this.difficulty,
    this.height = 168,
  });

  final Track track;
  final int difficulty;
  final double height;

  @override
  Widget build(BuildContext context) {
    final accent = TrackVisuals.color(track);
    return ClipRRect(
      borderRadius: Radii.lgAll,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            // Soft brand gradient.
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accent.withValues(alpha: 0.85),
                      accent.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
            // Large translucent motif of the track icon.
            Positioned(
              right: -18,
              bottom: -18,
              child: Icon(
                TrackVisuals.iconFor(track),
                size: 150,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            // Difficulty badge (bottom-left).
            Positioned(
              left: Insets.md,
              bottom: Insets.md,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.92),
                  borderRadius: Radii.pill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bar_chart_rounded, size: 16, color: accent),
                    const SizedBox(width: 6),
                    Text(
                      'Difficulty $difficulty / 10',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.ink,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
