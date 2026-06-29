import 'package:flutter/material.dart';

/// Rung's palette (Project Brief §4): Calm Teal primary, Deep Indigo text,
/// Warm Neutral paper background, Warm Amber accent for moments of quiet
/// delight. The intensity scale runs Teal → Amber → Muted Rose — never an
/// alarming red.
class AppColors {
  AppColors._();

  // Brand — Calm Teal
  static const Color primary = Color(0xFF3AA8A0);
  static const Color primaryDeep = Color(0xFF2A7E78);
  static const Color primarySoft = Color(0xFFE3F1EF);

  // Accent — Warm Coral/Amber (quiet delight only)
  static const Color accent = Color(0xFFF2A65A);
  static const Color accentDeep = Color(0xFFC9802F);
  static const Color accentSoft = Color(0xFFFBEFDF);

  // Intensity scale stops (predicted/actual sliders & gaps)
  static const Color intensityLow = Color(0xFF3AA8A0); // teal — calm
  static const Color intensityMid = Color(0xFFF2A65A); // amber
  static const Color intensityHigh = Color(0xFFC97A86); // muted rose

  // Neutrals (light) — warm, paper-like
  static const Color ink = Color(0xFF1E2A3A); // Deep Indigo
  static const Color inkMuted = Color(0xFF5C6675);
  static const Color inkFaint = Color(0xFF9AA2AE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF1ECE3);
  static const Color background = Color(0xFFF7F4EF); // Warm Neutral
  static const Color border = Color(0xFFE7E1D6);

  // Neutrals (dark)
  static const Color inkDark = Color(0xFFEDEFF2);
  static const Color inkMutedDark = Color(0xFFA7AFBC);
  static const Color inkFaintDark = Color(0xFF6B7280);
  static const Color surfaceDark = Color(0xFF1B2026);
  static const Color surfaceAltDark = Color(0xFF232A31);
  static const Color backgroundDark = Color(0xFF14181C);
  static const Color borderDark = Color(0xFF2C333B);

  /// The signature intensity gradient (0 → 10).
  static const List<Color> intensityGradient = [
    intensityLow,
    intensityMid,
    intensityHigh,
  ];

  /// Interpolated colour for a SUDS value 0–10 along the intensity scale.
  static Color intensity(int suds) {
    final tt = (suds.clamp(0, 10)) / 10.0;
    if (tt <= 0.5) {
      return Color.lerp(intensityLow, intensityMid, tt / 0.5)!;
    }
    return Color.lerp(intensityMid, intensityHigh, (tt - 0.5) / 0.5)!;
  }

  /// Per-track accent colours keyed by a track's [colorSeed].
  static const Map<String, Color> trackSeeds = {
    'indigo': Color(0xFF5B8DEF), // Speaking — soft blue
    'teal': Color(0xFF3AA8A0), // Approaching — teal
    'violet': Color(0xFF8A6BEF), // Social events — violet
    'rose': Color(0xFFD58AA0), // Assertiveness — rose
    'amber': Color(0xFFE9A23B), // Being visible — amber
    'sky': Color(0xFF49B6C4), // Under pressure — sky/teal
  };

  static Color seed(String? colorSeed) => trackSeeds[colorSeed] ?? primary;

  /// A soft tinted background for a track card (mockup "Your tracks" tints).
  static Color seedSoft(String? colorSeed) =>
      seed(colorSeed).withValues(alpha: 0.10);
}
