import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// A calm difficulty indicator (1–10) — five dots, filled by half-steps.
/// No red; difficulty reads as "height on the ladder", not danger.
class DifficultyBadge extends StatelessWidget {
  const DifficultyBadge({super.key, required this.difficulty, this.color});

  final int difficulty; // 1–10
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    final filled = (difficulty / 2).round().clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < filled ? c : c.withValues(alpha: 0.18),
              ),
            ),
          ),
      ],
    );
  }
}
