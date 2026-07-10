import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// In-app Privacy Policy + Terms. These are a solid, honest starting draft that
/// reflects exactly what the app does today — NOT legal advice. Have them
/// reviewed by a lawyer and also hosted at a public URL before store submission
/// (App Store / Play both require a privacy-policy URL in the listing).

const _kContact = 'hello@rung.app'; // ← replace with your real support address

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
    final l = AppLocalizations.of(context);
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
            Text(l.legalLastUpdated, style: t.bodySmall),
            const SizedBox(height: Insets.md),
            Text(intro, style: t.bodyLarge),
            const SizedBox(height: Insets.lg),
            for (final s in sections) ...[
              Text(s.heading, style: t.titleMedium),
              const SizedBox(height: Insets.xs),
              Text(s.body, style: t.bodyMedium),
              const SizedBox(height: Insets.lg),
            ],
            Text(l.legalQuestions(_kContact), style: t.bodyMedium),
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
    final l = AppLocalizations.of(context);
    return _LegalScaffold(
      title: l.privacyTitle,
      intro: l.privacyIntro,
      sections: [
        _Section(l.ppWhatStaysHead, l.ppWhatStaysBody),
        _Section(l.ppCloudHead, l.ppCloudBody),
        _Section(l.ppAnalyticsHead, l.ppAnalyticsBody),
        _Section(l.ppUseHead, l.ppUseBody),
        _Section(l.ppProcessHead, l.ppProcessBody),
        _Section(l.ppRightsHead, l.ppRightsBody),
        _Section(l.ppSecurityHead, l.ppSecurityBody),
        _Section(l.ppChildrenHead, l.ppChildrenBody),
        _Section(l.ppMedicalHead, l.ppMedicalBody),
        _Section(l.ppChangesHead, l.ppChangesBody),
      ],
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return _LegalScaffold(
      title: l.termsTitle,
      intro: l.termsIntro,
      sections: [
        _Section(l.tosMedicalHead, l.tosMedicalBody),
        _Section(l.tosEligibilityHead, l.tosEligibilityBody),
        _Section(l.tosAccountHead, l.tosAccountBody),
        _Section(l.tosCommunityHead, l.tosCommunityBody),
        _Section(l.tosContentHead, l.tosContentBody),
        _Section(l.tosSubsHead, l.tosSubsBody),
        _Section(l.tosDisclaimerHead, l.tosDisclaimerBody),
        _Section(l.tosEndingHead, l.tosEndingBody),
        _Section(l.tosChangesHead, l.tosChangesBody),
      ],
    );
  }
}
