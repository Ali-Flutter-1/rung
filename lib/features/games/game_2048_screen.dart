import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'game_confetti.dart';
import 'game_help.dart';
import 'game_scores.dart';

/// 2048 — swipe to slide and merge tiles; reach 2048. A focus/strategy classic.
/// Single page, fully local.
class Game2048Screen extends StatefulWidget {
  const Game2048Screen({super.key});

  @override
  State<Game2048Screen> createState() => _Game2048State();
}

class _Game2048State extends State<Game2048Screen> {
  List<List<int>> _grid = List.generate(4, (_) => List.filled(4, 0));
  int _score = 0;
  int _best = 0;
  bool _over = false;
  bool _won = false;
  final _rand = Random();
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    GameScores.best('2048').then((v) {
      if (mounted && v != null) setState(() => _best = v);
    });
    _newGame();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Widget _wrapConfetti(Widget child) =>
      Stack(children: [child, confettiLayer(_confetti)]);

  void _newGame() {
    setState(() {
      _grid = List.generate(4, (_) => List.filled(4, 0));
      _score = 0;
      _over = false;
      _won = false;
    });
    _spawn();
    _spawn();
  }

  void _spawn() {
    final empty = <List<int>>[];
    for (var r = 0; r < 4; r++) {
      for (var c = 0; c < 4; c++) {
        if (_grid[r][c] == 0) empty.add([r, c]);
      }
    }
    if (empty.isEmpty) return;
    final cell = empty[_rand.nextInt(empty.length)];
    _grid[cell[0]][cell[1]] = _rand.nextInt(10) == 0 ? 4 : 2;
  }

  // Slide + merge one line to the left; returns (newLine, gained).
  (List<int>, int) _collapse(List<int> line) {
    final nums = line.where((v) => v != 0).toList();
    final out = <int>[];
    var gained = 0;
    for (var i = 0; i < nums.length; i++) {
      if (i + 1 < nums.length && nums[i] == nums[i + 1]) {
        final merged = nums[i] * 2;
        out.add(merged);
        gained += merged;
        i++;
      } else {
        out.add(nums[i]);
      }
    }
    while (out.length < 4) {
      out.add(0);
    }
    return (out, gained);
  }

  void _move(int dir) {
    // dir: 0 left · 1 right · 2 up · 3 down
    if (_over) return;
    final before = _grid.map((r) => [...r]).toList();
    var gained = 0;

    List<int> lineOf(int i) => switch (dir) {
          0 => _grid[i],
          1 => _grid[i].reversed.toList(),
          2 => [for (var r = 0; r < 4; r++) _grid[r][i]],
          _ => [for (var r = 3; r >= 0; r--) _grid[r][i]],
        };
    void writeLine(int i, List<int> line) {
      switch (dir) {
        case 0:
          _grid[i] = line;
        case 1:
          _grid[i] = line.reversed.toList();
        case 2:
          for (var r = 0; r < 4; r++) {
            _grid[r][i] = line[r];
          }
        default:
          for (var r = 0; r < 4; r++) {
            _grid[3 - r][i] = line[r];
          }
      }
    }

    for (var i = 0; i < 4; i++) {
      final (collapsed, g) = _collapse(lineOf(i));
      gained += g;
      writeLine(i, collapsed);
    }

    final changed = !_sameGrid(before, _grid);
    if (!changed) return;

    Haptics.selection();
    _spawn();
    setState(() {
      _score += gained;
      if (_score > _best) _best = _score;
      if (!_won && _grid.any((r) => r.contains(2048))) {
        _won = true;
        Haptics.medium();
        _confetti.play();
      }
      if (_isOver()) _over = true;
    });
    GameScores.record('2048', _score);
  }

  bool _sameGrid(List<List<int>> a, List<List<int>> b) {
    for (var r = 0; r < 4; r++) {
      for (var c = 0; c < 4; c++) {
        if (a[r][c] != b[r][c]) return false;
      }
    }
    return true;
  }

  bool _isOver() {
    for (var r = 0; r < 4; r++) {
      for (var c = 0; c < 4; c++) {
        if (_grid[r][c] == 0) return false;
        if (c < 3 && _grid[r][c] == _grid[r][c + 1]) return false;
        if (r < 3 && _grid[r][c] == _grid[r + 1][c]) return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048'),
        actions: [
          gameHelpAction(context, '2048', const [
            'Swipe up, down, left or right to slide all tiles.',
            'Two tiles with the same number merge into one that doubles.',
            'Keep merging to build a 2048 tile. The board fills — plan ahead!',
          ]),
        ],
      ),
      body: _wrapConfetti(SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              Row(
                children: [
                  _Stat(label: 'Score', value: _score),
                  const SizedBox(width: Insets.md),
                  _Stat(label: 'Best', value: _best),
                  const Spacer(),
                  Text(
                    _over
                        ? 'Game over'
                        : _won
                            ? 'You made 2048! 🎉'
                            : 'Swipe to merge',
                    style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
                  ),
                ],
              ),
              const SizedBox(height: Insets.lg),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onHorizontalDragEnd: (d) =>
                          _move((d.primaryVelocity ?? 0) < 0 ? 0 : 1),
                      onVerticalDragEnd: (d) =>
                          _move((d.primaryVelocity ?? 0) < 0 ? 2 : 3),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: Radii.lgAll,
                        ),
                        child: Column(
                          children: [
                            for (var r = 0; r < 4; r++)
                              Expanded(
                                child: Row(
                                  children: [
                                    for (var c = 0; c < 4; c++)
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: _Tile(value: _grid[r][c]),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Insets.lg),
              GestureDetector(
                onTap: _newGame,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: Radii.pill,
                  ),
                  child: const Text('New game',
                      style: TextStyle(
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

class _Tile extends StatelessWidget {
  const _Tile({required this.value});
  final int value;

  // Soft → warm as the value climbs.
  static const _palette = <int, Color>{
    2: Color(0xFFDDECEB),
    4: Color(0xFFC5E1DE),
    8: Color(0xFF9ED2CC),
    16: Color(0xFF6FC0B7),
    32: Color(0xFF3AA8A0),
    64: Color(0xFFF2C879),
    128: Color(0xFFF2A65A),
    256: Color(0xFFEC8C4A),
    512: Color(0xFFE87A5C),
    1024: Color(0xFFE0574F),
    2048: Color(0xFFCB3F4A),
  };

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.04),
          borderRadius: Radii.card,
        ),
      );
    }
    final bg = _palette[value] ?? const Color(0xFFCB3F4A);
    final dark = value >= 32 && value != 64 && value != 128;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, borderRadius: Radii.card),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            '$value',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 26,
              color: dark ? Colors.white : AppColors.primaryDeep,
            ),
          ),
        ),
      ),
    )
        // Pop whenever this tile's value changes (spawn or merge).
        .animate(key: ValueKey(value))
        .scaleXY(begin: 0.7, end: 1, duration: 160.ms, curve: Curves.easeOutBack);
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(label.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.inkMuted)),
          Text('$value',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDeep)),
        ],
      ),
    );
  }
}
