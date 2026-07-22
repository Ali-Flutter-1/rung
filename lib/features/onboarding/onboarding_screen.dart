import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/track.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/rung_copy.dart';
import '../../shared/rung_logo.dart';
import '../../shared/track_visuals.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  String? _trackSlug;
  ToneMode _tone = ToneMode.introvert;

  static const _lastPage = 4;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() => _controller.nextPage(
      duration: Motion.base, curve: Motion.ease);

  Future<void> _finish(List<Track> tracks) async {
    final slug = _trackSlug ?? (tracks.isNotEmpty ? tracks.first.slug : null);
    final settings = ref.read(settingsRepositoryProvider);
    await settings.setAcceptedDisclaimer(true);
    await settings.setToneMode(_tone);
    await settings.setStartingTrackSlug(slug);
    await settings.setCompletedOnboarding(true);
    ref.read(analyticsProvider).capture(Ev.onboardingComplete,
        {'tone': _tone.name, 'picked_track': slug != null});
    // Router redirect takes us to /dashboard once onboarding completes.
  }

  @override
  Widget build(BuildContext context) {
    final tracks = ref.watch(tracksProvider).asData?.value ?? const <Track>[];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.md),
              child: Row(
                children: [
                  _Progress(page: _page, total: _lastPage + 1),
                  const Spacer(),
                  if (_page >= 2)
                    TextButton(
                      onPressed: () => _finish(tracks),
                      child: Text(AppLocalizations.of(context).onbSkip),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (p) => setState(() => _page = p),
                children: [
                  _WelcomePage(onNext: _next),
                  _SafetyPage(onAgree: _next),
                  _FearPage(
                    tracks: tracks,
                    selected: _trackSlug,
                    onSelect: (s) {
                      setState(() => _trackSlug = s);
                      _next();
                    },
                    onSkip: () {
                      setState(() => _trackSlug = null);
                      _next();
                    },
                  ),
                  _TonePage(
                    selected: _tone,
                    onSelect: (m) {
                      setState(() => _tone = m);
                      _next();
                    },
                  ),
                  _StartingPointPage(
                    tracks: tracks,
                    trackSlug: _trackSlug,
                    onStart: () => _finish(tracks),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.page, required this.total});
  final int page;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++)
          Container(
            margin: const EdgeInsets.only(right: 6),
            width: i == page ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i <= page ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
      ],
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.title,
    required this.body,
    this.cta,
    this.onCta,
  });
  final String title;
  final Widget body;
  final String? cta;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Insets.lg),
          Text(title, style: t.displaySmall),
          const SizedBox(height: Insets.lg),
          Expanded(child: body),
          if (cta != null)
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: onCta, child: Text(cta!)),
            ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        children: [
          const Spacer(),
          const RungLogo(size: 96),
          const SizedBox(height: Insets.xl),
          Text(
            l.onbWelcomeTitle,
            textAlign: TextAlign.center,
            style: t.displaySmall,
          ),
          const SizedBox(height: Insets.md),
          Text(
            l.onbWelcomeBody,
            textAlign: TextAlign.center,
            style: t.bodyLarge?.copyWith(color: t.bodyMedium?.color),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onNext,
              child: Text(l.onbGetStarted),
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyPage extends StatelessWidget {
  const _SafetyPage({required this.onAgree});
  final VoidCallback onAgree;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _Scaffold(
      title: l.onbSafetyTitle,
      cta: l.onbUnderstand,
      onCta: onAgree,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.onbSafetyBody1,
            style: t.bodyLarge,
          ),
          const SizedBox(height: Insets.lg),
          Text(
            l.onbSafetyBody2,
            style: t.bodyLarge,
          ),
          const SizedBox(height: Insets.lg),
          Container(
            padding: const EdgeInsets.all(Insets.md),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: Radii.card,
            ),
            child: Text(
              l.onbSafetyCrisis,
              style: t.bodyLarge?.copyWith(color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}

class _FearPage extends StatelessWidget {
  const _FearPage({
    required this.tracks,
    required this.selected,
    required this.onSelect,
    required this.onSkip,
  });
  final List<Track> tracks;
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _Scaffold(
      title: l.onbFearTitle,
      body: tracks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Text(
                  l.onbFearBody,
                  style: t.bodyMedium,
                ),
                const SizedBox(height: Insets.md),
                for (final track in tracks) ...[
                  _FearTile(
                    track: track,
                    onTap: () => onSelect(track.slug),
                  ),
                  const SizedBox(height: Insets.sm),
                ],
                const SizedBox(height: Insets.sm),
                // The non-restricting escape hatch (§3.1 — every step skippable).
                InkWell(
                  borderRadius: Radii.card,
                  onTap: onSkip,
                  child: Container(
                    padding: const EdgeInsets.all(Insets.md),
                    decoration: BoxDecoration(
                      borderRadius: Radii.card,
                      color: AppColors.primarySoft,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.explore_outlined,
                            color: AppColors.primaryDeep),
                        const SizedBox(width: Insets.md),
                        Expanded(
                          child: Text(l.onbExploreOwn,
                              style: t.titleMedium
                                  ?.copyWith(color: AppColors.primaryDeep)),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primaryDeep),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _FearTile extends StatelessWidget {
  const _FearTile({required this.track, required this.onTap});
  final Track track;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = TrackVisuals.color(track);
    return InkWell(
      borderRadius: Radii.card,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Insets.md),
        decoration: BoxDecoration(
          borderRadius: Radii.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(TrackVisuals.iconFor(track), color: accent),
            const SizedBox(width: Insets.md),
            Expanded(child: Text(track.description)),
            const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}

class _TonePage extends StatelessWidget {
  const _TonePage({required this.selected, required this.onSelect});
  final ToneMode selected;
  final ValueChanged<ToneMode> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _Scaffold(
      title: l.onbToneTitle,
      body: Column(
        children: [
          _ToneOption(
            title: l.onbToneIntrovertTitle,
            body: l.onbToneIntrovertBody,
            icon: Icons.spa_outlined,
            onTap: () => onSelect(ToneMode.introvert),
          ),
          const SizedBox(height: Insets.md),
          _ToneOption(
            title: l.onbToneSituationalTitle,
            body: l.onbToneSituationalBody,
            icon: Icons.bolt_outlined,
            onTap: () => onSelect(ToneMode.situational),
          ),
          const Spacer(),
          Text(l.onbToneFootnote,
              style: t.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ToneOption extends StatelessWidget {
  const _ToneOption({
    required this.title,
    required this.body,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String body;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: Radii.card,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Insets.md),
        decoration: BoxDecoration(
          borderRadius: Radii.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: Insets.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: t.titleMedium),
                  const SizedBox(height: 4),
                  Text(body, style: t.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartingPointPage extends ConsumerWidget {
  const _StartingPointPage({
    required this.tracks,
    required this.trackSlug,
    required this.onStart,
  });
  final List<Track> tracks;
  final String? trackSlug;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    Track? track;
    for (final tr in tracks) {
      if (tr.slug == trackSlug) track = tr;
    }
    track ??= tracks.isNotEmpty ? tracks.first : null;
    final ladder =
        track == null ? null : ref.watch(ladderProvider(track.id)).asData?.value;
    final firstRung = (ladder != null && ladder.isNotEmpty) ? ladder.first : null;
    final accent = track == null ? AppColors.primary : TrackVisuals.color(track);
    final l = AppLocalizations.of(context);

    return _Scaffold(
      title: l.onbHowTitle,
      cta: l.onbStartClimbing,
      onCta: onStart,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Step(n: '1', text: l.onbStep1),
          _Step(n: '2', text: l.onbStep2),
          _Step(n: '3', text: l.onbStep3),
          const SizedBox(height: Insets.lg),
          if (track != null && firstRung != null)
            Container(
              padding: const EdgeInsets.all(Insets.md),
              decoration: BoxDecoration(
                borderRadius: Radii.card,
                color: accent.withValues(alpha: 0.08),
                border: Border.all(color: accent.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      trackSlug == null
                          ? l.onbGentleFirstStep
                          : l.onbGoodPlaceToStart,
                      style: t.bodyMedium?.copyWith(
                          color: accent,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: Insets.sm),
                  Text(firstRung.title, style: t.titleLarge),
                  const SizedBox(height: 4),
                  Text(firstRung.whyItHelpsText(l), style: t.bodyMedium),
                ],
              ),
            ),
          const SizedBox(height: Insets.md),
          Text(l.onbAllAreas, style: t.bodyMedium),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.n, required this.text});
  final String n;
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primarySoft,
            child: Text(n,
                style: const TextStyle(
                    color: AppColors.primaryDeep, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: Insets.md),
          Expanded(child: Text(text, style: t.bodyLarge)),
        ],
      ),
    );
  }
}
