import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../domain/entities/track.dart';

/// Maps a track's stored icon key + color seed to Flutter visuals.
/// Keeps the domain layer free of Flutter types (§11.2).
class TrackVisuals {
  TrackVisuals._();

  static const Map<String, IconData> _icons = {
    'mic': Icons.mic_none_rounded,
    'wave': Icons.waving_hand_outlined,
    'groups': Icons.groups_2_outlined,
    'balance': Icons.balance_outlined,
    'visibility': Icons.visibility_outlined,
    'bolt': Icons.bolt_outlined,
  };

  static IconData icon(String key) =>
      _icons[key] ?? Icons.circle_outlined;

  static Color color(Track track) => AppColors.seed(track.colorSeed);

  static IconData iconFor(Track track) => icon(track.icon);
}
