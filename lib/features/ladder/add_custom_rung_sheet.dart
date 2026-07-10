import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../domain/entities/subscription.dart';

/// Lets a user add their own rung to a track (§1.6 Should-have, §2.5).
Future<void> showAddCustomRungSheet(
    BuildContext context, WidgetRef ref, String trackId) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _AddCustomRungForm(trackId: trackId),
    ),
  );
}

class _AddCustomRungForm extends ConsumerStatefulWidget {
  const _AddCustomRungForm({required this.trackId});
  final String trackId;

  @override
  ConsumerState<_AddCustomRungForm> createState() => _AddCustomRungFormState();
}

class _AddCustomRungFormState extends ConsumerState<_AddCustomRungForm> {
  final _title = TextEditingController();
  final _what = TextEditingController();
  double _difficulty = 3;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _what.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_title.text.trim().isEmpty) return;
    final l = AppLocalizations.of(context);
    final repo = ref.read(trackRepositoryProvider);
    final tier = ref.read(settingsRepositoryProvider).subscriptionTier;

    // Free: 5 custom rungs all-time. Paid: an allowance per calendar month
    // (monthly 30/mo, yearly 40/mo).
    final int count;
    if (ContentRules.customRungCapIsMonthly(tier)) {
      final now = DateTime.now();
      final monthStartMs =
          DateTime(now.year, now.month).millisecondsSinceEpoch;
      count = await repo.customRungCountSince(monthStartMs);
    } else {
      count = await repo.customRungCount();
    }
    if (!ContentRules.canAddCustomRung(tier, count)) {
      final cap = ContentRules.maxCustomRungs(tier);
      final msg =
          tier.isPremium ? l.customLimitPremium(cap) : l.customLimitFree;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(msg),
        ));
      }
      return;
    }

    setState(() => _saving = true);
    await repo.addCustomRung(
      trackId: widget.trackId,
      title: _title.text.trim(),
      whatToDo:
          _what.text.trim().isEmpty ? l.customDefaultWhat : _what.text.trim(),
      whyItHelps: l.customDefaultWhy,
      difficulty: _difficulty.round(),
    );
    ref.read(syncServiceProvider).scheduleBackup(); // back up the new rung
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Insets.lg, 0, Insets.lg, Insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.ladderAddOwn, style: t.titleLarge),
          const SizedBox(height: Insets.xs),
          Text(l.customSubtitle, style: t.bodyMedium),
          const SizedBox(height: Insets.lg),
          TextField(
            controller: _title,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l.customWhatLabel,
              hintText: l.customWhatHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: Insets.md),
          TextField(
            controller: _what,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l.customNoteLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: Insets.lg),
          Text(l.customDifficulty(_difficulty.round()), style: t.titleMedium),
          Slider(
            value: _difficulty,
            min: 1,
            max: 10,
            divisions: 9,
            label: '${_difficulty.round()}',
            onChanged: (v) => setState(() => _difficulty = v),
          ),
          const SizedBox(height: Insets.sm),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Text(l.customAddToLadder),
          ),
        ],
      ),
    );
  }
}
