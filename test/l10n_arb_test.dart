// Structural integrity of the 17 ARB translation files.
//
// These run against the files on disk rather than the generated Dart, so a
// hand-edited or script-appended ARB that would silently ship English (or blow
// up at runtime on a bad placeholder) fails here instead of in the store.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _expectedLocales = <String>[
  'ar', 'da', 'de', 'en', 'es', 'fr', 'id', 'it', 'ja',
  'ko', 'ms', 'nb', 'nl', 'pl', 'pt', 'pt_PT', 'sv',
];

/// Message keys only — `@key` metadata entries are not translations.
Map<String, String> _messages(Map<String, dynamic> arb) => {
      for (final e in arb.entries)
        if (!e.key.startsWith('@')) e.key: e.value as String,
    };

Map<String, dynamic> _load(String locale) => jsonDecode(
      File('lib/l10n/app_$locale.arb').readAsStringSync(),
    ) as Map<String, dynamic>;

/// Placeholder names in `{braces}`, ignoring ICU plural machinery.
Set<String> _placeholders(String value) =>
    RegExp(r'\{(\w+)\}').allMatches(value).map((m) => m.group(1)!).toSet();

bool _isPlural(String value) => value.contains(', plural,');

void main() {
  late Map<String, String> en;

  setUpAll(() => en = _messages(_load('en')));

  test('every expected locale file exists, and no unexpected ones', () {
    final onDisk = Directory('lib/l10n')
        .listSync()
        .map((f) => f.path.split('/').last)
        .where((n) => n.startsWith('app_') && n.endsWith('.arb'))
        .map((n) => n.substring(4, n.length - 4))
        .toList()
      ..sort();
    expect(onDisk, _expectedLocales);
  });

  test('the template defines a non-trivial number of keys', () {
    expect(en.length, greaterThan(500));
  });

  for (final locale in _expectedLocales) {
    group('app_$locale.arb', () {
      late Map<String, String> messages;

      setUpAll(() => messages = _messages(_load(locale)));

      test('has exactly the template keys — none missing, none extra', () {
        expect(messages.keys.toSet().difference(en.keys.toSet()), isEmpty,
            reason: '$locale has keys the template does not');
        expect(en.keys.toSet().difference(messages.keys.toSet()), isEmpty,
            reason: '$locale is missing template keys');
      });

      test('no value is empty or whitespace-only', () {
        for (final e in messages.entries) {
          expect(e.value.trim(), isNotEmpty, reason: '$locale.${e.key}');
        }
      });

      test('placeholders match the template exactly', () {
        for (final key in en.keys) {
          if (_isPlural(en[key]!)) continue; // ICU plural handled separately
          expect(_placeholders(messages[key]!), _placeholders(en[key]!),
              reason: '$locale.$key placeholder mismatch — a missing {arg} '
                  'renders a literal brace; an invented one throws at runtime');
        }
      });

      test('braces are balanced in every value', () {
        for (final e in messages.entries) {
          final open = '{'.allMatches(e.value).length;
          final close = '}'.allMatches(e.value).length;
          expect(open, close, reason: '$locale.${e.key} has unbalanced braces');
        }
      });

      test('ICU plural messages keep the mandatory "other" branch', () {
        for (final key in en.keys.where((k) => _isPlural(en[k]!))) {
          expect(messages[key], contains(', plural,'),
              reason: '$locale.$key lost its plural form');
          expect(messages[key], contains('other{'),
              reason: '$locale.$key is missing the required "other" branch');
        }
      });

      if (locale != 'en') {
        test('is actually translated, not an English copy', () {
          final identical =
              en.keys.where((k) => messages[k] == en[k]).toList();
          // A handful legitimately match ("Premium", "P1", "2048").
          expect(identical.length / en.length, lessThan(0.05),
              reason: '$locale looks like it fell back to English: '
                  '${identical.length}/${en.length} values are identical. '
                  'First few: ${identical.take(5).toList()}');
        });
      }
    });
  }

  test('Arabic covers all six CLDR plural categories for podsCount', () {
    final ar = _messages(_load('ar'))['podsCount']!;
    for (final category in ['zero{', 'one{', 'two{', 'few{', 'many{', 'other{']) {
      expect(ar, contains(category),
          reason: 'Arabic needs distinct forms for 2, 3–10 and 11–99');
    }
  });

  test('European Portuguese is not a copy of Brazilian Portuguese', () {
    final pt = _messages(_load('pt'));
    final ptPt = _messages(_load('pt_PT'));
    final identical = pt.keys.where((k) => pt[k] == ptPt[k]).length;
    expect(identical / pt.length, lessThan(0.9),
        reason: 'pt_PT should use European forms (tu, ecrã, telemóvel), '
            'not be a duplicate of pt');
  });
}
