// Widget-level guard for the weekday strip.
//
// weekday_label_test.dart proves intl's NARROW form is one character. This
// proves the WIDGET actually asks for it — reverting to DateFormat.E would slip
// past a pure-intl test but must fail here.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/l10n/app_localizations.dart';
import 'package:rung/shared/progress_widgets.dart';

Widget _app(Locale locale) => MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: SingleChildScrollView(child: WeekStrip(activeDays: {})),
      ),
    );

/// The seven day initials rendered inside the strip. The heading ("This week")
/// is the first Text; the day labels follow.
List<String> _dayLabels(WidgetTester tester) => tester
    .widgetList<Text>(find.descendant(
      of: find.byType(WeekStrip),
      matching: find.byType(Text),
    ))
    .map((t) => t.data ?? '')
    .where((s) => s.isNotEmpty)
    .skip(1) // the "This week" heading
    .toList();

void main() {
  // A narrow phone — this is where the abbreviated names used to overflow.
  const narrowPhone = Size(320, 800);

  for (final locale in const [
    Locale('pt', 'PT'), // "domingo" / "segunda-feira" — the reported bug
    Locale('pl'), // "pon.", "wt."
    Locale('ar'), // RTL, long abbreviations
    Locale('da'),
    Locale('ja'),
    Locale('en'),
  ]) {
    testWidgets('$locale renders 7 single-character days with no overflow',
        (tester) async {
      await tester.binding.setSurfaceSize(narrowPhone);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(locale));
      await tester.pumpAndSettle();

      // A RenderFlex overflow surfaces as an exception in debug builds.
      expect(tester.takeException(), isNull,
          reason: '$locale overflowed the weekday row');

      final labels = _dayLabels(tester);
      expect(labels.length, 7, reason: '$locale: expected 7 day labels');
      for (final label in labels) {
        expect(label.runes.length, 1,
            reason: '$locale rendered "$label" — the widget is not using the '
                'CLDR narrow weekday form (DateFormat.EEEEE)');
      }
    });
  }

  testWidgets('European Portuguese shows the conventional D S T Q Q S S',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_app(const Locale('pt', 'PT')));
    await tester.pumpAndSettle();

    expect(_dayLabels(tester), ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']);
  });

  testWidgets('the heading is localized', (tester) async {
    await tester.pumpWidget(_app(const Locale('de')));
    await tester.pumpAndSettle();
    expect(find.text('Diese Woche'), findsOneWidget);
  });
}
