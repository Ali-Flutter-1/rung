import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// A calm 60-second guided breath, offered right before a rung attempt.
/// A single expanding/contracting circle paces a gentle in–hold–out rhythm
/// (4s in · 4s hold · 6s out — a longer exhale to settle the nervous system).
/// Fully local, no dependencies. Push it as a full-screen dialog.
Future<void> openBreathing(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const BreathingScreen(),
    ),
  );
}

enum _Phase { inhale, hold, exhale }

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  static const _inhale = Duration(seconds: 4);
  static const _hold = Duration(seconds: 4);
  static const _exhale = Duration(seconds: 6);
  static const _total = Duration(seconds: 60);
  static const _minScale = 0.5;

  late final AnimationController _scale;

  /// Time spent breathing so far. Accumulated from the phase durations rather
  /// than read off a wall clock, so it advances in lockstep with the timers —
  /// which keeps the whole exercise deterministic (and testable).
  Duration _elapsed = Duration.zero;
  Timer? _phaseTimer;
  _Phase _phase = _Phase.inhale;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _scale = AnimationController(
      vsync: this,
      lowerBound: _minScale,
      upperBound: 1.0,
      value: _minScale,
    );
    _runPhase();
  }

  @override
  void dispose() {
    _phaseTimer?.cancel();
    _scale.dispose();
    super.dispose();
  }

  void _runPhase() {
    if (!mounted) return;
    // Finish only at the end of a full cycle so the exhale never cuts off short.
    if (_elapsed >= _total && _phase == _Phase.inhale) {
      _finish();
      return;
    }
    switch (_phase) {
      case _Phase.inhale:
        Haptics.selection();
        _scale.animateTo(1.0, duration: _inhale, curve: Curves.easeInOut);
        _phaseTimer = Timer(_inhale, () {
          if (!mounted) return;
          _elapsed += _inhale;
          setState(() => _phase = _Phase.hold);
          _runPhase();
        });
      case _Phase.hold:
        _phaseTimer = Timer(_hold, () {
          if (!mounted) return;
          _elapsed += _hold;
          setState(() => _phase = _Phase.exhale);
          _runPhase();
        });
      case _Phase.exhale:
        Haptics.selection();
        _scale.animateTo(_minScale, duration: _exhale, curve: Curves.easeInOut);
        _phaseTimer = Timer(_exhale, () {
          if (!mounted) return;
          _elapsed += _exhale;
          setState(() => _phase = _Phase.inhale);
          _runPhase();
        });
    }
  }

  void _finish() {
    _phaseTimer?.cancel();
    Haptics.medium();
    setState(() => _done = true);
  }

  String _phaseLabel(AppLocalizations l) => switch (_phase) {
        _Phase.inhale => l.breatheIn,
        _Phase.hold => l.breatheHold,
        _Phase.exhale => l.breatheOut,
      };

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!_done)
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text(l.breatheSkip),
            ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: _done ? _doneView(t, l) : _breathingView(t, l),
      ),
    );
  }

  Widget _breathingView(TextTheme t, AppLocalizations l) {
    return Column(
      children: [
        const Spacer(),
        Text(l.breatheIntro,
            textAlign: TextAlign.center,
            style: t.bodyLarge?.copyWith(color: AppColors.inkMuted)),
        const Spacer(),
        SizedBox(
          height: 260,
          child: Center(
            child: AnimatedBuilder(
              animation: _scale,
              builder: (context, _) {
                final size = 120 + (_scale.value - _minScale) * 260;
                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.35),
                        AppColors.primary.withValues(alpha: 0.12),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _phaseLabel(l),
                    style: t.titleLarge?.copyWith(color: AppColors.primaryDeep),
                  ),
                );
              },
            ),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Widget _doneView(TextTheme t, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.spa_rounded, size: 56, color: AppColors.primary),
          const SizedBox(height: Insets.lg),
          Text(l.breatheDoneTitle,
              textAlign: TextAlign.center, style: t.headlineSmall),
          const SizedBox(height: Insets.sm),
          Text(l.breatheDoneSub,
              textAlign: TextAlign.center,
              style: t.bodyLarge?.copyWith(color: AppColors.inkMuted)),
          const SizedBox(height: Insets.xl),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text(l.breatheDoneBtn),
            ),
          ),
        ],
      ),
    );
  }
}
