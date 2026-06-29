import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/suds_slider.dart';
import '../../shared/track_visuals.dart';

/// PREDICT — "How bad do you think this'll be?" The slider is the hero (§3.2).
class PredictScreen extends ConsumerStatefulWidget {
  const PredictScreen({super.key, required this.rungId});
  final String rungId;

  @override
  ConsumerState<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends ConsumerState<PredictScreen> {
  int _suds = 5;
  final _note = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _saving = true);
    await ref.read(attemptRepositoryProvider).startChallenge(
          rungId: widget.rungId,
          predictedSuds: _suds,
          predictedNote: _note.text.trim().isEmpty ? null : _note.text.trim(),
        );
    ref.read(analyticsProvider).capture(Ev.predictStarted, {'predicted': _suds});
    if (!mounted) return;
    context.go(Routes.dashboard);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Saved. Go do it — then come back to log how it went."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rung = ref.watch(rungByIdProvider(widget.rungId)).asData?.value;
    final track =
        rung == null ? null : ref.watch(trackByIdProvider(rung.trackId)).asData?.value;
    final accent = track == null ? AppColors.primary : TrackVisuals.color(track);
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Before you go')),
      body: rung == null
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
                        Text("How bad do you think this'll be?",
                            textAlign: TextAlign.center, style: t.titleMedium),
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
                            labelText: 'What do you predict happens? (optional)',
                            hintText: "e.g. They'll think I'm awkward",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: Insets.sm),
                        Text(
                          "We'll compare this to how it actually goes. That gap "
                          'is the whole point.',
                          style: t.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Insets.lg),
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: accent),
                      onPressed: _saving ? null : _submit,
                      child: _saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text("I'll do it"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
