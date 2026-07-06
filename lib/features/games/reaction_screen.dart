import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'game_scores.dart';

/// Reaction speed — a simple focus/attention drill. Wait for green, then tap as
/// fast as you can. Shows your time and your best. Single page, fully local.
enum _Phase { idle, waiting, go, result, tooSoon }

class ReactionScreen extends StatefulWidget {
  const ReactionScreen({super.key});

  @override
  State<ReactionScreen> createState() => _ReactionState();
}

class _ReactionState extends State<ReactionScreen> {
  _Phase _phase = _Phase.idle;
  Timer? _timer;
  DateTime? _greenAt;
  int? _lastMs;
  int? _bestMs;
  final _rand = Random();

  @override
  void initState() {
    super.initState();
    GameScores.best('reaction').then((v) {
      if (mounted && v != null) setState(() => _bestMs = v);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tap() {
    switch (_phase) {
      case _Phase.idle:
      case _Phase.result:
      case _Phase.tooSoon:
        _arm();
      case _Phase.waiting:
        // Tapped before green.
        _timer?.cancel();
        HapticFeedback.heavyImpact();
        setState(() => _phase = _Phase.tooSoon);
      case _Phase.go:
        final ms = DateTime.now().difference(_greenAt!).inMilliseconds;
        HapticFeedback.mediumImpact();
        setState(() {
          _lastMs = ms;
          if (_bestMs == null || ms < _bestMs!) _bestMs = ms;
          _phase = _Phase.result;
        });
        GameScores.record('reaction', ms, lowerIsBetter: true);
    }
  }

  void _arm() {
    setState(() => _phase = _Phase.waiting);
    final delay = 1200 + _rand.nextInt(3000); // 1.2–4.2s
    _timer = Timer(Duration(milliseconds: delay), () {
      if (!mounted) return;
      _greenAt = DateTime.now();
      setState(() => _phase = _Phase.go);
    });
  }

  ({Color bg, String big, String small}) get _look => switch (_phase) {
        _Phase.idle => (
            bg: AppColors.primary,
            big: 'Tap to start',
            small: 'Wait for green, then tap fast',
          ),
        _Phase.waiting => (
            bg: AppColors.accentDeep,
            big: 'Wait…',
            small: 'Tap the moment it turns green',
          ),
        _Phase.go => (
            bg: const Color(0xFF3FA46A),
            big: 'TAP!',
            small: '',
          ),
        _Phase.result => (
            bg: AppColors.primary,
            big: '$_lastMs ms',
            small: _bestMs != null ? 'Best $_bestMs ms · tap to retry' : 'Tap to retry',
          ),
        _Phase.tooSoon => (
            bg: AppColors.intensityHigh,
            big: 'Too soon!',
            small: 'Wait for green · tap to retry',
          ),
      };

  @override
  Widget build(BuildContext context) {
    final look = _look;
    return Scaffold(
      appBar: AppBar(title: const Text('Reaction speed')),
      body: GestureDetector(
        onTap: _tap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          color: look.bg,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(Insets.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    look.big,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  if (look.small.isNotEmpty) ...[
                    const SizedBox(height: Insets.md),
                    Text(
                      look.small,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 15),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
