import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/attempt.dart';
import '../../domain/entities/rung.dart';
import '../../shared/track_visuals.dart';

/// RESULT — the prediction gap is the hero; quiet micro-celebration (§8.3).
class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key, required this.attemptId});
  final String attemptId;

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  Attempt? _attempt;
  Rung? _rung;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final a =
        await ref.read(attemptRepositoryProvider).getAttempt(widget.attemptId);
    final r = a == null
        ? null
        : await ref.read(trackRepositoryProvider).getRung(a.rungId);
    if (!mounted) return;
    setState(() {
      _attempt = a;
      _rung = r;
    });
    if (a != null && a.outcome != null && a.outcome!.counts) {
      Haptics.medium();
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = _attempt;
    final rung = _rung;
    if (a == null || rung == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final track = ref.watch(trackByIdProvider(rung.trackId)).asData?.value;
    final accent = track == null ? AppColors.primary : TrackVisuals.color(track);
    final cleared = a.outcome != null && a.outcome!.counts;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              Expanded(
                child: cleared
                    ? _ClearedView(attempt: a, rung: rung, accent: accent)
                    : _SkippedView(rung: rung, accent: accent),
              ),
              if (cleared) ...[
                _CopyWinButton(rung: rung),
                Text('Quiet delight in every step.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: Insets.sm),
              ],
              const SizedBox(height: Insets.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.go(Routes.ladder(rung.trackId)),
                      child: const Text('Back to ladder'),
                    ),
                  ),
                  const SizedBox(width: Insets.md),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: accent),
                      onPressed: () => context.go(Routes.dashboard),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClearedView extends StatelessWidget {
  const _ClearedView({
    required this.attempt,
    required this.rung,
    required this.accent,
  });
  final Attempt attempt;
  final Rung rung;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final predicted = attempt.predictedSuds;
    final actual = attempt.actualSuds ?? predicted;
    final gap = predicted - actual;

    final reduction = predicted == 0 ? 0 : ((gap / predicted) * 100).round();
    final (headline, sub) = switch (gap) {
      > 0 => (
          'You braced for $predicted. It came in at $actual.',
          'Your heart prepared for a heavy $predicted, but the world met you with a '
              'gentler $actual. Worth remembering.'
        ),
      0 => (
          'Right where you guessed.',
          "You called it — and you still showed up. That's the win."
        ),
      _ => (
          'Tougher than you guessed — and you did it.',
          'Some moments ask more of us. Showing up anyway is the whole point.'
        ),
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Quiet micro-celebration: a soft ripple + scaling check (§8.3).
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withValues(alpha: 0.12),
              ),
            )
                .animate()
                .scale(
                    begin: const Offset(0.4, 0.4),
                    end: const Offset(1.4, 1.4),
                    duration: Motion.celebrate,
                    curve: Curves.easeOut)
                .fadeOut(delay: 400.ms, duration: 900.ms),
            CircleAvatar(
              radius: 44,
              backgroundColor: accent,
              child: const Icon(Icons.check_rounded,
                  color: Colors.white, size: 44),
            ).animate().scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 360.ms,
                  curve: Curves.easeOutBack,
                ),
          ],
        ),
        const SizedBox(height: Insets.xl),
        Text(headline,
            textAlign: TextAlign.center, style: t.headlineMedium)
            .animate()
            .fadeIn(delay: 200.ms),
        const SizedBox(height: Insets.md),
        // The number comparison is the hero (§4.3).
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GapStat(label: 'Predicted', value: predicted, color: AppColors.inkMuted),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Icon(Icons.arrow_forward_rounded, color: accent),
            ),
            _GapStat(label: 'Actual', value: actual, color: accent),
          ],
        ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.15, end: 0),
        if (gap > 0) ...[
          const SizedBox(height: Insets.lg),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.md, vertical: Insets.sm),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: Radii.pill,
            ),
            child: Text('This moment was $reduction% lighter than you feared',
                style: t.titleMedium?.copyWith(color: AppColors.primaryDeep)),
          ).animate().fadeIn(delay: 450.ms),
        ],
        const SizedBox(height: Insets.lg),
        Text(sub, textAlign: TextAlign.center, style: t.bodyLarge)
            .animate()
            .fadeIn(delay: 500.ms),
      ],
    );
  }
}

class _GapStat extends StatelessWidget {
  const _GapStat(
      {required this.label, required this.value, required this.color});
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value',
            style: TextStyle(
                fontSize: 56, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _SkippedView extends StatelessWidget {
  const _SkippedView({required this.rung, required this.accent});
  final Rung rung;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.surfaceAlt,
          child: Icon(Icons.nightlight_outlined, color: accent, size: 36),
        ),
        const SizedBox(height: Insets.xl),
        Text('Logged — no pressure.',
            textAlign: TextAlign.center, style: t.headlineSmall),
        const SizedBox(height: Insets.md),
        Text(
          "Not today is a perfectly good answer. This rung is still here "
          "whenever you're ready.",
          textAlign: TextAlign.center,
          style: t.bodyLarge,
        ),
      ],
    );
  }
}

class _CopyWinButton extends StatelessWidget {
  const _CopyWinButton({required this.rung});
  final Rung rung;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        final text =
            'I just did something I used to avoid: ${rung.title.toLowerCase()}. '
            'One small rung climbed. 🪜 #Rung';
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Win copied — paste it wherever you like.'),
          ),
        );
      },
      icon: const Icon(Icons.ios_share_rounded, size: 18),
      label: const Text('Copy my win'),
    );
  }
}
