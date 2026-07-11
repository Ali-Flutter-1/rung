// Pins the async invariants the offline-crash fixes depend on.
//
// The bug: two cloud futures were started together, then awaited in sequence.
// When the first threw (offline, both reject at once), control jumped to the
// catch and the SECOND future was never awaited — an unhandled rejection that
// crashed the app past the surrounding try/catch. These tests demonstrate the
// hazard and prove the two constructs the fix uses do NOT orphan.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the OLD pattern orphans the second future when the first throws', () async {
    var secondSettled = false;
    Object? unhandled;

    await runZonedGuarded(() async {
      try {
        final f1 = Future<int>.error(StateError('offline'));
        final f2 = Future<int>.delayed(const Duration(milliseconds: 5), () {
          secondSettled = true;
          throw StateError('offline too'); // rejects with NO awaiter
        });
        final a = await f1; // throws → jump to catch; f2 is orphaned
        final b = await f2;
        expect([a, b], isEmpty); // unreachable
      } catch (_) {
        // swallowed — but f2's rejection escapes to the zone
      }
    }, (error, _) => unhandled = error);

    // Let the orphaned f2 reject.
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(secondSettled, isTrue);
    expect(unhandled, isNotNull,
        reason: 'the orphaned rejection reached the zone — this is the crash');
  });

  test('Future.wait awaits both, so nothing is orphaned', () async {
    var secondSettled = false;
    Object? unhandled;

    await runZonedGuarded(() async {
      try {
        await Future.wait([
          Future<int>.error(StateError('offline')),
          Future<int>.delayed(const Duration(milliseconds: 5), () {
            secondSettled = true;
            throw StateError('offline too');
          }),
        ]);
      } catch (_) {
        // both were awaited by Future.wait before it completed
      }
    }, (error, _) => unhandled = error);

    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(secondSettled, isTrue);
    expect(unhandled, isNull,
        reason: 'Future.wait handled both — no unhandled rejection');
  });

  test('Future.wait rethrows the ORIGINAL error (so isOfflineError still works)',
      () async {
    // Groups relies on this: the caught error must be the SocketException-shaped
    // one, not a ParallelWaitError wrapper, or the "you're offline" message is lost.
    Object? caught;
    try {
      await Future.wait([
        Future<int>.error(const SocketException('Failed host lookup')),
        Future<int>.value(1),
      ]);
    } catch (e) {
      caught = e;
    }
    expect(caught, isA<SocketException>());
  });

  test('record .wait awaits both heterogeneous futures without orphaning',
      () async {
    var secondSettled = false;
    Object? unhandled;

    await runZonedGuarded(() async {
      try {
        // Mirrors _loadEngagement: two different return types.
        final (_, _) = await (
          Future<String?>.error(StateError('offline')),
          Future<int>.delayed(const Duration(milliseconds: 5), () {
            secondSettled = true;
            throw StateError('offline too');
          }),
        ).wait;
      } catch (_) {
        // ParallelWaitError — both awaited, caught here.
      }
    }, (error, _) => unhandled = error);

    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(secondSettled, isTrue);
    expect(unhandled, isNull);
  });

  test('.ignore() drops a rejection instead of leaving it unhandled', () async {
    Object? unhandled;
    await runZonedGuarded(() async {
      // Mirrors the fire-and-forget markPodSeen() calls.
      Future<void>.error(const SocketException('offline')).ignore();
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }, (error, _) => unhandled = error);
    expect(unhandled, isNull,
        reason: '.ignore() attaches a no-op handler; unawaited() would crash');
  });
}

/// Local stand-in so we don't need dart:io in the test's type checks.
class SocketException implements Exception {
  const SocketException(this.message);
  final String message;
  @override
  String toString() => 'SocketException: $message';
}
