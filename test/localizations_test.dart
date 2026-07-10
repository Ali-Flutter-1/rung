// The GENERATED localizations: locale resolution, plural logic, placeholder
// substitution. The ARB files can be perfect and this layer still be wrong
// (a locale not registered, pt_PT collapsing to pt, a plural arm unreachable).
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/l10n/app_localizations.dart';

void main() {
  test('all 17 locales are registered as supported', () {
    expect(AppLocalizations.supportedLocales.length, 17);
  });

  test('European Portuguese is registered with its country code', () {
    expect(AppLocalizations.supportedLocales, contains(const Locale('pt', 'PT')));
    expect(AppLocalizations.supportedLocales, contains(const Locale('pt')));
  });

  test('every supported locale resolves and returns real strings', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final l = lookupAppLocalizations(locale);
      expect(l.navHome.trim(), isNotEmpty, reason: '$locale navHome');
      expect(l.predictDoIt.trim(), isNotEmpty, reason: '$locale predictDoIt');
      expect(l.breatheIn.trim(), isNotEmpty, reason: '$locale breatheIn');
    }
  });

  test('pt_PT resolves to European Portuguese, not Brazilian', () {
    final ptPt = lookupAppLocalizations(const Locale('pt', 'PT'));
    final pt = lookupAppLocalizations(const Locale('pt'));
    // "Guardar" (pt_PT) vs "Salvar" (pt) — if the country code were dropped
    // these would be the same object and the same string.
    expect(ptPt.commonSave, isNot(pt.commonSave));
    expect(ptPt.commonSave, 'Guardar');
    expect(pt.commonSave, 'Salvar');
  });

  test('an unlisted region falls back to its base language', () {
    // pt_BR is not registered explicitly; it must land on Brazilian pt.
    final ptBr = lookupAppLocalizations(const Locale('pt', 'BR'));
    expect(ptBr.commonSave, 'Salvar');
  });

  group('ICU plurals', () {
    test('English uses singular for 1 and plural otherwise', () {
      final en = lookupAppLocalizations(const Locale('en'));
      expect(en.podsCount(1), contains('1 pod'));
      expect(en.podsCount(3), contains('3 pods'));
    });

    test('Arabic distinguishes 1, 2, 3–10 and 11–99', () {
      final ar = lookupAppLocalizations(const Locale('ar'));
      final one = ar.podsCount(1);
      final two = ar.podsCount(2);
      final few = ar.podsCount(3); // broken plural: مجموعات
      final many = ar.podsCount(11); // singular: مجموعة
      expect({one, two, few, many}.length, 4,
          reason: 'each Arabic plural category must render differently');
      expect(few, isNot(many),
          reason: '3 and 11 take different noun forms in Arabic');
    });

    test('Polish distinguishes one / few / many', () {
      final pl = lookupAppLocalizations(const Locale('pl'));
      expect({pl.podsCount(1), pl.podsCount(3), pl.podsCount(11)}.length, 3);
    });

    test('Japanese has no plural inflection', () {
      final ja = lookupAppLocalizations(const Locale('ja'));
      expect(ja.podsCount(1), contains('1'));
      expect(ja.podsCount(5), contains('5'));
    });
  });

  group('placeholder substitution', () {
    test('a String placeholder is interpolated, not printed literally', () {
      final en = lookupAppLocalizations(const Locale('en'));
      final s = en.legalQuestions('hello@rung.app');
      expect(s, contains('hello@rung.app'));
      expect(s, isNot(contains('{email}')));
    });

    test('int placeholders are interpolated in every locale', () {
      for (final locale in AppLocalizations.supportedLocales) {
        final l = lookupAppLocalizations(locale);
        expect(l.insightsOverPredicted(42), contains('42'),
            reason: '$locale insightsOverPredicted');
        expect(l.smRound(7), contains('7'), reason: '$locale smRound');
      }
    });

    test('multi-placeholder messages keep both values', () {
      final de = lookupAppLocalizations(const Locale('de'));
      final s = de.resultGapHeadline(8, 3);
      expect(s, contains('8'));
      expect(s, contains('3'));
    });
  });

  test('custom-rung default copy differs across locales', () {
    // These are the strings that used to be frozen into the database row.
    final en = lookupAppLocalizations(const Locale('en'));
    final fr = lookupAppLocalizations(const Locale('fr'));
    final ja = lookupAppLocalizations(const Locale('ja'));
    expect({en.customDefaultWhy, fr.customDefaultWhy, ja.customDefaultWhy}.length, 3);
  });
}
