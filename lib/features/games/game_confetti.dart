import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

/// A celebratory confetti burst, played on a win. Drop [confettiLayer] into a
/// Stack over the game and call `controller.play()` at the win moment.
const _confettiColors = [
  Color(0xFF3AA8A0), // teal
  Color(0xFFF2A65A), // amber
  Color(0xFF6B8FC9), // blue
  Color(0xFFE0899C), // rose
  Color(0xFF4C9A6B), // green
];

Widget confettiLayer(ConfettiController controller) {
  return Align(
    alignment: Alignment.topCenter,
    child: ConfettiWidget(
      confettiController: controller,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      emissionFrequency: 0.06,
      numberOfParticles: 18,
      maxBlastForce: 22,
      minBlastForce: 8,
      gravity: 0.28,
      colors: _confettiColors,
    ),
  );
}
