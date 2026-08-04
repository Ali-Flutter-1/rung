import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/haptics.dart';
import '../../core/safety/content_guard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subscription.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/support_sheet.dart';

enum CoachMode { rehearse, debrief }

/// Opens the AI coach if the user is Premium; otherwise routes to the paywall.
/// The coach is the headline Premium feature — valuable on day one, no
/// community required.
void openCoach(
  BuildContext context,
  WidgetRef ref, {
  CoachMode mode = CoachMode.rehearse,
}) {
  final tier = ref.read(settingsRepositoryProvider).subscriptionTier;
  if (!tier.isPremium) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(AppLocalizations.of(context).coachPremiumOnly),
      ),
    );
    context.go(Routes.subscription);
    return;
  }
  Navigator.of(
    context,
    rootNavigator: true,
  ).push(MaterialPageRoute(builder: (_) => CoachScreen(initialMode: mode)));
}

class CoachScreen extends ConsumerStatefulWidget {
  const CoachScreen({super.key, this.initialMode = CoachMode.rehearse});
  final CoachMode initialMode;

  @override
  ConsumerState<CoachScreen> createState() => _CoachScreenState();
}

class _Msg {
  _Msg(this.fromUser, this.text);
  final bool fromUser;
  final String text;
}

class _CoachScreenState extends ConsumerState<CoachScreen> {
  late CoachMode _mode = widget.initialMode;
  final _messages = <_Msg>[];
  final _input = TextEditingController();
  final _scroll = ScrollController();
  bool _sending = false;

  bool _seeded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Seed the intro here (not initState) so AppLocalizations is available.
    if (!_seeded) {
      _seeded = true;
      _seedIntro(AppLocalizations.of(context));
    }
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _seedIntro(AppLocalizations l) {
    _messages.clear();
    _messages.add(
      _Msg(
        false,
        _mode == CoachMode.rehearse
            ? l.coachIntroRehearse
            : l.coachIntroDebrief,
      ),
    );
  }

  void _switchMode(CoachMode m, AppLocalizations l) {
    if (m == _mode) return;
    setState(() {
      _mode = m;
      _seedIntro(l);
    });
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;

    // Crisis first line — surface support, never "coach" through it.
    if (ContentGuard.isDistress(text)) {
      _input.clear();
      Haptics.medium();
      await showSupportSheet(context);
      return;
    }

    setState(() {
      _messages.add(_Msg(true, text));
      _sending = true;
      _input.clear();
    });
    _scrollToEnd();

    final history = _messages
        .map(
          (m) => {'role': m.fromUser ? 'user' : 'assistant', 'content': m.text},
        )
        .toList();
    final result = await ref
        .read(cloudRepositoryProvider)
        .coachReply(
          mode: _mode == CoachMode.rehearse ? 'rehearse' : 'debrief',
          history: history,
        );
    if (!mounted) return;

    if (result.isCrisis) {
      setState(() => _sending = false);
      await showSupportSheet(context);
      return;
    }
    if (result.ok) {
      setState(() {
        _messages.add(_Msg(false, result.text!));
        _sending = false;
      });
      _scrollToEnd();
      return;
    }
    // Error → gentle inline message.
    setState(() => _sending = false);
    _handleError(result.errorCode);
  }

  void _handleError(String? code) {
    final messenger = ScaffoldMessenger.of(context);
    final l = AppLocalizations.of(context);
    void snack(String text) => messenger.showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(text)),
    );
    switch (code) {
      case 'premium_required':
        snack(l.coachPremiumOnly);
        context.go(Routes.subscription);
      case 'daily_limit':
        snack(l.coachDailyLimit);
      case 'coach_busy':
        snack(l.coachBusy);
      case 'coach_unconfigured':
        snack(l.coachUnconfigured);
      default:
        snack(l.coachError);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: Motion.base,
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.coachTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Insets.lg,
              0,
              Insets.lg,
              Insets.sm,
            ),
            child: Row(
              children: [
                _ModePill(
                  label: l.coachRehearse,
                  icon: Icons.self_improvement_rounded,
                  selected: _mode == CoachMode.rehearse,
                  onTap: () => _switchMode(CoachMode.rehearse, l),
                ),
                const SizedBox(width: Insets.sm),
                _ModePill(
                  label: l.coachDebrief,
                  icon: Icons.favorite_outline_rounded,
                  selected: _mode == CoachMode.debrief,
                  onTap: () => _switchMode(CoachMode.debrief, l),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.all(Insets.lg),
                itemCount: _messages.length + (_sending ? 1 : 0),
                itemBuilder: (context, i) {
                  if (i >= _messages.length) return const _TypingBubble();
                  return _Bubble(msg: _messages[i]);
                },
              ),
            ),
            _Composer(controller: _input, sending: _sending, onSend: _send),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.msg});
  final _Msg msg;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final user = msg.fromUser;
    final cs = Theme.of(context).colorScheme;
    // Theme-aware, not fixed AppColors.ink — the bot bubble sits on `surface`,
    // which is near-black in dark mode, so a fixed near-black ink was invisible.
    final bg = user ? AppColors.primary : cs.surface;
    final fg = user ? Colors.white : cs.onSurface;
    return Padding(
          padding: const EdgeInsets.only(bottom: Insets.md),
          child: Row(
            mainAxisAlignment: user
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!user) ...[
                const _CoachAvatar(),
                const SizedBox(width: Insets.sm),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.md,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radii.md,
                      topRight: Radii.md,
                      bottomLeft: Radius.circular(user ? 16 : 4),
                      bottomRight: Radius.circular(user ? 4 : 16),
                    ),
                    border: user ? null : Border.all(color: cs.outline),
                  ),
                  child: Text(
                    msg.text,
                    style: t.bodyLarge?.copyWith(color: fg, height: 1.4),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 220.ms)
        .slideY(begin: 0.1, end: 0, duration: 220.ms, curve: Curves.easeOut);
  }
}

class _CoachAvatar extends StatelessWidget {
  const _CoachAvatar();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(Icons.spa_rounded, color: Colors.white, size: 16),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Row(
        children: [
          const _CoachAvatar(),
          const SizedBox(width: Insets.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.md,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radii.md,
                topRight: Radii.md,
                bottomLeft: Radius.circular(4),
                bottomRight: Radii.md,
              ),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: EdgeInsets.only(right: i < 2 ? 4 : 0),
                    child:
                        Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.inkFaint,
                              ),
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .fadeIn(duration: 400.ms, delay: (i * 160).ms)
                            .then()
                            .fadeOut(duration: 400.ms),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.sending,
    required this.onSend,
  });
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        Insets.md,
        Insets.sm,
        Insets.md,
        Insets.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: l.coachComposerHint,
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Insets.md,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: Radii.lgAll,
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: Insets.sm),
          GestureDetector(
            onTap: sending ? null : onSend,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sending ? AppColors.inkFaint : AppColors.primary,
              ),
              child: sending
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.arrow_upward_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModePill extends StatelessWidget {
  const _ModePill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.md, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.14)
              : Colors.transparent,
          borderRadius: Radii.pill,
          border: Border.all(
            color: selected
                ? AppColors.primary
                : Theme.of(context).colorScheme.outline,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected
                  ? AppColors.primaryDeep
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? AppColors.primaryDeep
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
