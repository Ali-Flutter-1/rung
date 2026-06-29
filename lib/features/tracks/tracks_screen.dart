import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/today_suggestion.dart';
import '../../domain/entities/track.dart';
import '../../shared/help_now.dart';
import '../../shared/rung_logo.dart';
import '../../shared/skeleton.dart';
import '../../shared/track_visuals.dart';
import '../insights/insights_screen.dart';
import '../profile/safety_screen.dart';

class TracksScreen extends ConsumerWidget {
  const TracksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(tracksProvider);
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const RungWordmark(),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded),
            onSelected: (v) {
              if (v == 'insights') {
                ref.read(analyticsProvider).capture(Ev.insightViewed);
              }
              final page = switch (v) {
                'insights' => const InsightsScreen(),
                'safety' => const SafetyScreen(),
                _ => null,
              };
              if (page != null) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => page));
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'insights',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.insights_rounded),
                  title: Text('Insights'),
                ),
              ),
              PopupMenuItem(
                value: 'safety',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.health_and_safety_outlined),
                  title: Text('Is this right for me?'),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: const HelpNowButton(),
      body: tracks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load tracks.\n$e')),
        data: (list) => ListView(
          padding: const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, 96),
          children: [
            Text('Your tracks', style: t.headlineMedium),
            const SizedBox(height: Insets.xs),
            Text('Small steps toward big confidence.', style: t.bodyMedium),
            const SizedBox(height: Insets.lg),
            const _ContinueCard(),
            for (final track in list) ...[
              _TrackCard(track: track),
              const SizedBox(height: Insets.md),
            ],
          ],
        ),
      ),
    );
  }
}

class _TrackCard extends ConsumerWidget {
  const _TrackCard({required this.track});
  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    final accent = TrackVisuals.color(track);
    final ladderA = ref.watch(ladderProvider(track.id));
    final clearedA = ref.watch(clearedRungIdsProvider);
    final loading = !ladderA.hasValue || !clearedA.hasValue;
    final ladder = ladderA.asData?.value ?? const [];
    final cleared = clearedA.asData?.value ?? const {};
    final total = ladder.length;
    final done = ladder.where((r) => cleared.contains(r.id)).length;
    final pct = total == 0 ? 0.0 : done / total;
    final pctLabel = (pct * 100).round();
    return InkWell(
      borderRadius: Radii.lgAll,
      onTap: () => context.go(Routes.ladder(track.id)),
      child: Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.10),
          borderRadius: Radii.lgAll,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(TrackVisuals.iconFor(track), color: accent),
                ),
                const Spacer(),
                loading
                    ? const Skeleton(width: 64, height: 14)
                    : Text('$pctLabel% done',
                        style:
                            t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
              ],
            ),
            const SizedBox(height: Insets.md),
            Text(track.title, style: t.titleLarge),
            const SizedBox(height: 2),
            loading
                ? const Skeleton(width: 90, height: 14)
                : Text('$done of $total rungs',
                    style: t.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
            const SizedBox(height: Insets.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: loading ? null : pct, // indeterminate while settling
                minHeight: 6,
                backgroundColor: Colors.white.withValues(alpha: 0.6),
                valueColor: AlwaysStoppedAnimation(accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A pinned "pick up where you left off" card — only shown when the user has an
/// in-progress attempt or a clear next step in an active track.
class _ContinueCard extends ConsumerWidget {
  const _ContinueCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestion = ref.watch(todaysRungProvider).asData?.value;
    if (suggestion == null) return const SizedBox.shrink();
    final relevant = suggestion.reason == TodayReason.resumeInProgress ||
        suggestion.reason == TodayReason.nextInActiveTrack;
    if (!relevant) return const SizedBox.shrink();

    final t = Theme.of(context).textTheme;
    final accent = TrackVisuals.color(suggestion.track);
    final resume = suggestion.inProgressAttempt != null;
    final cleared = ref.watch(clearedRungIdsProvider).asData?.value ?? const {};
    final ladder =
        ref.watch(ladderProvider(suggestion.track.id)).asData?.value ?? const [];
    final done = ladder.where((r) => cleared.contains(r.id)).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.lg),
      child: InkWell(
        borderRadius: Radii.lgAll,
        onTap: () => resume
            ? context.push(Routes.reflect(suggestion.inProgressAttempt!.id))
            : context.push(Routes.predict(suggestion.rung.id)),
        child: Container(
          padding: const EdgeInsets.all(Insets.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: Radii.lgAll,
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.10),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resume
                          ? 'CONTINUE WHERE YOU LEFT OFF'
                          : 'YOUR NEXT STEP',
                      style: t.bodyMedium?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(suggestion.rung.title,
                        style: t.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('${suggestion.track.title} · $done of ${ladder.length} climbed',
                        style: t.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(width: Insets.md),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  resume
                      ? Icons.play_arrow_rounded
                      : Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
