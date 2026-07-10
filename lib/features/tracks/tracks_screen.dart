import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
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
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'insights',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.insights_rounded),
                  title: Text(l.menuInsights),
                ),
              ),
              PopupMenuItem(
                value: 'safety',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.health_and_safety_outlined),
                  title: Text(l.menuIsThisRight),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: const HelpNowButton(),
      body: tracks.when(
        loading: () => ListView(
          padding: const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, 96),
          children: [
            const Skeleton(width: 180, height: 28),
            const SizedBox(height: Insets.sm),
            const Skeleton(width: 240, height: 14),
            const SizedBox(height: Insets.lg),
            for (var i = 0; i < 3; i++) ...[
              const Skeleton(height: 132, radius: 20),
              const SizedBox(height: Insets.md),
            ],
          ],
        ),
        error: (e, _) => Center(child: Text('${l.tracksLoadError}\n$e')),
        data: (list) => ListView(
          padding: const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, 96),
          children: [
            Text(l.tracksTitle, style: t.headlineMedium),
            const SizedBox(height: Insets.xs),
            Text(l.tracksSubtitle, style: t.bodyMedium),
            const SizedBox(height: Insets.lg),
            const _ContinueCard(),
            for (final (i, track) in list.indexed) ...[
              _TrackCard(track: track)
                  .animate()
                  .fadeIn(duration: 260.ms, delay: (45 * i).ms)
                  .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
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
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        accent,
                        Color.lerp(accent, Colors.black, 0.25)!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(TrackVisuals.iconFor(track),
                      color: Colors.white, size: 24),
                ),
                const Spacer(),
                loading
                    ? const Skeleton(width: 64, height: 14)
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: Radii.pill,
                        ),
                        child: Text('$pctLabel%',
                            style: t.bodyMedium?.copyWith(
                                color: accent, fontWeight: FontWeight.w800)),
                      ),
              ],
            ),
            const SizedBox(height: Insets.md),
            Text(track.title, style: t.titleLarge),
            const SizedBox(height: 2),
            loading
                ? const Skeleton(width: 90, height: 14)
                : Text(AppLocalizations.of(context).tracksRungsCount(done, total),
                    style: t.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
            const SizedBox(height: Insets.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: loading
                  ? LinearProgressIndicator(
                      minHeight: 6, // indeterminate while settling
                      backgroundColor: Colors.white.withValues(alpha: 0.6),
                      valueColor: AlwaysStoppedAnimation(accent),
                    )
                  : TweenAnimationBuilder<double>(
                      // The bar fills in gently instead of snapping.
                      tween: Tween(begin: 0, end: pct),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutCubic,
                      builder: (_, v, _) => LinearProgressIndicator(
                        value: v,
                        minHeight: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.6),
                        valueColor: AlwaysStoppedAnimation(accent),
                      ),
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
                          ? AppLocalizations.of(context).tracksContinueLabel
                          : AppLocalizations.of(context).tracksNextStepLabel,
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
                    Text(
                        '${suggestion.track.title} · ${AppLocalizations.of(context).tracksClimbedCount(done, ladder.length)}',
                        style: t.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(width: Insets.md),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [accent, Color.lerp(accent, Colors.black, 0.25)!],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
