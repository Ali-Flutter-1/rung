import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// In-app Privacy Policy + Terms. These are a solid, honest starting draft that
/// reflects exactly what the app does today — NOT legal advice. Have them
/// reviewed by a lawyer and also hosted at a public URL before store submission
/// (App Store / Play both require a privacy-policy URL in the listing).

const _kContact = 'hello@rung.app'; // ← replace with your real support address
const _kUpdated = 'Last updated: June 2026';

class _Section {
  const _Section(this.heading, this.body);
  final String heading;
  final String body;
}

class _LegalScaffold extends StatelessWidget {
  const _LegalScaffold({
    required this.title,
    required this.intro,
    required this.sections,
  });
  final String title;
  final String intro;
  final List<_Section> sections;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Insets.lg,
            Insets.lg,
            Insets.lg,
            48,
          ),
          children: [
            Text(_kUpdated, style: t.bodySmall),
            const SizedBox(height: Insets.md),
            Text(intro, style: t.bodyLarge),
            const SizedBox(height: Insets.lg),
            for (final s in sections) ...[
              Text(s.heading, style: t.titleMedium),
              const SizedBox(height: Insets.xs),
              Text(s.body, style: t.bodyMedium),
              const SizedBox(height: Insets.lg),
            ],
            Text('Questions? Contact us at $_kContact.', style: t.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScaffold(
      title: 'Privacy Policy',
      intro:
          'Rung is a private practice tool for building social confidence. We '
          'collect as little as possible, and the most personal things you write '
          'never leave your phone. This policy explains what we store and why.',
      sections: [
        _Section(
          'What stays only on your device',
          'Your reflection notes and prediction notes — the private things you '
              'write about how a moment felt — are stored only in the app on your '
              'device. They are never uploaded to our servers.',
        ),
        _Section(
          'What we store in the cloud',
          'When you create an account we store: your email address (for sign-in; '
              'your password is encrypted and we never see it), an optional display '
              'name and bio, and your privacy-lock setting. To run the community '
              '(“pods”) we store the messages you post and any blocks or reports you '
              'make. To keep your progress safe across devices we back up numbers '
              'only — your streak, challenges completed, and anxiety ratings '
              '(predicted vs actual) — plus any custom steps you create. Note text '
              'is never included.',
        ),
        _Section(
          'Analytics',
          'We use privacy-respecting product analytics (PostHog) to understand '
              'which features help, using anonymous usage events such as “opened a '
              'screen” or “completed a step”. We never send the content of your '
              'notes or messages to analytics.',
        ),
        _Section(
          'How we use your information',
          'Only to provide the app: to sign you in, run the pods, restore your '
              'progress, and improve Rung using aggregate, anonymous trends. We do '
              'not sell your data or use it for advertising.',
        ),
        _Section(
          'Who processes your data',
          'We use Supabase (authentication, database, and hosting) and PostHog '
              '(analytics) as data processors. They handle data on our behalf under '
              'their own security and privacy commitments.',
        ),
        _Section(
          'Your rights & choices',
          'You can edit your profile, lock it so other members can’t see it, and '
              'permanently delete your account and all associated cloud data at any '
              'time from Profile → Delete account. You can also email us to request '
              'access to or deletion of your data.',
        ),
        _Section(
          'Security & retention',
          'Data is encrypted in transit, and every table is protected by '
              'row-level security so you can only ever access your own data (and '
              'pod messages you’re a member of). We keep your data until you delete '
              'your account or ask us to remove it.',
        ),
        _Section(
          'Children',
          'Rung is not intended for anyone under 16. If you believe a child has '
              'created an account, contact us and we will remove it.',
        ),
        _Section(
          'Not medical care',
          'Rung supports gradual practice but is not therapy, diagnosis, or '
              'medical advice. If you are in crisis, contact your local emergency '
              'services or a crisis line.',
        ),
        _Section(
          'Changes',
          'If we update this policy we’ll change the date above and, for material '
              'changes, let you know in the app.',
        ),
      ],
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScaffold(
      title: 'Terms of Service',
      intro:
          'These terms are the agreement between you and Rung when you use the '
          'app. By creating an account or using Rung, you agree to them.',
      sections: [
        _Section(
          'Not a medical service',
          'Rung is a self-help practice tool, not therapy or medical care, and '
              'does not replace professional help. It cannot guarantee any '
              'particular outcome. If you are in crisis or may harm yourself or '
              'others, contact your local emergency services immediately.',
        ),
        _Section(
          'Eligibility',
          'You must be at least 16 years old to use Rung and have the right to '
              'agree to these terms.',
        ),
        _Section(
          'Your account',
          'Keep your login details safe — you’re responsible for activity on your '
              'account. Tell us promptly if you suspect unauthorised use.',
        ),
        _Section(
          'Community rules (pods)',
          'Pods are for kindness and support. You agree not to harass, threaten, '
              'demean, spam, or post hateful or illegal content, and not to share '
              'other people’s private information. We may remove content or '
              'suspend accounts that break these rules. You can block and report '
              'other members at any time.',
        ),
        _Section(
          'Content you post',
          'You keep ownership of what you write. By posting in a pod you grant us '
              'permission to store and show it to the members of that pod so the '
              'community works. Don’t post anything you don’t have the right to '
              'share.',
        ),
        _Section(
          'Subscriptions',
          'Some features and extra practice content are available with a paid '
              'subscription. When billing is live, purchases and renewals are '
              'handled by the app store, and you can manage or cancel through your '
              'app-store account. Prices and inclusions may change with notice.',
        ),
        _Section(
          'Disclaimers & liability',
          'Rung is provided “as is”, without warranties of any kind. To the '
              'fullest extent permitted by law, we are not liable for indirect or '
              'consequential losses arising from your use of the app.',
        ),
        _Section(
          'Ending your use',
          'You can delete your account at any time from Profile → Delete account. '
              'We may suspend or end access if these terms are seriously or '
              'repeatedly broken.',
        ),
        _Section(
          'Changes',
          'We may update these terms; we’ll update the date above and, for '
              'significant changes, notify you in the app. Continuing to use Rung '
              'means you accept the updated terms.',
        ),
      ],
    );
  }
}
