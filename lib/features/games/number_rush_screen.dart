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

/// Brand teal — the app's primary colour.
const _accent = [AppColors.primary, AppColors.primaryDeep];

/// Number Rush — tap the numbers 1, 2, 3 … in order as fast as you can. Each
/// level grows the grid (3×3 → 4×4 → 5×5). Trains focused attention. Fully
/// local. Best = highest level reached.
class NumberRushScreen extends StatefulWidget {
  const NumberRushScreen({super.key});

  @override
  State<NumberRushScreen> createState() => _NumberRushState();
}

class _NumberRushState extends State<NumberRushScreen> {
  int _level = 1;
  late int _n;
  late List<int> _cells; // shuffled 1..n²
  int _next = 1; // number to tap next
  bool _cleared = false;
  int? _wrong; // index briefly flashed on a mis-tap
  int? _best;
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    GameScores.best('order').then((v) {
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
    _n = (2 + level).clamp(3, 5); // L1=3×3, L2=4×4, L3+=5×5
    setState(() {
      _cells = [for (var i = 1; i <= _n * _n; i++) i]..shuffle();
      _next = 1;
      _cleared = false;
      _wrong = null;
    });
  }

  void _tap(int i) {
    if (_cleared) return;
    if (_cells[i] != _next) {
      Haptics.light();
      setState(() => _wrong = i);
      Future.delayed(const Duration(milliseconds: 220), () {
        if (mounted) setState(() => _wrong = null);
      });
      return;
    }
    Haptics.selection();
    setState(() => _next++);
    if (_next > _n * _n) {
      Haptics.medium();
      _confetti.play();
      setState(() => _cleared = true);
      if (_best == null || _level > _best!) setState(() => _best = _level);
      GameScores.record('order', _level);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.gameTitleOrder),
        actions: [
          gameHelpAction(context, l.gameTitleOrder, [
            l.orderRule1,
            l.orderRule2,
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
                  sub: _cleared
                      ? (_best != null ? l.gamesBestLevel(_best!) : '')
                      : l.orderNextLabel(_next),
                  accent: _accent,
                ),
                const SizedBox(height: Insets.md),
                GameProgressBar(
                  value: (_next - 1) / (_n * _n),
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
                            for (var i = 0; i < _cells.length; i++)
                              _NumCell(
                                value: _cells[i],
                                done: _cells[i] < _next,
                                wrong: _wrong == i,
                                onTap: () => _tap(i),
                              ),
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
                  onTap: () => _cleared ? _start(_level + 1) : _start(_level),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NumCell extends StatelessWidget {
  const _NumCell({
    required this.value,
    required this.done,
    required this.wrong,
    required this.onTap,
  });
  final int value;
  final bool done;
  final bool wrong;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Motion.fast,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: done
              ? _accent.last.withValues(alpha: 0.12)
              : (wrong ? cs.error : cs.surface),
          borderRadius: Radii.card,
          border: Border.all(
            color: done ? _accent.first : cs.outline,
            width: done ? 2 : 1,
          ),
        ),
        child: done
            ? Icon(Icons.check_rounded, color: _accent.last, size: 20)
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    '$value',
                    style: TextStyle(
                      color: wrong ? Colors.white : cs.onSurface,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
