import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/analytics/analytics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subscription.dart';
import '../profile/profile_sync.dart';

/// Tab 4 — premium plans. Real in-app purchases (RevenueCat / StoreKit / Play
/// Billing) are wired in the monetization phase; for now selecting a plan sets
/// a local tier flag so the pod rules are testable end-to-end. The core
/// therapeutic loop always stays free (§1.10).
class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _yearly = true;

  @override
  void initState() {
    super.initState();
    ref.read(analyticsProvider).capture(Ev.paywallViewed);
  }

  static const _benefits = [
    (Icons.all_inclusive_rounded, 'Every rung on all 6 tracks'),
    (Icons.auto_awesome_outlined, 'AI Co-pilot — scripts, drafts & rehearsals'),
    (Icons.menu_book_outlined, 'The full Lessons library'),
    (Icons.groups_2_outlined, 'Priority access to new pods'),
    (Icons.insights_rounded, 'Advanced insights & data export'),
    (Icons.notifications_active_outlined, 'Smart, gentle reminders'),
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
                Text('Go further, gently.',
                    style: t.headlineSmall?.copyWith(color: Colors.white)),
                const SizedBox(height: Insets.xs),
                Text(
                  'The core loop is always free. Premium unlocks the rest when '
                  'you\'re ready for more.',
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
                  price: '\$39.99',
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
                  price: '\$4.99',
                  per: 'per month',
                  highlight: !_yearly,
                  onTap: () => setState(() => _yearly = false),
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.lg),
          FilledButton(
            onPressed: () async {
              ref.read(analyticsProvider).capture(
                  Ev.subscribeTapped, {'plan': _yearly ? 'yearly' : 'monthly'});
              final messenger = ScaffoldMessenger.of(context);
              await settings.setSubscriptionTier(
                  _yearly ? SubscriptionTier.yearly : SubscriptionTier.monthly);
              // Sync the tier to the cloud profile so the server's pod limits
              // (free 1 / monthly 3 / yearly ∞) actually apply when joining.
              await pushIdentityToCloud(ref);
              messenger.showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                      'Premium active (simulated — real purchases come later).'),
                ),
              );
            },
            child: Text(tier.isPremium
                ? (_yearly ? 'Switch to yearly' : 'Switch to monthly')
                : (_yearly ? 'Start yearly — \$39.99' : 'Start monthly — \$4.99')),
          ),
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
