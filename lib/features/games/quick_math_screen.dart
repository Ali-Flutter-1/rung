import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'game_scores.dart';

/// Quick Math — a 30-second mental-speed sprint. Answer as many as you can;
/// a wrong tap costs 2 seconds. Single page, fully local.
enum _Phase { idle, playing, over }

class QuickMathScreen extends StatefulWidget {
  const QuickMathScreen({super.key});

  @override
  State<QuickMathScreen> createState() => _QuickMathState();
}

class _QuickMathState extends State<QuickMathScreen> {
  static const _total = 30;
  _Phase _phase = _Phase.idle;
  int _timeLeft = _total;
  int _score = 0;
  int _best = 0;
  Timer? _timer;
  final _rand = Random();

  int _a = 0, _b = 0, _answer = 0;
  String _op = '+';
  List<int> _options = [];
  int? _wrongTapped;

  @override
  void initState() {
    super.initState();
    GameScores.best('quickmath').then((v) {
      if (mounted && v != null) setState(() => _best = v);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    setState(() {
      _phase = _Phase.playing;
      _timeLeft = _total;
      _score = 0;
    });
    _nextQuestion();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) _end();
    });
  }

  void _end() {
    _timer?.cancel();
    setState(() {
      if (_score > _best) _best = _score;
      _phase = _Phase.over;
    });
    GameScores.record('quickmath', _score);
  }

  void _nextQuestion() {
    final op = ['+', '-', '×'][_rand.nextInt(3)];
    int a, b, ans;
    switch (op) {
      case '+':
        a = _rand.nextInt(20) + 1;
        b = _rand.nextInt(20) + 1;
        ans = a + b;
      case '-':
        a = _rand.nextInt(20) + 10;
        b = _rand.nextInt(a);
        ans = a - b;
      default:
        a = _rand.nextInt(9) + 2;
        b = _rand.nextInt(9) + 2;
        ans = a * b;
    }
    final opts = <int>{ans};
    while (opts.length < 4) {
      final delta = _rand.nextInt(11) - 5;
      final d = ans + (delta == 0 ? 3 : delta);
      if (d >= 0) opts.add(d);
    }
    setState(() {
      _a = a;
      _b = b;
      _op = op;
      _answer = ans;
      _options = opts.toList()..shuffle();
      _wrongTapped = null;
    });
  }

  void _answerTap(int v) {
    if (_phase != _Phase.playing) return;
    if (v == _answer) {
      HapticFeedback.selectionClick();
      setState(() => _score++);
      _nextQuestion();
    } else {
      HapticFeedback.heavyImpact();
      setState(() {
        _wrongTapped = v;
        _timeLeft = (_timeLeft - 2).clamp(0, _total);
      });
      if (_timeLeft <= 0) _end();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Math')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: _phase == _Phase.playing ? _playing(t) : _startOver(t),
        ),
      ),
    );
  }

  Widget _startOver(TextTheme t) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🧮', style: TextStyle(fontSize: 48)),
          const SizedBox(height: Insets.md),
          Text(
            _phase == _Phase.over ? 'Time! You scored $_score' : 'Quick Math',
            style: t.headlineSmall,
          ),
          const SizedBox(height: Insets.xs),
          Text(
            _phase == _Phase.over
                ? 'Best $_best · 30 seconds, answer as many as you can.'
                : '30 seconds. A wrong tap costs 2 seconds.',
            textAlign: TextAlign.center,
            style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
          ),
          const SizedBox(height: Insets.xl),
          GestureDetector(
            onTap: _start,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 14),
              decoration: BoxDecoration(
                  color: AppColors.primary, borderRadius: Radii.pill),
              child: Text(_phase == _Phase.over ? 'Play again' : 'Start',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playing(TextTheme t) {
    return Column(
      children: [
        Row(
          children: [
            Text('$_score',
                style: t.headlineSmall
                    ?.copyWith(color: AppColors.primaryDeep, fontWeight: FontWeight.w800)),
            const SizedBox(width: 6),
            Text('correct', style: t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
            const Spacer(),
            Icon(Icons.timer_outlined,
                size: 18,
                color: _timeLeft <= 5 ? AppColors.intensityHigh : AppColors.inkMuted),
            const SizedBox(width: 4),
            Text('$_timeLeft s',
                style: t.titleMedium?.copyWith(
                    color: _timeLeft <= 5
                        ? AppColors.intensityHigh
                        : AppColors.primaryDeep,
                    fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: Insets.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: _timeLeft / _total,
            minHeight: 6,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
          ),
        ),
        const Spacer(),
        Text('$_a  $_op  $_b',
            style: const TextStyle(fontSize: 46, fontWeight: FontWeight.w800)),
        const Spacer(),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.2,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final o in _options)
              GestureDetector(
                onTap: () => _answerTap(o),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _wrongTapped == o
                        ? AppColors.intensityHigh.withValues(alpha: 0.15)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: Radii.card,
                    border: Border.all(
                      color: _wrongTapped == o
                          ? AppColors.intensityHigh
                          : AppColors.border,
                    ),
                  ),
                  child: Text('$o',
                      style: t.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                ),
              ),
          ],
        ),
        const SizedBox(height: Insets.md),
      ],
    );
  }
}
