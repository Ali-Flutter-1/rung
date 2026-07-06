import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// A small, calm set of pick-able avatars (emoji on a soft tinted circle — no
/// image assets, works offline and cross-platform). The stored value is the
/// stable [id]; the emoji can be restyled later without breaking saved choices.
class Avatars {
  Avatars._();

  /// id → emoji. Order is the picker order. The grid scrolls, so the list can
  /// grow freely. Kept calm + friendly to fit a low-pressure app.
  static const options = <MapEntry<String, String>>[
    // ── Animals ──
    MapEntry('fox', '🦊'),
    MapEntry('owl', '🦉'),
    MapEntry('turtle', '🐢'),
    MapEntry('penguin', '🐧'),
    MapEntry('whale', '🐳'),
    MapEntry('cat', '🐱'),
    MapEntry('dog', '🐶'),
    MapEntry('panda', '🐼'),
    MapEntry('koala', '🐨'),
    MapEntry('rabbit', '🐰'),
    MapEntry('deer', '🦌'),
    MapEntry('hedgehog', '🦔'),
    MapEntry('otter', '🦦'),
    MapEntry('sloth', '🦥'),
    MapEntry('frog', '🐸'),
    MapEntry('chick', '🐥'),
    MapEntry('bee', '🐝'),
    MapEntry('butterfly', '🦋'),
    MapEntry('ladybug', '🐞'),
    MapEntry('dolphin', '🐬'),
    MapEntry('snail', '🐌'),
    MapEntry('bear', '🐻'),
    MapEntry('lion', '🦁'),
    MapEntry('unicorn', '🦄'),
    // ── Nature ──
    MapEntry('leaf', '🌿'),
    MapEntry('clover', '🍀'),
    MapEntry('seedling', '🌱'),
    MapEntry('tree', '🌳'),
    MapEntry('cactus', '🌵'),
    MapEntry('mushroom', '🍄'),
    MapEntry('flower', '🌸'),
    MapEntry('sunflower', '🌻'),
    MapEntry('tulip', '🌷'),
    MapEntry('lotus', '🪷'),
    MapEntry('maple', '🍁'),
    // ── Sky ──
    MapEntry('sun', '🌤️'),
    MapEntry('moon', '🌙'),
    MapEntry('star', '⭐'),
    MapEntry('sparkles', '✨'),
    MapEntry('rainbow', '🌈'),
    MapEntry('cloud', '☁️'),
    MapEntry('snowflake', '❄️'),
    MapEntry('wave', '🌊'),
    MapEntry('mountain', '⛰️'),
    // ── More animals ──
    MapEntry('hamster', '🐹'),
    MapEntry('mouse', '🐭'),
    MapEntry('tiger', '🐯'),
    MapEntry('monkey', '🐵'),
    MapEntry('pig', '🐷'),
    MapEntry('horse', '🐴'),
    MapEntry('elephant', '🐘'),
    MapEntry('giraffe', '🦒'),
    MapEntry('duck', '🦆'),
    MapEntry('swan', '🦢'),
    MapEntry('parrot', '🦜'),
    MapEntry('flamingo', '🦩'),
    MapEntry('peacock', '🦚'),
    MapEntry('octopus', '🐙'),
    MapEntry('fish', '🐠'),
    MapEntry('crab', '🦀'),
    MapEntry('dragon', '🐉'),
    MapEntry('wolf', '🐺'),
    MapEntry('raccoon', '🦝'),
    MapEntry('squirrel', '🐿️'),
    MapEntry('dove', '🕊️'),
    // ── More nature ──
    MapEntry('evergreen', '🌲'),
    MapEntry('palm', '🌴'),
    MapEntry('blossom', '🌼'),
    MapEntry('hibiscus', '🌺'),
    MapEntry('rose', '🌹'),
    MapEntry('potted', '🪴'),
    MapEntry('wheat', '🌾'),
    // ── More sky ──
    MapEntry('comet', '☄️'),
    MapEntry('glowingstar', '🌟'),
    MapEntry('dizzy', '💫'),
    MapEntry('droplet', '💧'),
    MapEntry('fullmoon', '🌕'),
    MapEntry('crescent', '🌛'),
    MapEntry('milkyway', '🌌'),
    // ── Cozy & treats ──
    MapEntry('tea', '🍵'),
    MapEntry('coffee', '☕'),
    MapEntry('honey', '🍯'),
    MapEntry('cupcake', '🧁'),
    MapEntry('strawberry', '🍓'),
    MapEntry('cherries', '🍒'),
    MapEntry('peach', '🍑'),
    MapEntry('teddy', '🧸'),
    MapEntry('balloon', '🎈'),
    MapEntry('feather', '🪶'),
    MapEntry('crystal', '🔮'),
    MapEntry('gem', '💎'),
    MapEntry('palette', '🎨'),
    MapEntry('music', '🎵'),
    MapEntry('candle', '🕯️'),
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
