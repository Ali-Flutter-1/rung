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

/// Memory match — flip cards two at a time and find the pairs. Each level adds
/// more pairs (6 → 8 → 10 → 12): clear the board and tap Next for a bigger one.
/// Fully local. Best = highest level reached.
class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchState();
}

class _MemoryMatchState extends State<MemoryMatchScreen> {
  static const _allFaces = [
    '🦊',
    '🦉',
    '🌿',
    '🌙',
    '⭐',
    '🌸',
    '🐢',
    '🐝',
    '🍄',
    '🌵',
    '🐙',
    '🦋',
    '🐳',
    '🌻',
    '🍀',
    '🐬',
  ];

  int _level = 1;
  late List<String> _cards;
  final Set<int> _matched = {};
  final List<int> _flipped = [];
  int _moves = 0;
  bool _busy = false;
  int? _best; // highest level reached
  late final ConfettiController _confetti;

  int get _pairs => (4 + _level * 2).clamp(6, 12); // L1=6 … L4+=12 pairs

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    GameScores.best('memoryLevel').then((v) {
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
    final faces = [..._allFaces]..shuffle();
    final chosen = faces.take(_pairs).toList();
    setState(() {
      _cards = [...chosen, ...chosen]..shuffle();
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
        if (_best == null || _level > _best!) setState(() => _best = _level);
        GameScores.record('memoryLevel', _level);
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

  void _next() {
    setState(() => _level += 1);
    _deal();
  }

  // Keep the grid balanced: 4 columns up to 8 pairs, 5 beyond.
  int get _cols => _cards.length <= 16 ? 4 : 5;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.gameTitleMemory),
        actions: [
          gameHelpAction(context, l.gameTitleMemory, [
            l.mmRule1,
            l.mmRule2,
            l.mmRule3,
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
                  heading: _won
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
                    child: GameBoardFrame(
                      accent: _accent,
                      child: GridView.count(
                        crossAxisCount: _cols,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        shrinkWrap: true,
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
                GamePillButton(
                  label: _won ? l.gameNextLevel : l.mmShuffle,
                  accent: _accent,
                  onTap: () => _won ? _next() : _deal(),
                ),
              ],
            ),
          ),
        ),
      ),
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
    return Semantics(
      button: true,
      selected: matched,
      label: up ? face : null,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child:
              AnimatedContainer(
                    duration: Motion.fast,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: up
                          ? (matched
                                ? AppColors.primary.withValues(alpha: 0.16)
                                : Theme.of(context).colorScheme.surface)
                          : AppColors.primaryDeep,
                      borderRadius: Radii.card,
                      border: Border.all(
                        color: matched
                            ? AppColors.primary
                            : Theme.of(context).colorScheme.outline,
                        width: matched ? 2 : 1,
                      ),
                    ),
                    child: up
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                face,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.psychology_alt_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                  )
                  // Flip when the face changes; a soft pop when it's matched.
                  .animate(key: ValueKey('$up-$matched'))
                  .flipH(duration: 260.ms, curve: Curves.easeOut),
        ),
      ),
    );
  }
}
