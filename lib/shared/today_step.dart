import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../app/router.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../domain/entities/today_suggestion.dart';
import '../l10n/app_localizations.dart';
import 'difficulty_badge.dart';
import 'track_visuals.dart';

/// The single "today's step" card (§8.1) — reused on the Dashboard.
class TodayStepCard extends StatelessWidget {
  const TodayStepCard({super.key, required this.suggestion});

  final TodaySuggestion suggestion;

  ({String label, String cta, IconData icon}) _framing(AppLocalizations l) =>
      switch (suggestion.reason) {
        TodayReason.resumeInProgress => (
            label: l.todayResume,
            cta: l.todayResumeCta,
            icon: Icons.play_circle_outline_rounded,
          ),
        TodayReason.nextInActiveTrack => (
            label: l.todayNext,
            cta: l.todayStartCta,
            icon: Icons.arrow_forward_rounded,
          ),
        TodayReason.varietyFromOtherTrack => (
            label: l.todayVariety,
            cta: l.todayStartCta,
            icon: Icons.auto_awesome_outlined,
          ),
        TodayReason.freshStart => (
            label: l.todayFresh,
            cta: l.todayStartCta,
            icon: Icons.flag_outlined,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final track = suggestion.track;
    final rung = suggestion.rung;
    final accent = TrackVisuals.color(track);
    final l = AppLocalizations.of(context);
    final f = _framing(l);

    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        borderRadius: Radii.lgAll,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.12),
            accent.withValues(alpha: 0.03)
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: accent.withValues(alpha: 0.15),
                child:
                    Icon(TrackVisuals.iconFor(track), color: accent, size: 20),
              ),
              const SizedBox(width: Insets.sm),
              Expanded(
                child: Text(track.title.toUpperCase(),
                    style: t.bodyMedium?.copyWith(
                        letterSpacing: 1,
                        color: accent,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: Insets.md),
          Text(f.label, style: t.bodyMedium),
          const SizedBox(height: Insets.xs),
          Text(rung.title, style: t.headlineSmall),
          const SizedBox(height: Insets.md),
          Row(
            children: [
              DifficultyBadge(difficulty: rung.difficulty, color: accent),
              const SizedBox(width: Insets.md),
              const Icon(Icons.schedule_rounded,
                  size: 15, color: AppColors.inkFaint),
              const SizedBox(width: 4),
              Text(l.todayMinutes(rung.estMinutes), style: t.bodyMedium),
            ],
          ),
          const SizedBox(height: Insets.lg),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: accent),
            onPressed: () {
              final a = suggestion.inProgressAttempt;
              if (a != null) {
                context.push(Routes.reflect(a.id));
              } else {
                context.push(Routes.predict(rung.id));
              }
            },
            icon: Icon(f.icon),
            label: Text(f.cta),
          ),
        ],
      ),
    );
  }
}

class StreakPill extends StatelessWidget {
  const StreakPill({super.key, required this.days});
  final int days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: Radii.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department_rounded,
              size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text('$days',
              style: const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class TodayStepSkeleton extends StatelessWidget {
  const TodayStepSkeleton({super.key});
  @override
  Widget build(BuildContext context) => Container(
        height: 240,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: Radii.lgAll,
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
}

class TodayStepEmpty extends StatelessWidget {
  const TodayStepEmpty({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: Radii.lgAll,
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded,
                color: AppColors.primary),
            const SizedBox(width: Insets.md),
            Expanded(
                child: Text(message,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
        ),
      ).animate().fadeIn(duration: 350.ms);
}
