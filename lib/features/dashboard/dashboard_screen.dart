import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/attempt.dart';
import '../../shared/gap_insight.dart';
import '../../shared/help_now.dart';
import '../games/games_screen.dart';
import '../share/share_progress.dart';
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
    final settings = ref.watch(settingsRepositoryProvider);
    final weeklyGoal = settings.weeklyGoalSteps;
    final weeklyDone = ref.watch(weeklyCompletedCountProvider).asData?.value ?? 0;
    final weeklyRatio = weeklyGoal == 0
        ? 0.0
        : (weeklyDone / weeklyGoal).clamp(0.0, 1.0).toDouble();

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
                IconButton(
                  tooltip: 'Share my progress',
                  icon: const Icon(Icons.ios_share_rounded),
                  onPressed: () => showShareProgressSheet(context, ref),
                ),
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
            const SizedBox(height: Insets.lg),
            Container(
              padding: const EdgeInsets.all(Insets.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Radii.card,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Weekly goal', style: t.titleMedium),
                      const Spacer(),
                      PopupMenuButton<int>(
                        tooltip: 'Set weekly goal',
                        onSelected: settings.setWeeklyGoalSteps,
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 2, child: Text('2 steps/week')),
                          PopupMenuItem(value: 3, child: Text('3 steps/week')),
                          PopupMenuItem(value: 5, child: Text('5 steps/week')),
                          PopupMenuItem(value: 7, child: Text('7 steps/week')),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Insets.sm, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: Radii.pill,
                          ),
                          child: Text(
                            '$weeklyGoal/week',
                            style: t.bodyMedium?.copyWith(
                                color: AppColors.primaryDeep,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Insets.sm),
                  Text(
                    '$weeklyDone of $weeklyGoal steps completed this week',
                    style: t.bodyMedium,
                  ),
                  const SizedBox(height: Insets.sm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: weeklyRatio,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
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
            const SizedBox(height: Insets.lg),
            const _TakeABreakCard(),
          ],
        ),
      ),
    );
  }
}

/// A small, low-key entry to the offline games — a calm break, not a headline.
class _TakeABreakCard extends StatelessWidget {
  const _TakeABreakCard();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (_) => const GamesScreen()),
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          borderRadius: Radii.lgAll,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.accent.withValues(alpha: 0.14),
              AppColors.primary.withValues(alpha: 0.10),
            ],
          ),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.20),
              ),
              child: const Text('🎮', style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: Insets.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Take a break', style: t.titleMedium),
                  const SizedBox(height: 2),
                  Text('A few quiet games — vs the phone or a friend.',
                      style: t.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}
