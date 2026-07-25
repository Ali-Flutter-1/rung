import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'game_confetti.dart';
import 'game_help.dart';
import 'game_scores.dart';
import 'game_ui.dart';

/// Brand amber accent — the app's warm accent colour, a lit bulb.
const _accent = [AppColors.accent, AppColors.accentDeep];

/// Lights Out — tap a tile to flip it and its four neighbours; turn every
/// light off. Each level grows the grid and the scramble. Fully local.
/// Best = highest level reached.
class LightsOutScreen extends StatefulWidget {
  const LightsOutScreen({super.key});

  @override
  State<LightsOutScreen> createState() => _LightsOutState();
}

class _LightsOutState extends State<LightsOutScreen> {
  final _rng = Random();

  int _level = 1;
  late int _n;
  late List<bool> _on;
  int _moves = 0;
  bool _cleared = false;
  int? _best;
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    GameScores.best('lights').then((v) {
      if (mounted && v != null) setState(() => _best = v);
    });
    _start(1);
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Widget _wrapConfetti(Widget child) =>
      Stack(children: [child, confettiLayer(_confetti)]);

  void _start(int level) {
    _level = level;
    _n = min(2 + level, 5); // L1=3×3, L2=4×4, L3+=5×5
    _scramble();
  }

  /// Start from all-off and apply random taps — the result is always solvable.
  void _scramble() {
    final on = List<bool>.filled(_n * _n, false);
    final taps = 2 + _level * 2;
    for (var k = 0; k < taps; k++) {
      _flip(on, _rng.nextInt(_n * _n));
    }
    // A freshly-off board would already be "won" — reshuffle in that case.
    if (!on.contains(true)) {
      _flip(on, _rng.nextInt(_n * _n));
    }
    setState(() {
      _on = on;
      _moves = 0;
      _cleared = false;
    });
  }

  void _flip(List<bool> board, int i) {
    final r = i ~/ _n, c = i % _n;
    board[i] = !board[i];
    if (r > 0) board[i - _n] = !board[i - _n];
    if (r < _n - 1) board[i + _n] = !board[i + _n];
    if (c > 0) board[i - 1] = !board[i - 1];
    if (c < _n - 1) board[i + 1] = !board[i + 1];
  }

  void _tap(int i) {
    if (_cleared) return;
    Haptics.selection();
    setState(() {
      _flip(_on, i);
      _moves++;
    });
    if (!_on.contains(true)) {
      Haptics.medium();
      _confetti.play();
      setState(() => _cleared = true);
      if (_best == null || _level > _best!) setState(() => _best = _level);
      GameScores.record('lights', _level);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.gameTitleLights),
        actions: [
          gameHelpAction(context, l.gameTitleLights, [
            l.lightsRule1,
            l.lightsRule2,
          ]),
        ],
      ),
      body: _wrapConfetti(
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Column(
              children: [
                GameHeader(
                  heading: _cleared
                      ? l.gameLevelClear(_level)
                      : l.gameLevelLabel(_level),
                  sub: _best != null
                      ? l.gamesBestLevel(_best!)
                      : l.gameMovesLabel(_moves),
                  accent: _accent,
                ),
                const SizedBox(height: Insets.lg),
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GameBoardFrame(
                        accent: _accent,
                        child: GridView.count(
                          crossAxisCount: _n,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            for (var i = 0; i < _on.length; i++)
                              _Cell(on: _on[i], onTap: () => _tap(i)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Insets.lg),
                GamePillButton(
                  label: _cleared ? l.gameNextLevel : l.mmShuffle,
                  accent: _accent,
                  onTap: () => _cleared ? _start(_level + 1) : _scramble(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.on, required this.onTap});
  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Motion.fast,
        decoration: BoxDecoration(
          gradient: on
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _accent,
                )
              : null,
          color: on ? null : Theme.of(context).colorScheme.surface,
          borderRadius: Radii.card,
          border: Border.all(
            color: on
                ? _accent.last
                : Theme.of(context).colorScheme.outline,
          ),
          boxShadow: on
              ? [
                  BoxShadow(
                    color: _accent.last.withValues(alpha: 0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: on
            ? const Icon(Icons.lightbulb_rounded, color: Colors.white, size: 22)
            : Icon(
                Icons.lightbulb_outline_rounded,
                color: Theme.of(context).colorScheme.outline,
                size: 22,
              ),
      ),
    );
  }
}
