import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The bundled variable font family (offline-first; no runtime fetch).
const String kFontFamily = 'Plus Jakarta Sans';

/// Design tokens: spacing, radii, durations. Calm, generous whitespace (§4).
class Insets {
  Insets._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class Radii {
  Radii._();
  static const Radius sm = Radius.circular(10);
  static const Radius md = Radius.circular(16);
  static const Radius lg = Radius.circular(24);
  static const BorderRadius card = BorderRadius.all(md);
  static const BorderRadius lgAll = BorderRadius.all(lg);
  static const BorderRadius pill = BorderRadius.all(Radius.circular(999));
}

class Motion {
  Motion._();
  // Subtle easing, 200–300ms (§4.2). Nothing jarring.
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration base = Duration(milliseconds: 280);
  static const Duration celebrate = Duration(milliseconds: 1400);
  static const Curve ease = Curves.easeOutCubic;
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final ink = isDark ? AppColors.inkDark : AppColors.ink;
    final muted = isDark ? AppColors.inkMutedDark : AppColors.inkMuted;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surface;
    final background = isDark ? AppColors.backgroundDark : AppColors.background;
    final border = isDark ? AppColors.borderDark : AppColors.border;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primary,
      onSecondary: Colors.white,
      error: const Color(0xFFB1495F), // muted, never alarming red
      onError: Colors.white,
      surface: surface,
      onSurface: ink,
      surfaceContainerHighest:
          isDark ? AppColors.surfaceAltDark : AppColors.surfaceAlt,
      outline: border,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      // Bundled Plus Jakarta Sans everywhere — even ad-hoc TextStyles inherit it.
      fontFamily: kFontFamily,
      splashFactory: InkSparkle.splashFactory,
    );

    // Drive the variable font's weight axis via fontVariations (Project Brief §4).
    TextStyle t(double size, FontWeight w, {Color? color, double? height}) =>
        TextStyle(
          fontFamily: kFontFamily,
          fontWeight: w,
          fontVariations: [FontVariation('wght', w.value.toDouble())],
          fontSize: size,
          color: color ?? ink,
          height: height,
          letterSpacing: -0.2,
        );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displaySmall: t(32, FontWeight.w700, height: 1.15),
        headlineMedium: t(26, FontWeight.w700, height: 1.2),
        headlineSmall: t(22, FontWeight.w600, height: 1.25),
        titleLarge: t(18, FontWeight.w600),
        titleMedium: t(16, FontWeight.w600),
        bodyLarge: t(16, FontWeight.w400, height: 1.45, color: ink),
        bodyMedium: t(14, FontWeight.w400, height: 1.45, color: muted),
        labelLarge: t(15, FontWeight.w600),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: Radii.card,
          side: BorderSide(color: border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          textStyle: t(16, FontWeight.w600),
          shape: const RoundedRectangleBorder(borderRadius: Radii.card),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          foregroundColor: ink,
          side: BorderSide(color: border),
          textStyle: t(16, FontWeight.w600),
          shape: const RoundedRectangleBorder(borderRadius: Radii.card),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: AppColors.primarySoft,
        elevation: 0,
        height: 68,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primaryDeep
                : muted,
          ),
        ),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 8,
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: isDark
            ? AppColors.surfaceAltDark
            : AppColors.primarySoft,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.12),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: t(20, FontWeight.w700),
        iconTheme: IconThemeData(color: ink),
      ),
    );
  }
}
