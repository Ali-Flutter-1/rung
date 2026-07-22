import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../domain/entities/attempt.dart';

/// The "Bravery Gap" card — predicted vs actual evidence (§1.5). Reusable on
/// the Dashboard.
class GapInsightCard extends StatelessWidget {
  const GapInsightCard({super.key, required this.exposures});
  final List<Attempt> exposures;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final avgPred =
        exposures.map((e) => e.predictedSuds).reduce((a, b) => a + b) /
            exposures.length;
    final avgAct = exposures.map((e) => e.actualSuds!).reduce((a, b) => a + b) /
        exposures.length;
    final gap = avgPred - avgAct;
    final overestimateRate = exposures
            .where((e) => e.predictedSuds > (e.actualSuds ?? e.predictedSuds))
            .length /
        exposures.length;

    final takeaway = gap > 0.5
        ? 'On average your fear runs ${gap.toStringAsFixed(1)} points hotter than '
            'reality. ${(overestimateRate * 100).round()}% of the time, it was '
            'easier than you predicted.'
        : gap < -0.5
            ? "Lately things have felt about as hard as you expected — and "
                "you're still showing up. Keep going."
            : "Your predictions are landing close to reality. That calibration "
                "is real progress.";

    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        // Translucent so it darkens in dark mode (theme text stays readable).
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: Radii.lgAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your brain vs. reality', style: t.titleMedium),
          const SizedBox(height: Insets.sm),
          Text(takeaway, style: t.bodyLarge),
          const SizedBox(height: Insets.lg),
          _AvgBar(label: 'Predicted', value: avgPred, color: AppColors.inkMuted),
          const SizedBox(height: Insets.sm),
          _AvgBar(label: 'Actual', value: avgAct, color: AppColors.primary),
          const SizedBox(height: Insets.lg),
          Row(
            children: [
              _Legend(color: AppColors.inkFaint, label: 'Predicted'),
              const SizedBox(width: Insets.md),
              _Legend(color: AppColors.primary, label: 'Actual'),
            ],
          ),
          const SizedBox(height: Insets.sm),
          _GapChart(exposures: exposures),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 4,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      );
}

class _AvgBar extends StatelessWidget {
  const _AvgBar(
      {required this.label, required this.value, required this.color});
  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(width: 72, child: Text(label, style: t.bodyMedium)),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: value / 10,
              minHeight: 12,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(width: Insets.sm),
        SizedBox(
          width: 32,
          child: Text(value.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: t.titleMedium?.copyWith(color: color)),
        ),
      ],
    );
  }
}

/// Predicted (grey) vs actual (teal) over recent attempts — the gap between
/// the lines IS the evidence that fear over-predicts (§1.5).
class _GapChart extends StatelessWidget {
  const _GapChart({required this.exposures});
  final List<Attempt> exposures;

  @override
  Widget build(BuildContext context) {
    final items = exposures.length > 14
        ? exposures.sublist(exposures.length - 14)
        : exposures;
    final predicted = <FlSpot>[];
    final actual = <FlSpot>[];
    for (var i = 0; i < items.length; i++) {
      predicted.add(FlSpot(i.toDouble(), items[i].predictedSuds.toDouble()));
      actual.add(FlSpot(i.toDouble(), (items[i].actualSuds ?? 0).toDouble()));
    }

    final t = Theme.of(context).textTheme;
    LineChartBarData bar(List<FlSpot> spots, Color color, {bool dashed = false}) =>
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.3,
          preventCurveOverShooting: true,
          color: color,
          barWidth: dashed ? 2 : 3.5,
          dashArray: dashed ? [5, 4] : null,
          // Dots only on the "reality" line — white core with a coloured ring.
          dotData: FlDotData(
            show: !dashed,
            getDotPainter: (s, _, _, _) => FlDotCirclePainter(
                radius: 3.5,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: color),
          ),
          belowBarData: BarAreaData(
            show: !dashed,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withValues(alpha: 0.28),
                color.withValues(alpha: 0.0),
              ],
            ),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _legend(AppColors.inkFaint, 'Fear', t),
            const SizedBox(width: Insets.md),
            _legend(AppColors.primary, 'Reality', t),
          ],
        ),
        const SizedBox(height: Insets.md),
        SizedBox(
          height: 156,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: 10,
              minX: 0,
              maxX: (items.length - 1).toDouble().clamp(1, double.infinity),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 5,
                getDrawingHorizontalLine: (_) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.6),
                    strokeWidth: 1,
                    dashArray: [4, 4]),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5,
                    reservedSize: 22,
                    getTitlesWidget: (v, _) => Text('${v.toInt()}',
                        style: t.bodySmall?.copyWith(color: t.bodyMedium?.color)),
                  ),
                ),
              ),
              lineTouchData: const LineTouchData(enabled: false),
              lineBarsData: [
                bar(predicted, AppColors.inkFaint, dashed: true),
                bar(actual, AppColors.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _legend(Color color, String label, TextTheme t) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 4,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: t.bodySmall
                ?.copyWith(color: AppColors.inkMuted, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: Insets.sm),
          Text(value, style: t.displaySmall?.copyWith(color: color)),
          Text(label, style: t.bodyMedium),
        ],
      ),
    );
  }
}

class AttemptHistoryTile extends StatelessWidget {
  const AttemptHistoryTile({super.key, required this.attempt});
  final Attempt attempt;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final inProgress = attempt.isInProgress;
    final skipped = attempt.outcome == Outcome.skipped;
    final gap = attempt.predictionGap;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            inProgress
                ? Icons.timelapse_rounded
                : skipped
                    ? Icons.nightlight_outlined
                    : Icons.check_circle_outline,
            size: 18,
            color: inProgress
                ? AppColors.primary
                : skipped
                    ? AppColors.inkFaint
                    : AppColors.primary,
          ),
          const SizedBox(width: Insets.sm),
          Expanded(
            child: Text(
              inProgress
                  ? 'In progress — predicted ${attempt.predictedSuds}'
                  : skipped
                      ? 'Not today'
                      : 'Predicted ${attempt.predictedSuds} · actual ${attempt.actualSuds}',
              style: t.bodyLarge,
            ),
          ),
          if (!inProgress && !skipped && gap != null && gap > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: Radii.pill,
              ),
              child: Text('−$gap',
                  style: const TextStyle(
                      color: AppColors.primaryDeep,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
            ),
        ],
      ),
    );
  }
}

class GapEmpty extends StatelessWidget {
  const GapEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: Radii.lgAll,
      ),
      child: Column(
        children: [
          const Icon(Icons.insights_rounded, color: AppColors.primary, size: 32)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(
                  begin: 1, end: 1.12, duration: 1600.ms, curve: Curves.easeInOut),
          const SizedBox(height: Insets.md),
          Text('Your evidence is coming',
              style: t.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: Insets.sm),
          Text(
            'Log a couple of attempts and this is where you\'ll see, in your own '
            'numbers, how your fear compares to reality.',
            textAlign: TextAlign.center,
            style: t.bodyMedium,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0, curve: Curves.easeOut);
  }
}
