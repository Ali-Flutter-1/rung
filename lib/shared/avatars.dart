import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// A small, calm set of pick-able avatars (emoji on a soft tinted circle — no
/// image assets, works offline and cross-platform). The stored value is the
/// stable [id]; the emoji can be restyled later without breaking saved choices.
class Avatars {
  Avatars._();

  /// id → emoji. Order is the picker order. Add/keep ≤ ~15 for a tidy grid.
  static const options = <MapEntry<String, String>>[
    MapEntry('fox', '🦊'),
    MapEntry('owl', '🦉'),
    MapEntry('turtle', '🐢'),
    MapEntry('penguin', '🐧'),
    MapEntry('whale', '🐳'),
    MapEntry('cat', '🐱'),
    MapEntry('deer', '🦌'),
    MapEntry('hedgehog', '🦔'),
    MapEntry('bee', '🐝'),
    MapEntry('leaf', '🌿'),
    MapEntry('moon', '🌙'),
    MapEntry('star', '⭐'),
    MapEntry('flower', '🌸'),
    MapEntry('clover', '🍀'),
    MapEntry('wave', '🌊'),
  ];

  /// The emoji for a stored id, or null if unset / unknown (→ fall back to the
  /// name initial).
  static String? emojiFor(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final e in options) {
      if (e.key == id) return e.value;
    }
    return null;
  }
}

/// Renders a user's avatar consistently everywhere: the chosen emoji when set,
/// a lock icon when the profile is private, otherwise the name's initial.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.avatarId,
    this.name,
    this.radius = 20,
    this.locked = false,
  });

  final String? avatarId;
  final String? name;
  final double radius;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final emoji = Avatars.emojiFor(avatarId);
    Widget child;
    if (locked) {
      child = Icon(Icons.lock_outline_rounded,
          size: radius, color: AppColors.primaryDeep);
    } else if (emoji != null) {
      child = Text(emoji, style: TextStyle(fontSize: radius * 1.05));
    } else {
      final n = name?.trim() ?? '';
      final initial = n.isEmpty ? '?' : n.characters.first.toUpperCase();
      child = Text(
        initial,
        style: TextStyle(
          fontSize: radius * 0.9,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryDeep,
        ),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      child: child,
    );
  }
}
