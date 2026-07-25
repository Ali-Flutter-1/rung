import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rung/core/haptics.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'game_confetti.dart';
import 'game_help.dart';
import 'game_scores.dart';
import 'game_ui.dart';

/// Brand teal — the app's primary colour.
const _accent = [AppColors.primary, AppColors.primaryDeep];

/// Sliding puzzle — the classic number slide. Each level grows the grid
/// (3×3 → 4×4 → 5×5): clear one and tap Next for a harder one. Fully local.
/// Best = highest level reached.
class SlidePuzzleScreen extends StatefulWidget {
  const SlidePuzzleScreen({super.key});

  @override
  State<SlidePuzzleScreen> createState() => _SlidePuzzleState();
}

class _SlidePuzzleState extends State<SlidePuzzleScreen> {
  final _rng = Random();

  int _level = 1;
  late int _n; // grid side for this level
  late List<int> _tiles; // 1..n²-1, 0 = blank
  late List<int> _goal;
  int _moves = 0;
  bool _cleared = false;
  int? _best; // highest level reached
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    GameScores.best('slide').then((v) {
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
    _goal = [for (var i = 1; i < _n * _n; i++) i, 0];
    _scramble();
  }

  /// Scramble by walking random legal slides from the solved board — only
  /// reachable (solvable) states, unlike a raw random permutation.
  void _scramble() {
    final tiles = [..._goal];
    var blank = tiles.indexOf(0);
    var last = -1;
    final walk = 40 * _n; // more shuffling on bigger boards
    for (var i = 0; i < walk; i++) {
      final opts = _neighbours(blank).where((m) => m != last).toList();
      final pick = opts[_rng.nextInt(opts.length)];
      tiles[blank] = tiles[pick];
      tiles[pick] = 0;
      last = blank;
      blank = pick;
    }
    setState(() {
      _tiles = tiles;
      _moves = 0;
      _cleared = false;
    });
  }

  List<int> _neighbours(int i) {
    final r = i ~/ _n, c = i % _n;
    return [
      if (r > 0) i - _n,
      if (r < _n - 1) i + _n,
      if (c > 0) i - 1,
      if (c < _n - 1) i + 1,
    ];
  }

  bool get _solved {
    for (var i = 0; i < _tiles.length; i++) {
      if (_tiles[i] != _goal[i]) return false;
    }
    return true;
  }

  void _tap(int i) {
    if (_cleared || _tiles[i] == 0) return;
    final blank = _tiles.indexOf(0);
    if (!_neighbours(i).contains(blank)) return;
    Haptics.selection();
    setState(() {
      _tiles[blank] = _tiles[i];
      _tiles[i] = 0;
      _moves++;
    });
    if (_solved) {
      Haptics.medium();
      _confetti.play();
      setState(() => _cleared = true);
      if (_best == null || _level > _best!) setState(() => _best = _level);
      GameScores.record('slide', _level);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.gameTitleSlide),
        actions: [
          gameHelpAction(context, l.gameTitleSlide, [
            l.slideRule1,
            l.slideRule2,
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
                            for (var i = 0; i < _tiles.length; i++)
                              _Tile(value: _tiles[i], onTap: () => _tap(i)),
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

class _Tile extends StatelessWidget {
  const _Tile({required this.value, required this.onTap});
  final int value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Radii.card,
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child:
          Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _accent,
                  ),
                  borderRadius: Radii.card,
                  boxShadow: [
                    BoxShadow(
                      color: _accent.last.withValues(alpha: 0.32),
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      '$value',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              )
              // Pop when the tile at this slot changes — reads as a slide.
              .animate(key: ValueKey(value))
              .scaleXY(begin: 0.86, end: 1, duration: 180.ms, curve: Curves.easeOut)
              .fadeIn(duration: 140.ms),
    );
  }
}
