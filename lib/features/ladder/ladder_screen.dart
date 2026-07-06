import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/rung.dart';
import '../../shared/difficulty_badge.dart';
import '../../shared/help_now.dart';
import '../../shared/track_visuals.dart';
import 'add_custom_rung_sheet.dart';

class LadderScreen extends ConsumerWidget {
  const LadderScreen({super.key, required this.trackId});
  final String trackId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final track = ref.watch(trackByIdProvider(trackId)).asData?.value;
    final ladder = ref.watch(ladderProvider(trackId));
    final cleared = ref.watch(clearedRungIdsProvider).asData?.value ?? const {};
    final accent = track == null ? AppColors.primary : TrackVisuals.color(track);

    return Scaffold(
      appBar: AppBar(title: Text(track?.title ?? 'Ladder')),
      floatingActionButton: const HelpNowButton(),
      body: ladder.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load ladder.\n$e')),
        data: (rungs) {
          // The current focus = first uncleared rung.
          final currentIndex =
              rungs.indexWhere((r) => !cleared.contains(r.id));
          final done = rungs.where((r) => cleared.contains(r.id)).length;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(
                Insets.lg, Insets.md, Insets.lg, 96),
            itemCount: rungs.length + 2,
            itemBuilder: (_, i) {
              if (i == 0) {
                return _LadderHeader(
                  track: track,
                  accent: accent,
                  done: done,
                  total: rungs.length,
                );
              }
              if (i == rungs.length + 1) {
                return Padding(
                  padding: const EdgeInsets.only(top: Insets.sm),
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        showAddCustomRungSheet(context, ref, trackId),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add your own rung'),
                  ),
                );
              }
              final rung = rungs[i - 1];
              final isCleared = cleared.contains(rung.id);
              final isCurrent = (i - 1) == currentIndex;
              return _RungRow(
                rung: rung,
                accent: accent,
                isCleared: isCleared,
                isCurrent: isCurrent,
                isLast: i - 1 == rungs.length - 1,
                onTap: () => context.push(Routes.rung(rung.id)),
              ).animate().fadeIn(duration: 200.ms);
            },
          );
        },
      ),
    );
  }
}

class _LadderHeader extends StatelessWidget {
  const _LadderHeader({
    required this.track,
    required this.accent,
    required this.done,
    required this.total,
  });
  final dynamic track;
  final Color accent;
  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final pct = total == 0 ? 0.0 : done / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (track != null)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: Radii.pill,
              ),
              child: Text(
                (track.description as String).toUpperCase(),
                style: t.bodyMedium?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 11),
              ),
            ),
          const SizedBox(height: Insets.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$done', style: t.headlineMedium?.copyWith(color: accent)),
              Text(' of $total climbed', style: t.headlineSmall),
            ],
          ),
          const SizedBox(height: Insets.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: TweenAnimationBuilder<double>(
              // Fill in gently on open — a small moment of "look how far".
              tween: Tween(begin: 0, end: pct),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 8,
                backgroundColor: accent.withValues(alpha: 0.14),
                valueColor: AlwaysStoppedAnimation(accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RungRow extends StatelessWidget {
  const _RungRow({
    required this.rung,
    required this.accent,
    required this.isCleared,
    required this.isCurrent,
    required this.isLast,
    required this.onTap,
  });

  final Rung rung;
  final Color accent;
  final bool isCleared;
  final bool isCurrent;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    // Rungs above the current focus read as "not yet" — dimmed, not hidden.
    final dim = !isCleared && !isCurrent;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ladder rail with node.
          Column(
            children: [
              _Node(accent: accent, cleared: isCleared, current: isCurrent),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: Insets.md),
              child: Opacity(
                opacity: dim ? 0.55 : 1,
                child: InkWell(
                  borderRadius: Radii.card,
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(Insets.md),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? accent.withValues(alpha: 0.06)
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: Radii.card,
                      border: Border.all(
                        color: isCurrent
                            ? accent.withValues(alpha: 0.4)
                            : AppColors.border,
                      ),
                      // The next step gets a soft glow so the eye lands on it.
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: accent.withValues(alpha: 0.18),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(rung.title,
                                  style: t.titleMedium?.copyWith(
                                    decoration: isCleared
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: isCleared
                                        ? AppColors.inkMuted
                                        : null,
                                  )),
                            ),
                            if (rung.isCustom)
                              const Icon(Icons.edit_outlined,
                                  size: 15, color: AppColors.inkFaint),
                          ],
                        ),
                        const SizedBox(height: Insets.sm),
                        Row(
                          children: [
                            DifficultyBadge(
                                difficulty: rung.difficulty, color: accent),
                            const Spacer(),
                            if (isCurrent)
                              Text('Your next step',
                                  style: t.bodyMedium?.copyWith(
                                      color: accent,
                                      fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Node extends StatelessWidget {
  const _Node(
      {required this.accent, required this.cleared, required this.current});
  final Color accent;
  final bool cleared;
  final bool current;

  @override
  Widget build(BuildContext context) {
    if (cleared) {
      // Track accent (not global teal) so the whole ladder reads as one hue.
      return CircleAvatar(
        radius: 14,
        backgroundColor: accent,
        child: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
      );
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: current ? accent : Theme.of(context).colorScheme.surface,
        border: Border.all(
            color: current ? accent : AppColors.border, width: 2),
      ),
    );
  }
}
