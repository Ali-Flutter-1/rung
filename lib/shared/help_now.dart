import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';

/// The discreet "Help now" button — instant, in-the-moment grounding tools
/// (Project Brief §5). Amber, for quiet reassurance, not alarm.
class HelpNowButton extends StatelessWidget {
  const HelpNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // No hero tag: the same button lives on several always-alive tabs at once
      // (IndexedStack shell), so a shared tag would collide.
      heroTag: null,
      backgroundColor: AppColors.accentDeep,
      foregroundColor: Colors.white,
      onPressed: () => showHelpNowSheet(context),
      icon: const Icon(Icons.spa_outlined),
      label: Text(AppLocalizations.of(context).helpNow),
    );
  }
}

Future<void> showHelpNowSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    // Theme-aware so the sheet (and its theme-coloured text) reads in dark mode.
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (_) => const _HelpNowSheet(),
  );
}

class _HelpNowSheet extends StatelessWidget {
  const _HelpNowSheet();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, 0),
              child: Row(
                children: [
                  const Icon(Icons.spa_outlined, color: AppColors.accentDeep),
                  const SizedBox(width: Insets.sm),
                  Text(l.helpCalmMoment, style: t.titleLarge),
                ],
              ),
            ),
            TabBar(
              labelColor: AppColors.primaryDeep,
              indicatorColor: AppColors.primary,
              unselectedLabelColor: AppColors.inkMuted,
              tabs: [
                Tab(text: l.helpTabBreathe),
                Tab(text: l.helpTabGround),
                Tab(text: l.helpTabSay),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _BreathePane(),
                  _GroundPane(),
                  _LinesPane(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A slow expanding/contracting circle to pace breathing (in 4s, out 6s).
class _BreathePane extends StatefulWidget {
  const _BreathePane();
  @override
  State<_BreathePane> createState() => _BreathePaneState();
}

class _BreathePaneState extends State<_BreathePane>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final scale = 0.6 + _c.value * 0.4;
          final breathingIn = _c.status == AnimationStatus.forward;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180 * scale,
                height: 180 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.18),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 120 * scale,
                  height: 120 * scale,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: Insets.xl),
              Text(
                  breathingIn
                      ? AppLocalizations.of(context).helpBreatheIn
                      : AppLocalizations.of(context).helpBreatheOut,
                  style: t.titleLarge),
              const SizedBox(height: Insets.sm),
              Text(AppLocalizations.of(context).helpBreatheHint,
                  style: t.bodyMedium),
            ],
          );
        },
      ),
    );
  }
}

class _GroundPane extends StatelessWidget {
  const _GroundPane();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final steps = [
      ('5', l.helpGround5),
      ('4', l.helpGround4),
      ('3', l.helpGround3),
      ('2', l.helpGround2),
      ('1', l.helpGround1),
    ];
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        Text(l.helpGroundTitle, style: t.titleMedium),
        const SizedBox(height: Insets.md),
        for (final (n, label) in steps)
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.md),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primarySoft,
                  child: Text(n,
                      style: const TextStyle(
                          color: AppColors.primaryDeep,
                          fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: Insets.md),
                Text(label, style: t.bodyLarge),
              ],
            ),
          ),
        const SizedBox(height: Insets.sm),
        Text(l.helpGroundHint, style: t.bodyMedium),
      ],
    );
  }
}

class _LinesPane extends StatelessWidget {
  const _LinesPane();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final openers = [l.helpOpener1, l.helpOpener2, l.helpOpener3, l.helpOpener4];
    final exits = [l.helpExit1, l.helpExit2, l.helpExit3];
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        Text(l.helpOpenersTitle, style: t.titleMedium),
        const SizedBox(height: Insets.sm),
        for (final line in openers) _LineChip(line: line),
        const SizedBox(height: Insets.lg),
        Text(l.helpExitsTitle, style: t.titleMedium),
        const SizedBox(height: Insets.sm),
        for (final line in exits) _LineChip(line: line),
      ],
    );
  }
}

class _LineChip extends StatelessWidget {
  const _LineChip({required this.line});
  final String line;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Radii.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline_rounded,
              size: 18, color: AppColors.primary),
          const SizedBox(width: Insets.md),
          Expanded(
              child: Text(line, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
