import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subscription.dart';

/// A card look. The first is free; the rest are a Premium perk (the basic share
/// stays free so it keeps driving word-of-mouth).
class _CardStyle {
  const _CardStyle(this.name, this.colors, {this.free = false});
  final String name;
  final List<Color> colors;
  final bool free;
}

const _cardStyles = <_CardStyle>[
  _CardStyle('Teal', [AppColors.primary, AppColors.primaryDeep], free: true),
  _CardStyle('Sunset', [Color(0xFFF2A65A), Color(0xFFB4533F)]),
  _CardStyle('Night', [Color(0xFF33507E), Color(0xFF1B2233)]),
  _CardStyle('Forest', [Color(0xFF4C9A6B), Color(0xFF1F5F43)]),
  _CardStyle('Rose', [Color(0xFFE0899C), Color(0xFF8E3D5C)]),
];

/// Opens a preview + Share sheet for a branded "progress card" (streak,
/// challenges faced, best streak). No personal data — just the user's numbers +
/// calm branding, so it's safe to post anywhere. Pure client-side; renders the
/// card to a PNG and hands it to the OS share sheet.
Future<void> showShareProgressSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (_) => const _ShareSheet(),
  );
}

class _ShareSheet extends ConsumerStatefulWidget {
  const _ShareSheet();
  @override
  ConsumerState<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<_ShareSheet> {
  final _cardKey = GlobalKey();
  bool _busy = false;
  int _style = 0; // index into _cardStyles

  void _pickStyle(int i, bool isPremium) {
    final style = _cardStyles[i];
    if (!style.free && !isPremium) {
      // Capture messenger + router BEFORE popping — the sheet's context is dead
      // by the time the SnackBar action fires.
      final messenger = ScaffoldMessenger.of(context);
      final router = GoRouter.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('✨ More card styles are a Premium perk.'),
        action: SnackBarAction(
          label: 'See Premium',
          onPressed: () => router.go(Routes.subscription),
        ),
      ));
      return;
    }
    setState(() => _style = i);
  }

  Future<void> _share() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final boundary = _cardKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) return;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/rung_progress.png');
      await file.writeAsBytes(data.buffer.asUint8List());
      ref.read(analyticsProvider).capture('progress_shared');
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path, mimeType: 'image/png')],
        text: 'Small brave steps, one rung at a time. 🌱 #Rung',
      ));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Could not open share. Try again.'),
      ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsChangesProvider);
    final t = Theme.of(context).textTheme;
    final isPremium = ref.watch(settingsRepositoryProvider).subscriptionTier.isPremium;
    final streak = ref.watch(streakProvider).asData?.value ?? 0;
    final cleared = ref.watch(totalClearedProvider).asData?.value ?? 0;
    final best = ref.watch(bestStreakProvider).asData?.value ?? 0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Share your progress', style: t.titleLarge),
            const SizedBox(height: Insets.xs),
            Text('Just your numbers — nothing private.',
                style: t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
            const SizedBox(height: Insets.lg),
            RepaintBoundary(
              key: _cardKey,
              child: _ShareCard(
                streak: streak,
                cleared: cleared,
                best: best,
                gradient: _cardStyles[_style].colors,
              ),
            ),
            const SizedBox(height: Insets.md),
            // Style picker — first is free, the rest unlock with Premium.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _cardStyles.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _StyleSwatch(
                      style: _cardStyles[i],
                      selected: i == _style,
                      locked: !_cardStyles[i].free && !isPremium,
                      onTap: () => _pickStyle(i, isPremium),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Insets.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _busy ? null : _share,
                icon: _busy
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.ios_share_rounded, size: 18),
                label: const Text('Share'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareCard extends StatelessWidget {
  const _ShareCard({
    required this.streak,
    required this.cleared,
    required this.best,
    required this.gradient,
  });
  final int streak;
  final int cleared;
  final int best;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    // Fixed size → a predictable, crisp share image regardless of screen.
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stairs_rounded, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text('Rung',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 18,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 20),
          Text('My brave steps',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85), fontSize: 15)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$cleared',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      height: 1)),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('fears faced',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Stat(label: 'Current streak', value: '🔥 $streak'),
              const SizedBox(width: 12),
              _Stat(label: 'Best streak', value: '⭐ $best'),
            ],
          ),
          const SizedBox(height: 22),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 14),
          Text('Facing social fears, one small rung at a time.',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                  height: 1.35)),
        ],
      ),
    );
  }
}

class _StyleSwatch extends StatelessWidget {
  const _StyleSwatch({
    required this.style,
    required this.selected,
    required this.locked,
    required this.onTap,
  });
  final _CardStyle style;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: style.colors,
          ),
          border: Border.all(
            color: selected ? AppColors.primaryDeep : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: locked
            ? const Icon(Icons.lock_rounded, size: 15, color: Colors.white)
            : null,
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
