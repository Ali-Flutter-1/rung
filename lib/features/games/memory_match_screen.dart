import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'game_confetti.dart';
import 'game_help.dart';
import 'game_scores.dart';

/// Memory match — a calm solo game. Flip cards two at a time and find the
/// pairs. 4×4 grid (8 pairs). Fully local.
class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchState();
}

class _MemoryMatchState extends State<MemoryMatchScreen> {
  static const _faces = ['🦊', '🦉', '🌿', '🌙', '⭐', '🌸', '🐢', '🐝'];

  late List<String> _cards;
  final Set<int> _matched = {};
  final List<int> _flipped = [];
  int _moves = 0;
  bool _busy = false;
  int? _best; // fewest moves
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    GameScores.best('memory').then((v) {
      if (mounted && v != null) setState(() => _best = v);
    });
    _deal();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Widget _wrapConfetti(Widget child) =>
      Stack(children: [child, confettiLayer(_confetti)]);

  void _deal() {
    setState(() {
      _cards = [..._faces, ..._faces]..shuffle();
      _matched.clear();
      _flipped.clear();
      _moves = 0;
      _busy = false;
    });
  }

  bool get _won => _matched.length == _cards.length;

  Future<void> _tap(int i) async {
    if (_busy || _matched.contains(i) || _flipped.contains(i) || _won) return;
    Haptics.selection();
    setState(() => _flipped.add(i));
    if (_flipped.length < 2) return;

    _moves++;
    final a = _flipped[0], b = _flipped[1];
    if (_cards[a] == _cards[b]) {
      setState(() {
        _matched.addAll([a, b]);
        _flipped.clear();
      });
      if (_won) {
        Haptics.medium();
        _confetti.play();
        if (_best == null || _moves < _best!) setState(() => _best = _moves);
        GameScores.record('memory', _moves, lowerIsBetter: true);
      }
    } else {
      setState(() => _busy = true);
      await Future.delayed(const Duration(milliseconds: 750));
      if (!mounted) return;
      setState(() {
        _flipped.clear();
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory match'),
        actions: [
          gameHelpAction(context, 'Memory match', const [
            'Tap a card to flip it, then flip a second one.',
            'If the two emojis match, they stay face-up; if not, they flip back.',
            'Find all the pairs — in as few moves as you can.',
          ]),
        ],
      ),
      body: _wrapConfetti(SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              Text(
                _won
                    ? 'All matched in $_moves moves! 🎉'
                    : 'Find the pairs · $_moves moves',
                style: t.titleMedium,
              ),
              if (_best != null)
                Text('Best: $_best moves',
                    style: t.bodySmall?.copyWith(color: AppColors.inkMuted)),
              const SizedBox(height: Insets.lg),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var i = 0; i < _cards.length; i++)
                          _Card(
                            face: _cards[i],
                            up: _flipped.contains(i) || _matched.contains(i),
                            matched: _matched.contains(i),
                            onTap: () => _tap(i),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Insets.lg),
              GestureDetector(
                onTap: _deal,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: Radii.pill,
                  ),
                  child: Text(_won ? 'Play again' : 'Shuffle',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.face,
    required this.up,
    required this.matched,
    required this.onTap,
  });
  final String face;
  final bool up;
  final bool matched;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Motion.fast,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: up
              ? (matched
                  ? AppColors.primary.withValues(alpha: 0.16)
                  : Theme.of(context).colorScheme.surface)
              : AppColors.primary,
          borderRadius: Radii.card,
          border: Border.all(
            color: matched ? AppColors.primary : AppColors.border,
            width: matched ? 2 : 1,
          ),
        ),
        child: up
            ? Text(face, style: const TextStyle(fontSize: 30))
            : const Icon(Icons.psychology_alt_rounded,
                color: Colors.white, size: 22),
      )
          // Flip when the face changes; a soft pop when it's matched.
          .animate(key: ValueKey('$up-$matched'))
          .flipH(duration: 260.ms, curve: Curves.easeOut),
    );
  }
}
