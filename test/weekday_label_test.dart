// Regression guard for the weekday strip on Dashboard + Insights.
//
// The strip renders one day per 34px dot. It used to use DateFormat.E, the
// ABBREVIATED weekday, which is 7 characters in European Portuguese
// ("domingo"), 8 in Arabic and 6 in Polish — so the row overflowed. It now uses
// DateFormat.EEEEE, the CLDR NARROW form, which is a single character in every
// language we ship.
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const _locales = <String>[
  'ar', 'da', 'de', 'en', 'es', 'fr', 'id', 'it', 'ja',
  'ko', 'ms', 'nb', 'nl', 'pl', 'pt', 'pt_PT', 'sv',
];

/// A known Sunday, so the week starts where WeekStrip starts it.
final _sunday = DateTime(2026, 7, 5);

List<String> _narrowWeek(String locale) => [
      for (var i = 0; i < 7; i++)
        DateFormat.EEEEE(locale).format(_sunday.add(Duration(days: i))),
    ];

List<String> _abbreviatedWeek(String locale) => [
      for (var i = 0; i < 7; i++)
        DateFormat.E(locale).format(_sunday.add(Duration(days: i))),
    ];

void main() {
  setUpAll(() async => initializeDateFormatting());

  test('the reference date really is a Sunday', () {
    expect(_sunday.weekday, DateTime.sunday);
  });

  for (final locale in _locales) {
    group(locale, () {
      test('narrow weekday labels are a single character', () {
        for (final label in _narrowWeek(locale)) {
          expect(label.runes.length, 1,
              reason: '$locale narrow label "$label" would not fit the dot');
        }
      });

      test('a full week yields seven labels', () {
        expect(_narrowWeek(locale).length, 7);
      });
    });
  }

  test('abbreviated labels are what used to overflow', () {
    // Documents the bug rather than just asserting the fix: if someone
    // "simplifies" DateFormat.EEEEE back to DateFormat.E, this shows why not.
    int widest(String locale) => _abbreviatedWeek(locale)
        .map((s) => s.runes.length)
        .reduce((a, b) => a > b ? a : b);

    expect(widest('pt_PT'), greaterThan(3));
    expect(widest('ar'), greaterThan(3));
    expect(widest('pl'), greaterThan(3));
    expect(widest('da'), greaterThan(3));

    // ...and the narrow form fixes all of them.
    for (final locale in _locales) {
      final narrowWidest = _narrowWeek(locale)
          .map((s) => s.runes.length)
          .reduce((a, b) => a > b ? a : b);
      expect(narrowWidest, 1, reason: locale);
    }
  });

  test('Portuguese uses the conventional D S T Q Q S S header', () {
    expect(_narrowWeek('pt_PT'), ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']);
  });

  test('Japanese uses single-kanji day names', () {
    expect(_narrowWeek('ja'), ['日', '月', '火', '水', '木', '金', '土']);
  });
}
