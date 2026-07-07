import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// A reusable "How to play" action for game app bars + the rules sheet it opens.
/// Each game passes its own short, numbered rules.
Widget gameHelpAction(BuildContext context, String game, List<String> rules) {
  return IconButton(
    tooltip: 'How to play',
    icon: const Icon(Icons.help_outline_rounded),
    onPressed: () => showGameRules(context, game, rules),
  );
}

Future<void> showGameRules(
    BuildContext context, String game, List<String> rules) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useRootNavigator: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (sheetCtx) {
      final t = Theme.of(sheetCtx).textTheme;
      return SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.videogame_asset_rounded,
                      color: AppColors.primary),
                  const SizedBox(width: Insets.sm),
                  Expanded(
                    child: Text('How to play · $game', style: t.titleLarge),
                  ),
                ],
              ),
              const SizedBox(height: Insets.lg),
              for (var i = 0; i < rules.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                      bottom: i == rules.length - 1 ? 0 : Insets.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.14),
                        ),
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                color: AppColors.primaryDeep,
                                fontWeight: FontWeight.w800,
                                fontSize: 12)),
                      ),
                      const SizedBox(width: Insets.md),
                      Expanded(child: Text(rules[i], style: t.bodyLarge)),
                    ],
                  ),
                ),
              const SizedBox(height: Insets.xl),
              GestureDetector(
                onTap: () => Navigator.of(sheetCtx).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: Radii.pill,
                  ),
                  child: const Text('Got it',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
