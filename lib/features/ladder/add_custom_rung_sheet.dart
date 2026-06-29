import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
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
      final msg = tier.isPremium
          ? "You've reached this month's limit of $cap custom rungs — it "
              'resets next month.'
          : 'Free plan includes 5 custom rungs — upgrade for more each month.';
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
      whatToDo: _what.text.trim().isEmpty
          ? 'A challenge you set for yourself.'
          : _what.text.trim(),
      whyItHelps: 'You named this one — that makes it count.',
      difficulty: _difficulty.round(),
    );
    ref.read(syncServiceProvider).scheduleBackup(); // back up the new rung
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Insets.lg, 0, Insets.lg, Insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add your own rung', style: t.titleLarge),
          const SizedBox(height: Insets.xs),
          Text('Your situation is specific — this rung is just for you.',
              style: t.bodyMedium),
          const SizedBox(height: Insets.lg),
          TextField(
            controller: _title,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'What will you do?',
              hintText: 'e.g. Ask my manager for feedback',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: Insets.md),
          TextField(
            controller: _what,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'A note to yourself (optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: Insets.lg),
          Text('How hard does it feel? ${_difficulty.round()}/10',
              style: t.titleMedium),
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
                : const Text('Add to ladder'),
          ),
        ],
      ),
    );
  }
}
