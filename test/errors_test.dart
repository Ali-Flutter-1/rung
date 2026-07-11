import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rung/core/errors.dart';
import 'package:rung/l10n/app_localizations_en.dart';
import 'package:rung/l10n/app_localizations_ja.dart';

/// Stand-ins for the exception TYPES Supabase throws offline, matched by the
/// text of their toString() (we can't import the SDK's private types here).
class _FakeException implements Exception {
  _FakeException(this.message);
  final String message;
  @override
  String toString() => message;
}

void main() {
  group('isOfflineError — real offline failures', () {
    test('SocketException (mobile: no route to host)', () {
      expect(isOfflineError(const SocketException('Failed host lookup')), isTrue);
    });

    test('TimeoutException', () {
      expect(isOfflineError(TimeoutException('timed out')), isTrue);
    });

    // The strings Supabase's various clients actually produce with no network.
    for (final message in const [
      'ClientException with SocketException: Failed host lookup: '
          "'abc.supabase.co'",
      'ClientException: Connection closed before full header was received',
      'SocketException: Connection refused',
      'AuthRetryableFetchException: Network request failed',
      'Connection reset by peer',
      'Network is unreachable',
      'XMLHttpRequest error.', // web
      'TimeoutException after 0:00:10.000000',
    ]) {
      test('classifies: "${message.split(':').first}…"', () {
        expect(isOfflineError(_FakeException(message)), isTrue, reason: message);
      });
    }
  });

  group('isOfflineError — genuine faults are NOT offline', () {
    test('null', () => expect(isOfflineError(null), isFalse));

    // A real server/logic error must fall through to the generic message, not
    // be excused as "you're offline".
    for (final message in const [
      'PostgrestException: duplicate key value violates unique constraint',
      'AuthException: Invalid login credentials',
      'pod is full',
      'RangeError (index): Invalid value',
      'type \'Null\' is not a subtype of type \'String\'',
    ]) {
      test('does not classify: "${message.split(':').first}…"', () {
        expect(isOfflineError(_FakeException(message)), isFalse, reason: message);
      });
    }
  });

  group('friendlyError', () {
    final en = AppLocalizationsEn();
    final ja = AppLocalizationsJa();

    test('offline error maps to the localized offline message', () {
      expect(friendlyError(const SocketException('x'), en), en.errorOffline);
      expect(friendlyError(const SocketException('x'), ja), ja.errorOffline);
    });

    test('other errors map to the localized generic message', () {
      final boom = _FakeException('PostgrestException: boom');
      expect(friendlyError(boom, en), en.errorGeneric);
      expect(friendlyError(boom, ja), ja.errorGeneric);
    });

    test('never returns a raw exception string', () {
      final raw = _FakeException('Failed host lookup: secret-project.supabase.co');
      final shown = friendlyError(raw, en);
      expect(shown, isNot(contains('supabase')));
      expect(shown, isNot(contains('lookup')));
      expect(shown, anyOf(en.errorOffline, en.errorGeneric));
    });

    test('the two messages are distinct and non-empty', () {
      expect(en.errorOffline.trim(), isNotEmpty);
      expect(en.errorGeneric.trim(), isNotEmpty);
      expect(en.errorOffline, isNot(en.errorGeneric));
    });
  });
}
