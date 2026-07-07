import 'package:flutter/material.dart';
import 'package:rung/core/haptics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/help_now.dart';

/// A once-a-day arrival prompt on Home — "how are you arriving today?" plus one
/// gentle next step. Builds the daily habit without pressure; disappears for the
/// rest of the day after a tap (or a dismiss). Local-only, no backend.
class DailyCheckIn extends ConsumerStatefulWidget {
  const DailyCheckIn({super.key});

  @override
  ConsumerState<DailyCheckIn> createState() => _DailyCheckInState();
}

class _Mood {
  const _Mood(this.emoji, this.label, {this.gentle = false});
  final String emoji;
  final String label;
  final bool gentle; // true → offer a calm moment rather than a step
}

const _moods = [
  _Mood('🌿', 'Calm'),
  _Mood('🙂', 'Okay'),
  _Mood('😬', 'Anxious', gentle: true),
  _Mood('🌧️', 'Low', gentle: true),
  _Mood('😰', 'Tense', gentle: true),
];

class _DailyCheckInState extends ConsumerState<DailyCheckIn> {
  _Mood? _picked;
  bool _dismissed = false;

  String get _todayYmd {
    final n = DateTime.now();
    final m = n.month.toString().padLeft(2, '0');
    final d = n.day.toString().padLeft(2, '0');
    return '${n.year}-$m-$d';
  }

  Future<void> _pick(_Mood mood) async {
    Haptics.selection();
    final settings = ref.read(settingsRepositoryProvider);
    await settings.setLastCheckInDate(_todayYmd);
    ref
        .read(analyticsProvider)
        .capture(Ev.checkInCompleted, {'mood': mood.label});
    if (mounted) setState(() => _picked = mood);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsChangesProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    final t = Theme.of(context).textTheme;

    if (_dismissed) return const SizedBox.shrink();
    // Already checked in earlier today and hasn't just picked → stay hidden.
    final alreadyToday = settings.lastCheckInDate == _todayYmd;
    if (alreadyToday && _picked == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: Insets.lg),
      padding: const EdgeInsets.all(Insets.lg),
      decoration: BoxDecoration(
        borderRadius: Radii.lgAll,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.accent.withValues(alpha: 0.10),
          ],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: _picked == null ? _prompt(t) : _acknowledgement(t, _picked!),
    );
  }

  Widget _prompt(TextTheme t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.wb_twilight_rounded,
                size: 20, color: AppColors.primaryDeep),
            const SizedBox(width: Insets.sm),
            Text('How are you arriving today?', style: t.titleMedium),
          ],
        ),
        const SizedBox(height: Insets.md),
        Wrap(
          spacing: Insets.sm,
          runSpacing: Insets.sm,
          children: [
            for (final m in _moods)
              _MoodChip(mood: m, onTap: () => _pick(m)),
          ],
        ),
      ],
    );
  }

  Widget _acknowledgement(TextTheme t, _Mood mood) {
    final gentle = mood.gentle;
    final message = gentle
        ? "Thanks for being honest. Let's keep today gentle — one small, kind thing is enough."
        : "Love that. When you're ready, one small step keeps the momentum going.";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(mood.emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: Insets.sm),
            Expanded(
                child: Text('Checked in — feeling ${mood.label.toLowerCase()}',
                    style: t.titleMedium)),
            IconButton(
              tooltip: 'Dismiss',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: () => setState(() => _dismissed = true),
            ),
          ],
        ),
        const SizedBox(height: Insets.xs),
        Text(message, style: t.bodyMedium),
        const SizedBox(height: Insets.md),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.tonalIcon(
            onPressed: () {
              if (gentle) {
                showHelpNowSheet(context);
              } else {
                context.go(Routes.tracks);
              }
            },
            icon: Icon(gentle ? Icons.spa_outlined : Icons.stairs_rounded,
                size: 18),
            label: Text(gentle ? 'Try a calm moment' : "See today's step"),
          ),
        ),
      ],
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({required this.mood, required this.onTap});
  final _Mood mood;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: Radii.pill,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Insets.md, vertical: Insets.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Radii.pill,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(mood.emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(mood.label,
                style: t.labelLarge?.copyWith(color: AppColors.primaryDeep)),
          ],
        ),
      ),
    );
  }
}
