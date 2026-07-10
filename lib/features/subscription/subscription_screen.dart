import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/purchases/purchase_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../domain/entities/subscription.dart';
import '../profile/profile_sync.dart';

/// Tab 4 — premium plans. Uses RevenueCat for real in-app purchases (live
/// localized prices, purchase, restore) when a key is configured; otherwise it
/// falls back to a simulated local tier so pod rules stay testable end-to-end.
/// The core therapeutic loop always stays free (§1.10).
class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _yearly = true;
  bool _busy = false;
  Offering? _offering; // live store packages (null until loaded / no keys)

  @override
  void initState() {
    super.initState();
    ref.read(analyticsProvider).capture(Ev.paywallViewed);
    _loadOffering();
  }

  Future<void> _loadOffering() async {
    if (!purchasesReady) return;
    final o = await ref.read(purchaseServiceProvider).currentOffering();
    if (mounted) setState(() => _offering = o);
  }

  Package? get _selectedPackage =>
      _yearly ? _offering?.annual : _offering?.monthly;

  /// Live localized price when the store gave us one; the marketing price
  /// otherwise (dev / offering not loaded yet).
  String _priceLabel(bool yearly) {
    final pkg = yearly ? _offering?.annual : _offering?.monthly;
    return pkg?.storeProduct.priceString ?? (yearly ? '\$39.99' : '\$4.99');
  }

  Future<void> _onSubscribe() async {
    ref.read(analyticsProvider).capture(
        Ev.subscribeTapped, {'plan': _yearly ? 'yearly' : 'monthly'});
    final settings = ref.read(settingsRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    final l = AppLocalizations.of(context);

    // Dev / no-keys fallback: simulate the tier so pod rules stay testable.
    if (!purchasesReady) {
      await settings.setSubscriptionTier(
          _yearly ? SubscriptionTier.yearly : SubscriptionTier.monthly);
      await pushIdentityToCloud(ref);
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.paywallSimulated),
      ));
      return;
    }

    final pkg = _selectedPackage;
    if (pkg == null) {
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.paywallPlanUnavailable),
      ));
      return;
    }
    setState(() => _busy = true);
    try {
      final tier = await ref.read(purchaseServiceProvider).buy(pkg);
      await settings.setSubscriptionTier(tier);
      await pushIdentityToCloud(ref);
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.paywallThankYou),
      ));
    } on PurchaseCancelled {
      // User backed out — nothing to say.
    } catch (_) {
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.paywallPurchaseFailed),
      ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _onRestore() async {
    final settings = ref.read(settingsRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    final l = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final tier = await ref.read(purchaseServiceProvider).restore();
      await settings.setSubscriptionTier(tier);
      await pushIdentityToCloud(ref);
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content:
            Text(tier.isPremium ? l.paywallRestored : l.paywallNoRestore),
      ));
    } catch (_) {
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.paywallRestoreFailed),
      ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // The headline reasons to subscribe — the emotional ones people actually pay
  // for. Every line is really enforced. Lead with belonging (pods), then the
  // "make it yours" levers (unlimited ladders, deeper steps).
  List<(IconData, String)> _headlineBenefits(AppLocalizations l) => [
        (Icons.spa_rounded, l.paywallBenefitCoach),
        (Icons.diversity_3_rounded, l.paywallBenefitPods),
        (Icons.edit_note_rounded, l.paywallBenefitCustom),
        (Icons.stairs_rounded, l.paywallBenefitDepth),
      ];

  // The "and also" tail — real, but nobody subscribes *for* these. They make
  // the bundle feel full; they never lead.
  List<(IconData, String)> _plusBenefits(AppLocalizations l) => [
        (Icons.shield_moon_outlined, l.paywallPlusStreak),
        (Icons.insights_rounded, l.paywallPlusInsights),
        (Icons.emoji_emotions_outlined, l.paywallPlusShare),
        (Icons.lock_outline_rounded, l.paywallPlusPrivacy),
      ];

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsChangesProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    final tier = settings.subscriptionTier;
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rung Premium'),
        actions: [
          if (tier.isPremium)
            TextButton(
              onPressed: () async {
                await settings.setSubscriptionTier(SubscriptionTier.free);
                await pushIdentityToCloud(ref);
              },
              child: Text(l.paywallSwitchToFree),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Insets.lg, Insets.sm, Insets.lg, Insets.xl),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Insets.lg),
            decoration: BoxDecoration(
              borderRadius: Radii.lgAll,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryDeep],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.workspace_premium_outlined,
                    color: Colors.white, size: 32),
                const SizedBox(height: Insets.sm),
                Text(l.paywallHeroTitle,
                    style: t.headlineSmall?.copyWith(color: Colors.white)),
                const SizedBox(height: Insets.xs),
                Text(
                  l.paywallHeroBody,
                  style: t.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.xl),
          Text(l.paywallWhatsIncluded, style: t.titleMedium),
          const SizedBox(height: Insets.md),
          for (final (icon, label) in _headlineBenefits(l))
            Padding(
              padding: const EdgeInsets.only(bottom: Insets.md),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: Insets.md),
                  Expanded(child: Text(label, style: t.bodyLarge)),
                  const Icon(Icons.check_rounded, color: AppColors.primary),
                ],
              ),
            ),

          // The quieter "and also" tail — grouped so it fills out the bundle
          // without competing with the headline reasons above.
          const SizedBox(height: Insets.xs),
          Container(
            padding: const EdgeInsets.all(Insets.md),
            decoration: BoxDecoration(
              // Theme-aware: a faint tint reads as almost nothing on a dark
              // background, so lift the alpha in dark mode and add a border for
              // definition in both.
              color: AppColors.primary.withValues(
                  alpha: Theme.of(context).brightness == Brightness.dark
                      ? 0.14
                      : 0.05),
              borderRadius: Radii.lgAll,
              border:
                  Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.paywallPlusHeader,
                    style: t.labelLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7))),
                const SizedBox(height: Insets.sm),
                for (final (icon, label) in _plusBenefits(l))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Icon(icon, color: AppColors.primary, size: 18),
                        const SizedBox(width: Insets.sm),
                        Expanded(
                            child: Text(label,
                                style: t.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface))),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Insets.lg),

          // Plan toggle.
          Row(
            children: [
              Expanded(
                child: _PlanCard(
                  title: l.paywallYearly,
                  price: _priceLabel(true),
                  per: l.paywallPerYear,
                  highlight: _yearly,
                  badge: l.paywallSave,
                  onTap: () => setState(() => _yearly = true),
                ),
              ),
              const SizedBox(width: Insets.md),
              Expanded(
                child: _PlanCard(
                  title: l.paywallMonthly,
                  price: _priceLabel(false),
                  per: l.paywallPerMonth,
                  highlight: !_yearly,
                  onTap: () => setState(() => _yearly = false),
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.lg),
          FilledButton(
            onPressed: _busy ? null : _onSubscribe,
            child: _busy
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(tier.isPremium
                    ? (_yearly ? l.paywallSwitchYearly : l.paywallSwitchMonthly)
                    : (_yearly
                        ? l.paywallStartYearly(_priceLabel(true))
                        : l.paywallStartMonthly(_priceLabel(false)))),
          ),
          if (purchasesReady) ...[
            const SizedBox(height: Insets.xs),
            Center(
              child: TextButton(
                onPressed: _busy ? null : _onRestore,
                child: Text(l.paywallRestore),
              ),
            ),
          ],
          const SizedBox(height: Insets.sm),
          Center(
            child: Text(
                tier.isPremium
                    ? l.paywallCurrentPlan(switch (tier) {
                        SubscriptionTier.free => l.tierFree,
                        SubscriptionTier.monthly => l.tierMonthly,
                        SubscriptionTier.yearly => l.tierYearly,
                      })
                    : l.paywallCancelAnytime,
                style: t.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.per,
    required this.highlight,
    required this.onTap,
    this.badge,
  });
  final String title;
  final String price;
  final String per;
  final bool highlight;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: Radii.lgAll,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Insets.md),
        decoration: BoxDecoration(
          color: highlight
              ? AppColors.primary.withValues(alpha: 0.12)
              : Theme.of(context).colorScheme.surface,
          borderRadius: Radii.lgAll,
          border: Border.all(
            color: highlight ? AppColors.primary : AppColors.border,
            width: highlight ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title,
                      style: t.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 6),
                  Flexible(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: Radii.pill,
                      ),
                      child: Text(badge!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 11)),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: Insets.sm),
            Text(price,
                style: t.headlineSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(per, style: t.bodyMedium, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
