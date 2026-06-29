import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import 'track_visuals.dart';

String _dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// Three headline stat cards: Challenges · Current Streak · Best Streak.
class ProgressStatsRow extends StatelessWidget {
  const ProgressStatsRow({
    super.key,
    required this.challenges,
    required this.currentStreak,
    required this.bestStreak,
  });

  final int challenges;
  final int currentStreak;
  final int bestStreak;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.done_all_rounded,
            tint: AppColors.primary,
            value: '$challenges',
            label: 'Challenges',
          ),
        ),
        const SizedBox(width: Insets.md),
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            tint: AppColors.accentDeep,
            value: '$currentStreak',
            label: 'Current Streak',
          ),
        ),
        const SizedBox(width: Insets.md),
        Expanded(
          child: _StatCard(
            icon: Icons.emoji_events_outlined,
            tint: AppColors.accentDeep,
            value: '$bestStreak',
            label: 'Best Streak',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.tint,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final Color tint;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Insets.md, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: tint, size: 22),
          ),
          const SizedBox(height: Insets.sm),
          Text(value,
              style: t.headlineMedium, maxLines: 1, overflow: TextOverflow.clip),
          Text(label,
              style: t.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

/// "This Week" — Sun→Sat dots, filled for days with a counting attempt.
class WeekStrip extends StatelessWidget {
  const WeekStrip({super.key, required this.activeDays});
  final Set<String> activeDays; // day-keys yyyy-mm-dd

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Start from Sunday of the current week.
    final startOfWeek = today.subtract(Duration(days: today.weekday % 7));
    const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('This Week', style: t.titleMedium),
          const SizedBox(height: Insets.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < 7; i++)
                _DayDot(
                  label: labels[i],
                  active: activeDays.contains(
                      _dayKey(startOfWeek.add(Duration(days: i)))),
                  isToday: startOfWeek.add(Duration(days: i)) == today,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot(
      {required this.label, required this.active, required this.isToday});
  final String label;
  final bool active;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: active
                  ? AppColors.primary
                  : (isToday ? AppColors.primary : AppColors.border),
              width: isToday && !active ? 2 : 1,
            ),
          ),
          child: active
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
              : null,
        ),
        const SizedBox(height: 6),
        Text(label,
            style: t.bodyMedium?.copyWith(
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w400)),
      ],
    );
  }
}

/// Per-track progress bars (the "Category Breakdown").
class CategoryBreakdown extends ConsumerWidget {
  const CategoryBreakdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    final tracks = ref.watch(tracksProvider).asData?.value ?? const [];
    final cleared = ref.watch(clearedRungIdsProvider).asData?.value ?? const {};
    if (tracks.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category Breakdown', style: t.titleMedium),
          const SizedBox(height: Insets.md),
          for (final track in tracks)
            Consumer(builder: (context, ref, _) {
              final ladder =
                  ref.watch(ladderProvider(track.id)).asData?.value ?? const [];
              final total = ladder.length;
              final done = ladder.where((r) => cleared.contains(r.id)).length;
              final accent = TrackVisuals.color(track);
              return Padding(
                padding: const EdgeInsets.only(bottom: Insets.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, color: accent),
                        ),
                        const SizedBox(width: Insets.sm),
                        Expanded(child: Text(track.title, style: t.titleMedium)),
                        Text('$done',
                            style: t.titleMedium?.copyWith(color: accent)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: total == 0 ? 0 : done / total,
                        minHeight: 6,
                        backgroundColor: accent.withValues(alpha: 0.14),
                        valueColor: AlwaysStoppedAnimation(accent),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
