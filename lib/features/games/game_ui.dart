import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Shared visual furniture for the leveled mini-games. Each game passes its own
/// two-stop [accent] gradient so the boards feel distinct yet cohesive.

/// A gradient level chip with a soft sub-line underneath (best / moves / next).
class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.heading,
    required this.sub,
    required this.accent,
  });
  final String heading;
  final String sub;
  final List<Color> accent;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: accent),
            borderRadius: Radii.pill,
            boxShadow: [
              BoxShadow(
                color: accent.last.withValues(alpha: 0.32),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            heading,
            style: t.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 18,
          child: Text(sub, style: t.bodySmall?.copyWith(color: t.bodyMedium?.color)),
        ),
      ],
    );
  }
}

/// A tinted, bordered frame around a game board — lifts the grid off the page.
class GameBoardFrame extends StatelessWidget {
  const GameBoardFrame({super.key, required this.accent, required this.child});
  final List<Color> accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.last.withValues(alpha: 0.06),
        borderRadius: Radii.lgAll,
        border: Border.all(color: accent.last.withValues(alpha: 0.16)),
      ),
      child: child,
    );
  }
}

/// The full-width action button, themed with the game's accent gradient.
class GamePillButton extends StatelessWidget {
  const GamePillButton({
    super.key,
    required this.label,
    required this.accent,
    required this.onTap,
  });
  final String label;
  final List<Color> accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: accent),
          borderRadius: Radii.pill,
          boxShadow: [
            BoxShadow(
              color: accent.last.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 15.5,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

/// A slim progress bar (used by Number Rush) tinted with the accent.
class GameProgressBar extends StatelessWidget {
  const GameProgressBar({super.key, required this.value, required this.accent});
  final double value; // 0..1
  final List<Color> accent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Radii.pill,
      child: Stack(
        children: [
          Container(
            height: 8,
            color: accent.last.withValues(alpha: 0.14),
          ),
          AnimatedFractionallySizedBox(
            duration: Motion.base,
            curve: Motion.ease,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
