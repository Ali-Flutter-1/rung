import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

/// The 0–10 intensity slider — the hero control on Predict & Reflect.
/// A calm Teal → Amber → Rose gradient track (Project Brief §4, never an
/// alarming red), a big value coloured by the current intensity, and gentle
/// haptic detents.
class SudsSlider extends StatelessWidget {
  const SudsSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.accent,
    this.lowLabel = 'calm',
    this.highLabel = 'intense',
  });

  final int value;
  final ValueChanged<int> onChanged;

  /// Optional override for the value colour; defaults to the intensity scale.
  final Color? accent;
  final String lowLabel;
  final String highLabel;

  String get _label => switch (value) {
        0 => 'Totally calm',
        1 || 2 => 'Barely a blip',
        3 || 4 => 'A little nervous',
        5 || 6 => 'Pretty anxious',
        7 || 8 => 'Very anxious',
        _ => 'About as big as it gets',
      };

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final color = accent ?? AppColors.intensity(value);

    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: Insets.xs),
        Text(_label,
            style: t.titleMedium?.copyWith(color: t.bodyMedium?.color)),
        const SizedBox(height: Insets.lg),
        _GradientTrack(value: value, onChanged: onChanged),
        const SizedBox(height: Insets.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0 · $lowLabel', style: t.bodyMedium),
              Text('10 · $highLabel', style: t.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _GradientTrack extends StatelessWidget {
  const _GradientTrack({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The gradient bar itself.
          Container(
            height: 16,
            decoration: BoxDecoration(
              borderRadius: Radii.pill,
              gradient: const LinearGradient(
                colors: AppColors.intensityGradient,
              ),
            ),
          ),
          // A transparent Slider provides the draggable knob + a11y semantics.
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 16,
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              thumbColor: Colors.white,
              overlayColor: AppColors.intensity(value).withValues(alpha: 0.14),
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 13, elevation: 3),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: value.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              label: '$value',
              onChanged: (v) {
                final next = v.round();
                if (next != value) {
                  Haptics.selection();
                  onChanged(next);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
