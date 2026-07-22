import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'game_confetti.dart';
import 'game_help.dart';
import 'game_scores.dart';

/// Connect 4 — drop tokens, first to line up four wins. Offline: play the phone
/// (heuristic AI) or pass-and-play. 7 columns × 6 rows.
enum _Mode { ai, pass }

const _cols = 7;
const _rows = 6;

class ConnectFourScreen extends StatefulWidget {
  const ConnectFourScreen({super.key});

  @override
  State<ConnectFourScreen> createState() => _ConnectFourState();
}

class _ConnectFourState extends State<ConnectFourScreen> {
  _Mode _mode = _Mode.ai;
  List<int> _board = List.filled(_cols * _rows, 0); // 0 empty · 1 red · 2 yellow
  int _turn = 1; // 1 = red (P1/you), 2 = yellow (P2/phone)
  int? _winner; // null · 0 draw · 1 · 2
  Set<int> _winCells = {};
  int _p1 = 0, _p2 = 0, _draws = 0;
  bool _aiThinking = false;
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  int _idx(int r, int c) => r * _cols + c;

  Widget _wrapConfetti(Widget child) =>
      Stack(children: [child, confettiLayer(_confetti)]);

  void _setMode(_Mode m) {
    if (m == _mode) return;
    setState(() => _mode = m);
    _reset();
  }

  void _reset() {
    setState(() {
      _board = List.filled(_cols * _rows, 0);
      _turn = 1;
      _winner = null;
      _winCells = {};
      _aiThinking = false;
    });
  }

  int? _dropRow(List<int> b, int col) {
    for (var r = _rows - 1; r >= 0; r--) {
      if (b[_idx(r, col)] == 0) return r;
    }
    return null; // column full
  }

  void _tapCol(int col) {
    if (_winner != null || _aiThinking) return;
    if (_mode == _Mode.ai && _turn != 1) return;
    if (_dropRow(_board, col) == null) return;
    Haptics.selection();
    _drop(col, _turn);
  }

  void _drop(int col, int p) {
    final b = [..._board];
    final r = _dropRow(b, col);
    if (r == null) return;
    b[_idx(r, col)] = p;
    final line = _winningCells(b, _idx(r, col), p);
    final full = !b.contains(0);
    setState(() {
      _board = b;
      if (line != null) {
        _winner = p;
        _winCells = line;
        p == 1 ? _p1++ : _p2++;
        Haptics.medium();
        _confetti.play();
      } else if (full) {
        _winner = 0;
        _draws++;
      } else {
        _turn = p == 1 ? 2 : 1;
      }
    });
    if (line != null && p == 1 && _mode == _Mode.ai) {
      GameScores.increment('connect4');
    }
    if (_winner == null && _mode == _Mode.ai && _turn == 2) _aiMove();
  }

  /// If placing at [cell] made a 4-line for [p], returns those cells.
  Set<int>? _winningCells(List<int> b, int cell, int p) {
    final r0 = cell ~/ _cols, c0 = cell % _cols;
    const dirs = [
      [0, 1], // horizontal
      [1, 0], // vertical
      [1, 1], // diagonal ↘
      [1, -1], // diagonal ↙
    ];
    for (final d in dirs) {
      final cells = <int>{cell};
      for (final sign in [1, -1]) {
        var r = r0 + d[0] * sign, c = c0 + d[1] * sign;
        while (r >= 0 && r < _rows && c >= 0 && c < _cols && b[_idx(r, c)] == p) {
          cells.add(_idx(r, c));
          r += d[0] * sign;
          c += d[1] * sign;
        }
      }
      if (cells.length >= 4) return cells;
    }
    return null;
  }

  Future<void> _aiMove() async {
    setState(() => _aiThinking = true);
    await Future.delayed(const Duration(milliseconds: 480));
    if (!mounted) return;
    final col = _bestCol([..._board], 2);
    setState(() => _aiThinking = false);
    if (col != null) _drop(col, 2);
  }

  /// Heuristic: win now if possible, block the human's win, else prefer the
  /// centre columns. Beatable but not silly.
  int? _bestCol(List<int> b, int ai) {
    final human = ai == 1 ? 2 : 1;
    bool wins(int col, int p) {
      final r = _dropRow(b, col);
      if (r == null) return false;
      b[_idx(r, col)] = p;
      final w = _winningCells(b, _idx(r, col), p) != null;
      b[_idx(r, col)] = 0;
      return w;
    }

    for (var c = 0; c < _cols; c++) {
      if (_dropRow(b, c) != null && wins(c, ai)) return c;
    }
    for (var c = 0; c < _cols; c++) {
      if (_dropRow(b, c) != null && wins(c, human)) return c;
    }
    for (final c in [3, 2, 4, 1, 5, 0, 6]) {
      if (_dropRow(b, c) != null) return c;
    }
    return null;
  }

