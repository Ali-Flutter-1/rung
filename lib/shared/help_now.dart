import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

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
      label: const Text('Help now'),
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
                  Text('A calm moment', style: t.titleLarge),
                ],
              ),
            ),
            const TabBar(
              labelColor: AppColors.primaryDeep,
              indicatorColor: AppColors.primary,
              unselectedLabelColor: AppColors.inkMuted,
              tabs: [
                Tab(text: 'Breathe'),
                Tab(text: 'Ground'),
                Tab(text: 'Say this'),
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
              Text(breathingIn ? 'Breathe in…' : 'Breathe out…',
                  style: t.titleLarge),
              const SizedBox(height: Insets.sm),
              Text('Follow the circle. There is no rush.', style: t.bodyMedium),
            ],
          );
        },
      ),
    );
  }
}

class _GroundPane extends StatelessWidget {
  const _GroundPane();

  static const _steps = [
    ('5', 'things you can see'),
    ('4', 'things you can touch'),
    ('3', 'things you can hear'),
    ('2', 'things you can smell'),
    ('1', 'thing you can taste'),
  ];

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        Text('Name, quietly to yourself…', style: t.titleMedium),
        const SizedBox(height: Insets.md),
        for (final (n, label) in _steps)
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
        Text('This brings you back to right now — where you are safe.',
            style: t.bodyMedium),
      ],
    );
  }
}

class _LinesPane extends StatelessWidget {
  const _LinesPane();

  static const _openers = [
    'How do you know the people here?',
    'I love this spot — have you been before?',
    "I'm hopeless with names — could you remind me?",
    'What have you been up to this week?',
  ];
  static const _exits = [
    "I'm going to grab a drink — it was good talking to you.",
    'I need to say a quick hello to someone, excuse me a sec.',
    "I'll let you mingle — catch you later.",
  ];

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        Text('Easy openers', style: t.titleMedium),
        const SizedBox(height: Insets.sm),
        for (final line in _openers) _LineChip(line: line),
        const SizedBox(height: Insets.lg),
        Text('Graceful exits', style: t.titleMedium),
        const SizedBox(height: Insets.sm),
        for (final line in _exits) _LineChip(line: line),
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
