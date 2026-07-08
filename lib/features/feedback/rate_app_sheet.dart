import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/haptics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Opens the "Rate Rung" sheet: pick 1–5 stars and (optionally) leave a comment.
///
/// A happy rating (4–5★) is thanked and routed to the native store review
/// prompt, so praise lands publicly. A lower rating is captured *privately* as
/// feedback (never pushed to the store) so a struggling user tells us, not the
/// world. Either way the comment — if any — is saved to `app_feedback`.
Future<void> showRateAppSheet(BuildContext context, WidgetRef ref) {
  ref.read(analyticsProvider).capture(Ev.rateOpened);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    showDragHandle: true,
    builder: (_) => Padding(
      // Lift above the keyboard when the comment field is focused.
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: const _RateAppSheet(),
    ),
  );
}

class _RateAppSheet extends ConsumerStatefulWidget {
  const _RateAppSheet();

  @override
  ConsumerState<_RateAppSheet> createState() => _RateAppSheetState();
}

class _RateAppSheetState extends ConsumerState<_RateAppSheet> {
  int _rating = 0;
  final _comment = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  String get _prompt => switch (_rating) {
        0 => 'How is Rung feeling for you?',
        1 || 2 => "We're sorry it's not landing. What's missing?",
        3 => 'Thanks — what would make it a 5?',
        _ => 'That means a lot. What do you love?',
      };

  Future<void> _submit() async {
    if (_rating == 0 || _busy) return;
    setState(() => _busy = true);
    Haptics.medium();
    final rating = _rating;
    final comment = _comment.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);

    ref.read(analyticsProvider).capture(Ev.ratingSubmitted, {'rating': rating});

    // Save the comment/rating privately (best-effort; never blocks the user).
    if (ref.read(cloudEnabledProvider)) {
      try {
        await ref.read(cloudRepositoryProvider).submitFeedback(
              rating: rating,
              comment: comment.isEmpty ? null : comment,
              platform: defaultTargetPlatform.name,
            );
      } catch (_) {
        // Offline / not signed in / table not migrated — silently ignore.
      }
    }
    await ref.read(settingsRepositoryProvider).setHasRatedApp(true);

    // Happy raters get nudged to the public store review.
    if (rating >= 4) {
      try {
        final review = InAppReview.instance;
        if (await review.isAvailable()) await review.requestReview();
      } catch (_) {
        // Store review unavailable (e.g. pre-launch) — nothing to do.
      }
    }

    if (!mounted) return;
    nav.pop();
    messenger.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(rating >= 4
          ? 'Thank you — it truly helps. 🌱'
          : 'Thank you for the honesty — we’ll use it to improve.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            Insets.lg, Insets.xs, Insets.lg, Insets.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Enjoying Rung?',
                textAlign: TextAlign.center, style: t.headlineSmall),
            const SizedBox(height: Insets.xs),
            Text(_prompt,
                textAlign: TextAlign.center,
                style: t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
            const SizedBox(height: Insets.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 1; i <= 5; i++)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Haptics.selection();
                      setState(() => _rating = i);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        i <= _rating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        size: 44,
                        color: i <= _rating
                            ? AppColors.accent
                            : AppColors.inkFaint,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Insets.lg),
            TextField(
              controller: _comment,
              minLines: 2,
              maxLines: 4,
              maxLength: 500,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: _rating >= 4
                    ? 'Anything you love? (optional)'
                    : 'Tell us more (optional)',
                border: OutlineInputBorder(borderRadius: Radii.card),
              ),
            ),
            const SizedBox(height: Insets.xs),
            FilledButton(
              onPressed: (_rating == 0 || _busy) ? null : _submit,
              child: _busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
