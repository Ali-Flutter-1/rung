// A local write failing (device storage full) must NOT look like success.
// The write paths catch it, tell the user, and stay put with their input.
//
// Predict is the clean representative: its failure path returns before any
// navigation, so no router is needed. Reflect and add-custom-rung use the
// identical try/catch → errorSaveFailed → return pattern.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/app/providers.dart';
import 'package:rung/domain/entities/attempt.dart';
import 'package:rung/domain/entities/rung.dart';
import 'package:rung/domain/repositories/attempt_repository.dart';
import 'package:rung/features/challenge/predict_screen.dart';
import 'package:rung/l10n/app_localizations.dart';

/// Only the methods the predict flow touches are real; everything else throws
/// via noSuchMethod so the fake stays tiny.
class _ThrowOnWriteRepo implements AttemptRepository {
  @override
  Future<Attempt> startChallenge({
    required String rungId,
    required int predictedSuds,
    String? predictedNote,
  }) async {
    throw Exception('SqliteException(13): database or disk is full');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError(invocation.memberName.toString());
}

final _rung = Rung(
  id: 'r1',
  trackId: 't1',
  title: 'Say hi to a neighbour',
  whatToDo: 'Say hello.',
  whyItHelps: 'It helps.',
  difficulty: 3,
  sortOrder: 1,
);

Widget _app() => ProviderScope(
      overrides: [
        // Render the form (not the spinner) without a real database.
        rungByIdProvider('r1').overrideWith((ref) => _rung),
        attemptRepositoryProvider.overrideWithValue(_ThrowOnWriteRepo()),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          ...AppLocalizations.localizationsDelegates,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: PredictScreen(rungId: 'r1'),
      ),
    );

void main() {
  testWidgets('a failed save shows the storage message', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle(); // rungByIdProvider resolves → form renders

    expect(find.text('Say hi to a neighbour'), findsOneWidget);

    await tester.tap(find.byType(FilledButton)); // "I'll do it"
    await tester.pump(); // _submit starts, write throws
    await tester.pump(const Duration(milliseconds: 400)); // snackbar animates in

    expect(find.textContaining('low on storage'), findsOneWidget);
  });

  testWidgets('a failed save does NOT navigate away — the rung is not lost',
      (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Still on the predict screen — its title proves we didn't route to the
    // dashboard as if the write had succeeded.
    expect(find.text('Say hi to a neighbour'), findsOneWidget);
    expect(find.byType(PredictScreen), findsOneWidget);
  });

  testWidgets('the button re-enables so the user can retry', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // _saving is back to false → the button shows its label, not a spinner.
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull);
    expect(find.descendant(
      of: find.byType(FilledButton),
      matching: find.byType(CircularProgressIndicator),
    ), findsNothing);
  });
}
