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

/// A calm little Tic-Tac-Toe break. Two offline modes: play the phone (a
/// friendly-but-smart AI) or pass-and-play with someone next to you. Purely
/// local — no network, no accounts. Uses GestureDetector cells (no min-size
/// Material buttons) so it's layout-robust on pushed routes.
enum _Mode { ai, pass }

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToeScreen> {
  static const _lines = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
    [0, 4, 8], [2, 4, 6], // diagonals
  ];

  _Mode _mode = _Mode.ai;
  List<int> _board = List.filled(9, 0); // 0 empty · 1 X · 2 O
  int _turn = 1; // 1 = X, 2 = O
  int? _winner; // null none · 0 draw · 1 X · 2 O
  List<int>? _winLine;
  int _xWins = 0, _oWins = 0, _draws = 0;
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

  void _setMode(_Mode m) {
    if (m == _mode) return;
    setState(() => _mode = m);
    _reset();
  }

  void _reset() {
    setState(() {
      _board = List.filled(9, 0);
      _turn = 1;
      _winner = null;
      _winLine = null;
      _aiThinking = false;
    });
  }

  int? _winnerOf(List<int> b) {
    for (final l in _lines) {
      final a = b[l[0]];
      if (a != 0 && a == b[l[1]] && a == b[l[2]]) return a;
    }
    return b.contains(0) ? null : 0; // 0 = draw
  }

  List<int>? _lineFor(List<int> b, int p) {
    for (final l in _lines) {
      if (b[l[0]] == p && b[l[1]] == p && b[l[2]] == p) return l;
    }
    return null;
  }

  void _tap(int i) {
    if (_board[i] != 0 || _winner != null || _aiThinking) return;
    // In AI mode only X (the human) taps.
    if (_mode == _Mode.ai && _turn != 1) return;
    Haptics.selection();
    _place(i, _turn);
  }

  void _place(int i, int p) {
    final b = [..._board];
    b[i] = p;
    final w = _winnerOf(b);
    setState(() {
      _board = b;
      if (w != null) {
        _winner = w;
        if (w == 1) {
          _xWins++;
        } else if (w == 2) {
          _oWins++;
        } else {
          _draws++;
        }
        _winLine = w == 0 ? null : _lineFor(b, w);
        Haptics.medium();
        if (w == 1 || w == 2) _confetti.play();
      } else {
        _turn = p == 1 ? 2 : 1;
      }
    });
    // Persist a win against the phone (you = X).
    if (w == 1 && _mode == _Mode.ai) GameScores.increment('tictactoe');
    if (_winner == null && _mode == _Mode.ai && _turn == 2) _aiMove();
  }

  Future<void> _aiMove() async {
    setState(() => _aiThinking = true);
    await Future.delayed(const Duration(milliseconds: 420)); // "thinking" beat
    if (!mounted) return;
    final move = _bestMove([..._board], 2);
    setState(() => _aiThinking = false);
    if (move != null) _place(move, 2);
  }

  /// Friendly heuristic: win if you can, block if you must, else prefer
  /// centre → corner → side. Strong but beatable with a fork.
  int? _bestMove(List<int> b, int ai) {
    final human = ai == 1 ? 2 : 1;
    for (var i = 0; i < 9; i++) {
      if (b[i] == 0) {
        b[i] = ai;
        if (_winnerOf(b) == ai) {
          b[i] = 0;
          return i;
        }
        b[i] = 0;
      }
    }
    for (var i = 0; i < 9; i++) {
      if (b[i] == 0) {
        b[i] = human;
        if (_winnerOf(b) == human) {
          b[i] = 0;
          return i;
        }
        b[i] = 0;
      }
    }
    if (b[4] == 0) return 4;
    for (final grp in [
      [0, 2, 6, 8],
      [1, 3, 5, 7],
    ]) {
      final open = grp.where((i) => b[i] == 0).toList()..shuffle();
      if (open.isNotEmpty) return open.first;
    }
    return null;
  }

  // ── Labels ──────────────────────────────────────────────────────────────
  String _statusText(AppLocalizations l) {
    if (_winner == 1) {
      return _mode == _Mode.ai ? l.gameYouWin : l.tttP1Wins;
    }
    if (_winner == 2) {
      return _mode == _Mode.ai ? l.gamePhoneWins : l.tttP2Wins;
    }
    if (_winner == 0) return l.gameDraw;
    if (_aiThinking) return l.gamePhoneThinking;
    if (_mode == _Mode.ai) return l.tttYourTurn;
    return _turn == 1 ? l.tttP1Turn : l.tttP2Turn;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final xLabel = _mode == _Mode.ai ? l.gameYou : l.tttP1Label;
    final oLabel = _mode == _Mode.ai ? l.gamePhone : l.tttP2Label;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        actions: [
          gameHelpAction(context, 'Tic-Tac-Toe', [
            l.tttRule1,
            l.tttRule2,
            l.tttRule3,
          ]),
        ],
      ),
      body: _wrapConfetti(SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              // Mode toggle.
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
              const SizedBox(height: Insets.lg),
              Text(_statusText(l), style: t.titleLarge)
                  .animate(key: ValueKey(_statusText(l)))
                  .fadeIn(duration: 250.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
              const SizedBox(height: Insets.lg),
              // Board.
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    borderRadius: Radii.lgAll,
                    border: Border.all(color: AppColors.border),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (var i = 0; i < 9; i++)
                        _Cell(
                          value: _board[i],
                          highlight: _winLine?.contains(i) ?? false,
                          onTap: () => _tap(i),
                        ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 300.ms).scale(
                    begin: const Offset(0.96, 0.96),
                    end: const Offset(1, 1),
                    curve: Curves.easeOut,
                  ),
              const SizedBox(height: Insets.lg),
              // Scores.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Score(label: xLabel, value: _xWins, color: AppColors.primary),
                  _Score(label: l.gameDraws, value: _draws, color: AppColors.inkMuted),
                  _Score(label: oLabel, value: _oWins, color: AppColors.accentDeep),
                ],
              ),
              const Spacer(),
              // New game.
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
                  child: Text(
                    l.gameNewGame,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _wrapConfetti(Widget child) =>
      Stack(children: [child, confettiLayer(_confetti)]);
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
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        selected ? AppColors.primaryDeep : AppColors.inkMuted,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.value,
    required this.highlight,
    required this.onTap,
  });
  final int value; // 0 · 1 X · 2 O
  final bool highlight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isX = value == 1;
    final mark = value == 0
        ? null
        : Icon(
            isX ? Icons.close_rounded : Icons.radio_button_unchecked,
            size: 44,
            color: isX ? AppColors.primary : AppColors.accentDeep,
          )
            // Pop the mark in when it's placed.
            .animate(key: ValueKey(value))
            .scale(
              begin: const Offset(0.3, 0.3),
              end: const Offset(1, 1),
              duration: 220.ms,
              curve: Curves.easeOutBack,
            );
    final cell = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Motion.fast,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: highlight
              ? AppColors.primary.withValues(alpha: 0.18)
              : Theme.of(context).colorScheme.surface,
          borderRadius: Radii.card,
          border: Border.all(
            color: highlight ? AppColors.primary : AppColors.border,
            width: highlight ? 2 : 1,
          ),
        ),
        child: mark,
      ),
    );
    // Winning cells breathe gently.
    return highlight
        ? cell
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(begin: 1, end: 1.06, duration: 700.ms, curve: Curves.easeInOut)
        : cell;
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
            style: t.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label, style: t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
      ],
    );
  }
}
