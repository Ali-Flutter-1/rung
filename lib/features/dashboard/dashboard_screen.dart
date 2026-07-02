import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/attempt.dart';
import '../../shared/gap_insight.dart';
import '../../shared/help_now.dart';
import 'daily_check_in.dart';
import '../../shared/progress_widgets.dart';
import '../../shared/skeleton.dart';
import '../../shared/today_step.dart';

/// Tab 1 — a personal home: today's step + your progress (streak, Bravery Gap,
/// history). Insights now lives here.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(todaysRungProvider);
    final attempts = ref.watch(recentAttemptsProvider).asData?.value ?? const [];
    final t = Theme.of(context).textTheme;

    // Headline numbers come from local progress — the single source of truth.
    // (They survive an account switch via the cloud restore on sign-in, not by
    // displaying a cloud number the rest of the app can't back up.) While the
    // first values settle we show a shimmer skeleton, not a bare 0.
    final streakA = ref.watch(streakProvider);
    final clearedA = ref.watch(totalClearedProvider);
    final bestA = ref.watch(bestStreakProvider);
    final statsLoading =
        !streakA.hasValue || !clearedA.hasValue || !bestA.hasValue;
    final streak = streakA.asData?.value ?? 0;
    final cleared = clearedA.asData?.value ?? 0;
    final bestStreak = bestA.asData?.value ?? 0;

    final exposures = attempts
        .where((a) => a.actualSuds != null && (a.outcome?.counts ?? false))
        .toList()
        .reversed
        .toList();

    return Scaffold(
      floatingActionButton: const HelpNowButton(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Insets.lg, Insets.lg, Insets.lg, 96),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(_greeting,
                      style: t.headlineMedium, overflow: TextOverflow.ellipsis),
                ),
                if (streak > 0) StreakPill(days: streak),
              ],
            ),
            const SizedBox(height: Insets.xs),
            Text("Here's one small step for today.", style: t.bodyMedium),
            const SizedBox(height: Insets.lg),
            const DailyCheckIn(),
            today.when(
              loading: () => const TodayStepSkeleton(),
              error: (_, _) => const TodayStepEmpty(
                message: "Couldn't load today's step. Pull to retry.",
              ),
              data: (s) => s == null
                  ? const TodayStepEmpty(
                      message:
                          "You've cleared everything available — add a custom "
                          'rung or revisit one to keep the streak going.',
                    )
                  : TodayStepCard(suggestion: s),
            ),
            const SizedBox(height: Insets.xl),
            Text('Your growth', style: t.titleMedium),
            const SizedBox(height: Insets.md),
            statsLoading
                ? const StatsRowSkeleton()
                : ProgressStatsRow(
                    challenges: cleared,
                    currentStreak: streak,
                    bestStreak: bestStreak,
                  ),
            const SizedBox(height: Insets.md),
            WeekStrip(
              activeDays: ref.watch(activeDaysProvider).asData?.value ?? const {},
            ),
            const SizedBox(height: Insets.md),
            if (exposures.length < 2)
              const GapEmpty()
            else
              GapInsightCard(exposures: exposures),
          ],
        ),
      ),
    );
  }
}
