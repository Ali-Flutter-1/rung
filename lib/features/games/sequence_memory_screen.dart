import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'game_scores.dart';

/// Sequence memory — watch the pattern, then repeat it. It grows by one each
/// round. A calm working-memory drill. Single page, fully local.
enum _Phase { idle, showing, input, over }

class SequenceMemoryScreen extends StatefulWidget {
  const SequenceMemoryScreen({super.key});

  @override
  State<SequenceMemoryScreen> createState() => _SequenceMemoryState();
}

class _SequenceMemoryState extends State<SequenceMemoryScreen> {
  static const _tileColors = [
    Color(0xFF3AA8A0), // teal
    Color(0xFFF2A65A), // amber
    Color(0xFF6B8FC9), // blue
    Color(0xFFE0899C), // rose
  ];

  final List<int> _seq = [];
  int _userIdx = 0;
  int? _best;
  int? _lit; // currently highlighted tile
  _Phase _phase = _Phase.idle;
  final _rand = Random();

  @override
  void initState() {
    super.initState();
    GameScores.best('sequence').then((v) {
      if (mounted && v != null) setState(() => _best = v);
    });
  }

  int get _reached => _seq.isEmpty ? 0 : _seq.length - 1;

  Future<void> _start() async {
    _seq.clear();
    await _nextRound();
  }

  Future<void> _nextRound() async {
    _seq.add(_rand.nextInt(4));
    if (!mounted) return;
    setState(() {
      _userIdx = 0;
      _phase = _Phase.showing;
    });
    await _playSequence();
    if (!mounted) return;
    setState(() => _phase = _Phase.input);
  }

  Future<void> _playSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (final tile in _seq) {
      if (!mounted) return;
      setState(() => _lit = tile);
      await Future.delayed(const Duration(milliseconds: 420));
      if (!mounted) return;
      setState(() => _lit = null);
      await Future.delayed(const Duration(milliseconds: 180));
    }
  }

  Future<void> _tapTile(int i) async {
    // Guard against a fast second tap slipping in during the flash delay:
    // resolve correctness + advance SYNCHRONOUSLY before any await.
    if (_phase != _Phase.input || _userIdx >= _seq.length) return;
    HapticFeedback.selectionClick();
    final correct = i == _seq[_userIdx];

    // Flash the tapped tile (fire-and-forget; don't block the game logic).
    setState(() => _lit = i);
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted && _lit == i) setState(() => _lit = null);
    });

    if (!correct) {
      HapticFeedback.heavyImpact();
      setState(() {
        if (_best == null || _reached > _best!) _best = _reached;
        _phase = _Phase.over;
      });
      GameScores.record('sequence', _reached);
      return;
    }

    _userIdx++;
    if (_userIdx == _seq.length) {
      setState(() => _phase = _Phase.showing); // blocks further taps
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      await _nextRound();
    }
  }

  String get _status => switch (_phase) {
        _Phase.idle => 'Watch the pattern, then repeat it.',
        _Phase.showing => 'Watch…',
        _Phase.input => 'Your turn · ${_userIdx + 1} of ${_seq.length}',
        _Phase.over => _best != null
            ? 'You reached $_reached · best $_best'
            : 'You reached $_reached',
      };

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final showStart = _phase == _Phase.idle || _phase == _Phase.over;
    return Scaffold(
      appBar: AppBar(title: const Text('Sequence memory')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              const SizedBox(height: Insets.sm),
              Text('Round ${_seq.isEmpty ? 0 : _seq.length}',
                  style: t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
              const SizedBox(height: 4),
              Text(_status, style: t.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: Insets.lg),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var i = 0; i < 4; i++)
                          GestureDetector(
                            onTap: () => _tapTile(i),
                            behavior: HitTestBehavior.opaque,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              decoration: BoxDecoration(
                                color: _tileColors[i].withValues(
                                    alpha: _lit == i ? 1 : 0.30),
                                borderRadius: Radii.lgAll,
                                border: Border.all(
                                  color: _lit == i
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Insets.lg),
              if (showStart)
                GestureDetector(
                  onTap: _start,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: Radii.pill,
                    ),
                    child: Text(_phase == _Phase.over ? 'Play again' : 'Start',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                  ),
                )
              else
                const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
