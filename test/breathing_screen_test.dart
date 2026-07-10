// The 60-second guided breath offered before a rung attempt.
//
// Timing is the whole feature: 4s in / 4s hold / 6s out, and the exercise must
// finish a FULL cycle rather than cutting an exhale short at the 60s mark. One
// cycle is 14s, so the check at the inhale boundary first passes at 70s.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/features/breathing/breathing_screen.dart';
import 'package:rung/l10n/app_localizations.dart';

const _inhale = Duration(seconds: 4);
const _hold = Duration(seconds: 4);
const _exhale = Duration(seconds: 6);
const _cycle = Duration(seconds: 14);

Widget _app(Locale locale, {Widget? home}) => MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: home ?? const BreathingScreen(),
    );

/// Tear the widget down so no phase Timer outlives the test.
Future<void> _disposeScreen(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
}

void main() {
  group('phase cycle', () {
    testWidgets('starts on the inhale, showing the intro', (tester) async {
      await tester.pumpWidget(_app(const Locale('en')));

      expect(find.text('Breathe in'), findsOneWidget);
      expect(find.text('Sixty seconds. Just follow the circle.'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);

      await _disposeScreen(tester);
    });

    testWidgets('walks in → hold → out → in with the right durations',
        (tester) async {
      await tester.pumpWidget(_app(const Locale('en')));
      expect(find.text('Breathe in'), findsOneWidget);

      // Still inhaling one frame before the phase ends.
      await tester.pump(_inhale - const Duration(milliseconds: 1));
      expect(find.text('Breathe in'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 1));
      expect(find.text('Hold'), findsOneWidget);

      await tester.pump(_hold);
      expect(find.text('Breathe out'), findsOneWidget);

      await tester.pump(_exhale);
      expect(find.text('Breathe in'), findsOneWidget,
          reason: 'the cycle should loop back to the inhale');

      await _disposeScreen(tester);
    });

    testWidgets('the exhale is longer than the inhale', (tester) async {
      // A longer exhale is what settles the nervous system — not a box breath.
      expect(_exhale, greaterThan(_inhale));
      await tester.pumpWidget(_app(const Locale('en')));

      await tester.pump(_inhale + _hold); // now exhaling
      expect(find.text('Breathe out'), findsOneWidget);

      // Still exhaling after a full inhale's worth of time has passed.
      await tester.pump(_inhale);
      expect(find.text('Breathe out'), findsOneWidget);

      await _disposeScreen(tester);
    });
  });

  group('completion', () {
    testWidgets('does not finish mid-cycle at the 60s mark', (tester) async {
      await tester.pumpWidget(_app(const Locale('en')));

      // 60s lands inside the fifth cycle (56s..70s) — an exhale must not be cut.
      await tester.pump(const Duration(seconds: 60));
      expect(find.text('That’s it.'), findsNothing,
          reason: 'the exercise must complete the cycle it is in');

      await _disposeScreen(tester);
    });

    testWidgets('finishes at the end of the cycle that crosses 60s',
        (tester) async {
      await tester.pumpWidget(_app(const Locale('en')));

      await tester.pump(_cycle * 5); // 70s — first inhale boundary past 60s
      await tester.pump();

      expect(find.text('That’s it.'), findsOneWidget);
      expect(
        find.text('Feel a little steadier? Go do your rung whenever you’re ready.'),
        findsOneWidget,
      );
      expect(find.text('Done'), findsOneWidget);

      // The breathing UI is gone.
      expect(find.text('Breathe in'), findsNothing);
      expect(find.text('Skip'), findsNothing,
          reason: 'Skip is pointless once the breath is done');

      await _disposeScreen(tester);
    });

    testWidgets('no timer is left pending after it finishes', (tester) async {
      await tester.pumpWidget(_app(const Locale('en')));
      await tester.pump(_cycle * 5);
      await tester.pump();
      // pumpAndSettle would hang if a phase Timer were still chaining.
      await tester.pumpAndSettle();
      expect(find.text('That’s it.'), findsOneWidget);

      await _disposeScreen(tester);
    });
  });

  group('navigation', () {
    testWidgets('openBreathing pushes the screen and Skip pops it',
        (tester) async {
      await tester.pumpWidget(_app(
        const Locale('en'),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => openBreathing(context),
                child: const Text('breathe'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('breathe'));
      // NOT pumpAndSettle: the breath animates continuously, so settling would
      // run the whole 70s exercise. Pump just past the route transition.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Breathe in'), findsOneWidget);

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(find.text('Breathe in'), findsNothing);
      expect(find.text('breathe'), findsOneWidget,
          reason: 'Skip should return to the caller');
    });

    testWidgets('Done dismisses the screen after completion', (tester) async {
      await tester.pumpWidget(_app(
        const Locale('en'),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => openBreathing(context),
                child: const Text('breathe'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('breathe'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(_cycle * 5);
      await tester.pump();

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(find.text('breathe'), findsOneWidget);
    });
  });

  group('localization', () {
    testWidgets('phase labels are translated', (tester) async {
      await tester.pumpWidget(_app(const Locale('fr')));
      expect(find.text('Inspire'), findsOneWidget);

      await tester.pump(_inhale);
      expect(find.text('Retiens'), findsOneWidget);

      await tester.pump(_hold);
      expect(find.text('Expire'), findsOneWidget);

      await _disposeScreen(tester);
    });

    testWidgets('the finish state is translated', (tester) async {
      await tester.pumpWidget(_app(const Locale('ja')));
      await tester.pump(_cycle * 5);
      await tester.pump();

      expect(find.text('これでおしまい。'), findsOneWidget);
      expect(find.text('完了'), findsOneWidget);

      await _disposeScreen(tester);
    });
  });
}
