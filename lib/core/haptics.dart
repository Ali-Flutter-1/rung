import 'package:flutter/services.dart';

/// App-wide haptics gate. All app code calls these instead of [HapticFeedback]
/// directly, so the user's on/off setting actually silences them everywhere.
/// [enabled] is synced from settings at startup and when the toggle changes.
class Haptics {
  Haptics._();

  static bool enabled = true;

  static void selection() {
    if (enabled) HapticFeedback.selectionClick();
  }

  static void light() {
    if (enabled) HapticFeedback.lightImpact();
  }

  static void medium() {
    if (enabled) HapticFeedback.mediumImpact();
  }

  static void heavy() {
    if (enabled) HapticFeedback.heavyImpact();
  }
}