  String _statusText(AppLocalizations l) {
    if (_winner == 1) {
      return _mode == _Mode.ai ? l.gameYouWin : l.c4P1Wins;
    }
    if (_winner == 2) {
      return _mode == _Mode.ai ? l.gamePhoneWins : l.c4P2Wins;
    }
    if (_winner == 0) return l.gameDraw;
    if (_aiThinking) return l.gamePhoneThinking;
    if (_mode == _Mode.ai) return l.c4Turn;
    return _turn == 1 ? l.c4P1Turn : l.c4P2Turn;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final p1Label = _mode == _Mode.ai ? l.gameYou : l.c4P1Label;
    final p2Label = _mode == _Mode.ai ? l.gamePhone : l.c4P2Label;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect 4'),
        actions: [
          gameHelpAction(context, 'Connect 4', [
            l.c4Rule1,
            l.c4Rule2,
            l.c4Rule3,
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
                  _ModeChip(
                    label: l.gamePlayPhone,
                    icon: Icons.smartphone_rounded,
                    selected: _mode == _Mode.ai,
                    onTap: () => _setMode(_Mode.ai),
                  ),
                  const SizedBox(width: Insets.sm),
                  _ModeChip(
                    label: l.game2Players,
                    icon: Icons.people_alt_rounded,
                    selected: _mode == _Mode.pass,
                    onTap: () => _setMode(_Mode.pass),
                  ),
                ],
              ),
              const SizedBox(height: Insets.md),
              Text(_statusText(l), style: t.titleMedium),
              const SizedBox(height: Insets.md),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _cols / _rows,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: Radii.lgAll,
                      ),
                      child: Row(
                        children: [
                          for (var c = 0; c < _cols; c++)
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _tapCol(c),
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  children: [
                                    for (var r = 0; r < _rows; r++)
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: _Slot(
                                            value: _board[_idx(r, c)],
                                            win: _winCells.contains(_idx(r, c)),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Insets.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Score(label: p1Label, value: _p1, color: const Color(0xFFE0574F)),
                  _Score(label: l.gameDraws, value: _draws, color: AppColors.inkMuted),
                  _Score(label: p2Label, value: _p2, color: const Color(0xFFEBB13E)),
                ],
              ),
              const SizedBox(height: Insets.md),
              GestureDetector(
                onTap: _reset,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: Radii.pill,
                  ),
                  child: Text(l.gameNewGame,
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

class _Slot extends StatelessWidget {
  const _Slot({required this.value, required this.win});
  final int value; // 0 · 1 red · 2 yellow
  final bool win;

  @override
  Widget build(BuildContext context) {
    final color = value == 1
        ? const Color(0xFFE0574F)
        : value == 2
            ? const Color(0xFFEBB13E)
            : Theme.of(context).colorScheme.surface;
    Widget slot = AnimatedContainer(
      duration: Motion.fast,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: win ? AppColors.primaryDeep : Colors.black.withValues(alpha: 0.05),
          width: win ? 3 : 1,
        ),
      ),
    );
    // Drop-in pop when a token lands.
    if (value != 0) {
      slot = slot.animate(key: ValueKey(value)).scale(
            begin: const Offset(0.4, 0.4),
            end: const Offset(1, 1),
            duration: 240.ms,
            curve: Curves.easeOutBack,
          );
    }
    // Winning tokens breathe gently.
    if (win) {
      slot = slot
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1, end: 1.08, duration: 700.ms, curve: Curves.easeInOut);
    }
    return slot;
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.14)
                : Theme.of(context).colorScheme.surface,
            borderRadius: Radii.pill,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 16,
                  color: selected ? AppColors.primaryDeep : AppColors.inkMuted),
              const SizedBox(width: 6),
              Flexible(
                child: Text(label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:
                          selected ? AppColors.primaryDeep : AppColors.inkMuted,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({required this.label, required this.value, required this.color});
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        Text('$value',
            style: t.headlineSmall
                ?.copyWith(color: color, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label, style: t.bodyMedium),
      ],
    );
  }
}
