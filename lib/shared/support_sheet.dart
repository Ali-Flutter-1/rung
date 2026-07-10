import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../features/profile/safety_screen.dart';
import '../l10n/app_localizations.dart';

/// A calm, non-alarming support prompt shown when distress signals appear
/// (spec §1.9 — surface help, never diagnose, never punish).
Future<void> showSupportSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetCtx) {
      final t = Theme.of(sheetCtx).textTheme;
      final l = AppLocalizations.of(sheetCtx);
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.favorite_outline_rounded,
                  color: AppColors.primary, size: 32),
              const SizedBox(height: Insets.md),
              Text(l.supportTitle, style: t.headlineSmall),
              const SizedBox(height: Insets.sm),
              Text(
                l.supportBody,
                style: t.bodyLarge,
              ),
              const SizedBox(height: Insets.lg),
              FilledButton(
                onPressed: () {
                  Navigator.of(sheetCtx).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SafetyScreen()));
                },
                child: Text(l.supportResources),
              ),
              const SizedBox(height: Insets.xs),
              TextButton(
                onPressed: () => Navigator.of(sheetCtx).pop(),
                child: Text(l.commonClose),
              ),
            ],
          ),
        ),
      );
    },
  );
}
