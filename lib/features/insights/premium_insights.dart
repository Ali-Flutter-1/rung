import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/attempt.dart';
import '../../domain/entities/subscription.dart';

/// Premium "Deeper insights": a this-month fear-vs-reality summary computed from
/// the user's attempts. Free users see a locked teaser with an upgrade CTA.
class PremiumInsights extends ConsumerWidget {
  const PremiumInsights({super.key, required this.attempts});
  final List<Attempt> attempts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsChangesProvider);
    final isPremium =
        ref.watch(settingsRepositoryProvider).subscriptionTier.isPremium;
    return isPremium ? _unlocked(context) : _locked(context);
  }

  // ── Free: locked teaser ────────────────────────────────────────────────────
  Widget _locked(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        borderRadius: Radii.lgAll,
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.insights_rounded, color: AppColors.primary),
              const SizedBox(width: Insets.sm),
              Text('Deeper insights', style: t.titleMedium),
              const Spacer(),
              const Icon(Icons.lock_rounded, size: 16, color: AppColors.inkMuted),
            ],
          ),
          const SizedBox(height: Insets.sm),
          Text(
            'See your month at a glance — how much your fear ran hotter than '
            'reality, and how often you over-predicted it. A Premium perk.',
            style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
          ),
          const SizedBox(height: Insets.md),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonalIcon(
              onPressed: () => context.go(Routes.subscription),
              icon: const Icon(Icons.workspace_premium_outlined, size: 18),
              label: const Text('Unlock with Premium'),
            ),
          ),
        ],
      ),
    );
  }

  // ── Premium: the real summary ──────────────────────────────────────────────
  Widget _unlocked(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final prevStart = DateTime(now.year, now.month - 1, 1);

    bool counts(Attempt a) =>
        a.actualSuds != null && (a.outcome?.counts ?? false);
    final thisMonth =
        attempts.where((a) => counts(a) && !a.createdAt.isBefore(monthStart));
    final lastMonth = attempts.where((a) =>
        counts(a) &&
        !a.createdAt.isBefore(prevStart) &&
        a.createdAt.isBefore(monthStart));

    final n = thisMonth.length;
    final lastN = lastMonth.length;

    Widget body;
    if (n == 0) {
      body = Text(
        'No steps logged yet this month. Face a couple and your summary '
        'appears here.',
        style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
      );
    } else {
      final avgGap =
          thisMonth.map((a) => a.predictedSuds - a.actualSuds!).reduce((x, y) => x + y) /
              n;
      final overCount =
          thisMonth.where((a) => a.predictedSuds > a.actualSuds!).length;
      final overRate = (overCount / n * 100).round();
      final trend = n - lastN;

      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$n',
                  style: t.displaySmall?.copyWith(
                      color: AppColors.primaryDeep,
                      fontWeight: FontWeight.w800)),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('fears faced this month', style: t.bodyLarge),
              ),
            ],
          ),
          if (lastN > 0) ...[
            const SizedBox(height: 2),
            _Trend(trend: trend),
          ],
          const SizedBox(height: Insets.md),
          _Line(
            icon: Icons.trending_down_rounded,
            text: avgGap > 0.2
                ? 'Your fear ran ${avgGap.toStringAsFixed(1)} points hotter than reality, on average.'
                : avgGap < -0.2
                    ? 'Reality was a bit tougher than you predicted this month — that\'s brave data too.'
                    : 'Your predictions were about spot-on this month.',
          ),
          const SizedBox(height: Insets.sm),
          _Line(
            icon: Icons.psychology_alt_outlined,
            text: 'You over-predicted the fear $overRate% of the time.',
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        borderRadius: Radii.lgAll,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.accent.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.insights_rounded, color: AppColors.primary),
              const SizedBox(width: Insets.sm),
              Text('Deeper insights', style: t.titleMedium),
            ],
          ),
          const SizedBox(height: Insets.md),
          body,
        ],
      ),
    );
  }
}

class _Trend extends StatelessWidget {
  const _Trend({required this.trend});
  final int trend;
  @override
  Widget build(BuildContext context) {
    final up = trend >= 0;
    final color = up ? AppColors.primary : AppColors.inkMuted;
    final label = trend == 0
        ? 'Same as last month'
        : up
            ? '${trend.abs()} more than last month'
            : '${trend.abs()} fewer than last month';
    return Row(
      children: [
        Icon(up ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            size: 14, color: color),
        const SizedBox(width: 4),
        Text(label,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(color: color)),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: Insets.sm),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
      ],
    );
  }
}
