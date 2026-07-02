import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/purchases/purchase_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
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

    // Dev / no-keys fallback: simulate the tier so pod rules stay testable.
    if (!purchasesReady) {
      await settings.setSubscriptionTier(
          _yearly ? SubscriptionTier.yearly : SubscriptionTier.monthly);
      await pushIdentityToCloud(ref);
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
            'Premium active (simulated — add RevenueCat keys for real purchases).'),
      ));
      return;
    }

    final pkg = _selectedPackage;
    if (pkg == null) {
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("That plan isn't available right now. Try again shortly."),
      ));
      return;
    }
    setState(() => _busy = true);
    try {
      final tier = await ref.read(purchaseServiceProvider).buy(pkg);
      await settings.setSubscriptionTier(tier);
      await pushIdentityToCloud(ref);
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Premium active — thank you. 🌱'),
      ));
    } on PurchaseCancelled {
      // User backed out — nothing to say.
    } catch (_) {
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("The purchase didn't complete. You haven't been charged."),
      ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _onRestore() async {
    final settings = ref.read(settingsRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final tier = await ref.read(purchaseServiceProvider).restore();
      await settings.setSubscriptionTier(tier);
      await pushIdentityToCloud(ref);
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(tier.isPremium
            ? 'Purchases restored.'
            : 'No previous purchases found on this account.'),
      ));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Couldn't restore right now. Try again shortly."),
      ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // Honest value lines — these reflect what the tiers actually unlock. Ordered
  // to lead with belonging (the pods), which is what keeps people coming back.
  static const _benefits = [
    (Icons.diversity_3_rounded,
        "You're not doing this alone — join more support pods (3 on monthly, unlimited on yearly)"),
    (Icons.groups_2_outlined,
        'Bigger, warmer pods — up to 50 people who genuinely get it'),
    (Icons.stairs_rounded,
        "Go deeper when you're ready — up to 40 steps a track (free has 5)"),
    (Icons.add_circle_outline_rounded,
        'Build your own steps, shaped around the fears that are yours'),
    (Icons.lock_outline_rounded,
        'Always private, always ad-free — your practice stays yours'),
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsChangesProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    final tier = settings.subscriptionTier;
    final t = Theme.of(context).textTheme;
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
              child: const Text('Switch to Free'),
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
                Text("You don't have to face it alone.",
                    style: t.headlineSmall?.copyWith(color: Colors.white)),
                const SizedBox(height: Insets.xs),
                Text(
                  'The daily practice is always free. Premium opens up the '
                  'community — more pods, more people beside you — for when '
                  "you're ready to go further.",
                  style: t.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.xl),
          Text("What's included", style: t.titleMedium),
          const SizedBox(height: Insets.md),
          for (final (icon, label) in _benefits)
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
          const SizedBox(height: Insets.md),

          // Plan toggle.
          Row(
            children: [
              Expanded(
                child: _PlanCard(
                  title: 'Yearly',
                  price: _priceLabel(true),
                  per: 'per year · best value',
                  highlight: _yearly,
                  badge: 'Save 33%',
                  onTap: () => setState(() => _yearly = true),
                ),
              ),
              const SizedBox(width: Insets.md),
              Expanded(
                child: _PlanCard(
                  title: 'Monthly',
                  price: _priceLabel(false),
                  per: 'per month',
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
                    ? (_yearly ? 'Switch to yearly' : 'Switch to monthly')
                    : (_yearly
                        ? 'Start yearly — ${_priceLabel(true)}'
                        : 'Start monthly — ${_priceLabel(false)}')),
          ),
          if (purchasesReady) ...[
            const SizedBox(height: Insets.xs),
            Center(
              child: TextButton(
                onPressed: _busy ? null : _onRestore,
                child: const Text('Restore purchases'),
              ),
            ),
          ],
          const SizedBox(height: Insets.sm),
          Center(
            child: Text(
                tier.isPremium
                    ? 'Current plan: ${tier.label}. Cancel anytime.'
                    : 'Cancel anytime. The core loop stays free forever.',
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
                Text(title, style: t.titleMedium),
                const Spacer(),
                if (badge != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: Radii.pill,
                    ),
                    child: Text(badge!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 11)),
                  ),
              ],
            ),
            const SizedBox(height: Insets.sm),
            Text(price, style: t.headlineSmall),
            Text(per, style: t.bodyMedium),
          ],
        ),
      ),
    );
  }
}
