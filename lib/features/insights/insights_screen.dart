import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/attempt.dart';
import '../../shared/gap_insight.dart';
import '../../shared/progress_widgets.dart';
import 'premium_insights.dart';

/// Full "Your growth" surface — stat cards, week strip, the Bravery-Gap chart,
/// per-track breakdown, and history. Reachable from the Rung tab's menu.
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    final attempts = ref.watch(recentAttemptsProvider).asData?.value ?? const [];
    final streak = ref.watch(streakProvider).asData?.value ?? 0;
    final cleared = ref.watch(totalClearedProvider).asData?.value ?? 0;
    final best = ref.watch(bestStreakProvider).asData?.value ?? 0;
    final activeDays = ref.watch(activeDaysProvider).asData?.value ?? const {};

    final exposures = attempts
        .where((a) => a.actualSuds != null && (a.outcome?.counts ?? false))
        .toList()
        .reversed
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your growth')),
      body: ListView(
        padding: const EdgeInsets.all(Insets.lg),
        children: [
          ProgressStatsRow(
            challenges: cleared,
            currentStreak: streak,
            bestStreak: best,
          ),
          const SizedBox(height: Insets.md),
          WeekStrip(activeDays: activeDays),
          const SizedBox(height: Insets.md),
          if (exposures.length < 2)
            const GapEmpty()
          else
            GapInsightCard(exposures: exposures),
          const SizedBox(height: Insets.md),
          PremiumInsights(attempts: attempts),
          const SizedBox(height: Insets.md),
          const CategoryBreakdown(),
          if (attempts.isNotEmpty) ...[
            const SizedBox(height: Insets.xl),
            Text('History', style: t.titleMedium),
            const SizedBox(height: Insets.sm),
            ...attempts.map((a) => AttemptHistoryTile(attempt: a)),
          ],
        ],
      ),
    );
  }
}
