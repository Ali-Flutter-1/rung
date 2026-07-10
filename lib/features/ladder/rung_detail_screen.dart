import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../domain/entities/attempt.dart';
import '../../shared/rung_copy.dart';
import '../../shared/rung_cover.dart';
import '../../shared/track_visuals.dart';

class RungDetailScreen extends ConsumerWidget {
  const RungDetailScreen({super.key, required this.rungId});
  final String rungId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rungAsync = ref.watch(rungByIdProvider(rungId));
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: rungAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l.detailLoadError}\n$e')),
        data: (rung) {
          if (rung == null) {
            return Center(child: Text(l.detailNotExist));
          }
          final track = ref.watch(trackByIdProvider(rung.trackId)).asData?.value;
          final accent =
              track == null ? AppColors.primary : TrackVisuals.color(track);
          final inProgress =
              ref.watch(inProgressAttemptProvider).asData?.value;
          final resumable =
              inProgress != null && inProgress.rungId == rungId;
          final history = (ref.watch(recentAttemptsProvider).asData?.value ??
                  const <Attempt>[])
              .where((a) => a.rungId == rungId && !a.isInProgress)
              .toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(
                Insets.lg, 0, Insets.lg, Insets.xxl),
            children: [
              if (track != null) ...[
                RungCover(track: track, difficulty: rung.difficulty),
                const SizedBox(height: Insets.lg),
                Text(track.description.toUpperCase(),
                    style: t.bodyMedium?.copyWith(
                        color: accent,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700)),
              ],
              const SizedBox(height: Insets.sm),
              Text(rung.title, style: t.displaySmall),
              const SizedBox(height: Insets.xl),
              _Block(
                icon: Icons.checklist_rounded,
                accent: accent,
                title: l.detailWhatToDo,
                body: rung.whatToDoText(l),
              ),
              const SizedBox(height: Insets.md),
              _Block(
                icon: Icons.favorite_outline_rounded,
                accent: accent,
                title: l.detailWhyHelps,
                body: rung.whyItHelpsText(l),
              ),
              if (history.isNotEmpty) ...[
                const SizedBox(height: Insets.xl),
                Text(l.detailPastAttempts, style: t.titleMedium),
                const SizedBox(height: Insets.sm),
                ...history.map((a) => _HistoryRow(attempt: a)),
              ],
              const SizedBox(height: Insets.xl),
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: accent),
                onPressed: () => resumable
                    ? context.push(Routes.reflect(inProgress.id))
                    : context.push(Routes.predict(rung.id)),
                icon: Icon(resumable
                    ? Icons.play_circle_outline_rounded
                    : Icons.arrow_forward_rounded),
                label: Text(resumable ? l.todayResumeCta : l.detailDoThis),
              ),
              if (history.isNotEmpty) ...[
                const SizedBox(height: Insets.sm),
                Center(
                  child: Text(l.detailReattempt, style: t.bodyMedium),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color accent;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: Radii.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.titleMedium),
                const SizedBox(height: 4),
                Text(body, style: t.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.attempt});
  final Attempt attempt;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final gap = attempt.predictionGap;
    final outcomeLabel = switch (attempt.outcome) {
      Outcome.done => l.reflectOutcomeDone,
      Outcome.partial => l.reflectOutcomePartial,
      Outcome.skipped => l.reflectOutcomeNotToday,
      null => '',
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            attempt.outcome == Outcome.skipped
                ? Icons.remove_circle_outline
                : Icons.check_circle_outline,
            size: 18,
            color: attempt.outcome == Outcome.skipped
                ? AppColors.inkFaint
                : AppColors.primary,
          ),
          const SizedBox(width: Insets.sm),
          Text(outcomeLabel, style: t.bodyLarge),
          const Spacer(),
          if (attempt.actualSuds != null)
            Text(
              l.detailHistoryStat(attempt.predictedSuds, attempt.actualSuds!) +
                  (gap != null && gap > 0 ? '  (−$gap)' : ''),
              style: t.bodyMedium,
            ),
        ],
      ),
    );
  }
}
