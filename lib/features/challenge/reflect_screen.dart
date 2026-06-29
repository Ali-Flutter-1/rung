import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/attempt.dart';
import '../../shared/suds_slider.dart';
import '../../shared/track_visuals.dart';
import '../profile/profile_sync.dart';

/// REFLECT — Done / Partial / Not today + actual SUDS. No judgment copy (§4.3).
class ReflectScreen extends ConsumerStatefulWidget {
  const ReflectScreen({super.key, required this.attemptId});
  final String attemptId;

  @override
  ConsumerState<ReflectScreen> createState() => _ReflectScreenState();
}

class _ReflectScreenState extends ConsumerState<ReflectScreen> {
  Outcome? _outcome;
  int _suds = 3;
  final _note = TextEditingController();
  bool _saving = false;
  Attempt? _attempt;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final a = await ref.read(attemptRepositoryProvider).getAttempt(widget.attemptId);
    if (mounted) setState(() => _attempt = a);
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _save(Color accent) async {
    if (_outcome == null) return;
    setState(() => _saving = true);
    await ref.read(attemptRepositoryProvider).completeChallenge(
          attemptId: widget.attemptId,
          actualSuds: _outcome == Outcome.skipped ? _suds : _suds,
          outcome: _outcome!,
          reflectionNote: _note.text.trim().isEmpty ? null : _note.text.trim(),
        );
    final analytics = ref.read(analyticsProvider);
    analytics.capture(Ev.reflectCompleted,
        {'actual': _suds, 'outcome': _outcome!.name});
    if (_outcome!.counts) {
      analytics.capture(Ev.rungCleared, {'actual': _suds});
      HapticFeedback.mediumImpact(); // celebrate clearing a rung
    }
    // Publish updated streak/challenges to your pod profile (numbers only),
    // and back up the new attempt + progress to the cloud RIGHT AWAY (not
    // debounced) so a quick account switch can't lose this rung.
    pushProfileToCloud(ref);
    ref.read(syncServiceProvider).backupNow();
    if (!mounted) return;
    context.pushReplacement(Routes.result(widget.attemptId));
  }

  @override
  Widget build(BuildContext context) {
    final attempt = _attempt;
    final rung = attempt == null
        ? null
        : ref.watch(rungByIdProvider(attempt.rungId)).asData?.value;
    final track =
        rung == null ? null : ref.watch(trackByIdProvider(rung.trackId)).asData?.value;
    final accent = track == null ? AppColors.primary : TrackVisuals.color(track);
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('How did it go?')),
      body: attempt == null || rung == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(Insets.lg),
                      children: [
                        Text(rung.title, style: t.headlineSmall),
                        const SizedBox(height: Insets.xl),
                        Text('Did you do it?',
                            textAlign: TextAlign.center, style: t.titleMedium),
                        const SizedBox(height: Insets.md),
                        _OutcomeButtons(
                          selected: _outcome,
                          accent: accent,
                          onSelect: (o) => setState(() => _outcome = o),
                        ),
                        const SizedBox(height: Insets.xl),
                        Text(
                          _outcome == Outcome.skipped
                              ? 'How anxious did the thought of it feel?'
                              : 'How bad was it, actually?',
                          textAlign: TextAlign.center,
                          style: t.titleMedium,
                        ),
                        const SizedBox(height: Insets.lg),
                        SudsSlider(
                          value: _suds,
                          accent: accent,
                          onChanged: (v) => setState(() => _suds = v),
                        ),
                        const SizedBox(height: Insets.xl),
                        TextField(
                          controller: _note,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Anything you want to remember? (optional)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Insets.lg),
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: accent),
                      onPressed:
                          _saving || _outcome == null ? null : () => _save(accent),
                      child: _saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _OutcomeButtons extends StatelessWidget {
  const _OutcomeButtons({
    required this.selected,
    required this.accent,
    required this.onSelect,
  });
  final Outcome? selected;
  final Color accent;
  final ValueChanged<Outcome> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _btn(context, Outcome.done, 'Done', Icons.check_circle_outline),
        const SizedBox(width: Insets.sm),
        _btn(context, Outcome.partial, 'Partial', Icons.adjust_rounded),
        const SizedBox(width: Insets.sm),
        _btn(context, Outcome.skipped, 'Not today', Icons.nightlight_outlined),
      ],
    );
  }

  Widget _btn(BuildContext context, Outcome o, String label, IconData icon) {
    final isSel = selected == o;
    return Expanded(
      child: InkWell(
        borderRadius: Radii.card,
        onTap: () => onSelect(o),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Insets.md),
          decoration: BoxDecoration(
            color: isSel ? accent.withValues(alpha: 0.10) : null,
            borderRadius: Radii.card,
            border: Border.all(
                color: isSel ? accent : AppColors.border,
                width: isSel ? 2 : 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSel ? accent : AppColors.inkMuted),
              const SizedBox(height: 6),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSel ? accent : AppColors.inkMuted)),
            ],
          ),
        ),
      ),
    );
  }
}
