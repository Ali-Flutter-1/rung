import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/suds_slider.dart';
import '../../shared/track_visuals.dart';
import '../breathing/breathing_screen.dart';

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
    final l = AppLocalizations.of(context);
    setState(() => _saving = true);
    try {
      await ref.read(attemptRepositoryProvider).startChallenge(
            rungId: widget.rungId,
            predictedSuds: _suds,
            predictedNote: _note.text.trim().isEmpty ? null : _note.text.trim(),
          );
    } catch (_) {
      // Local write failed (e.g. device storage full). Don't navigate away as
      // if it saved — tell the user and let them retry.
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.errorSaveFailed),
      ));
      return;
    }
    ref.read(analyticsProvider).capture(Ev.predictStarted, {'predicted': _suds});
    if (!mounted) return;
    context.go(Routes.dashboard);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.predictSaved),
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
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.predictAppBar)),
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
                        Text(l.predictQuestion,
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
                          decoration: InputDecoration(
                            labelText: l.predictNoteLabel,
                            hintText: l.predictNoteHint,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: Insets.sm),
                        Text(
                          l.predictCompare,
                          style: t.bodyMedium,
                        ),
                        const SizedBox(height: Insets.lg),
                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              ref
                                  .read(analyticsProvider)
                                  .capture(Ev.breathingStarted);
                              openBreathing(context);
                            },
                            icon: const Icon(Icons.air_rounded),
                            label: Text(l.breatheCta),
                          ),
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
                          : Text(l.predictDoIt),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
