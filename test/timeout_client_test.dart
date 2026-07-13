import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rung/core/errors.dart';
import 'package:rung/core/net/timeout_client.dart';

/// An inner client whose responses we control: [delay] before completing, so we
/// can simulate a fast reply, a slow-but-fine reply, and a stalled connection.
class _FakeClient extends http.BaseClient {
  _FakeClient(this.delay);
  final Duration delay;
  var closed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    await Future<void>.delayed(delay);
    return http.StreamedResponse(const Stream.empty(), 200);
  }

  @override
  void close() => closed = true;
}

http.BaseRequest _req() =>
    http.Request('GET', Uri.parse('https://example.supabase.co/rest/v1/x'));

void main() {
  test('a fast response passes straight through', () async {
    final client =
        TimeoutHttpClient(_FakeClient(Duration.zero), timeout: const Duration(seconds: 1));
    final res = await client.send(_req());
    expect(res.statusCode, 200);
  });

  test('a stalled request throws TimeoutException, not a hang', () async {
    final client = TimeoutHttpClient(
      _FakeClient(const Duration(seconds: 30)), // never returns in time
      timeout: const Duration(milliseconds: 50),
    );
    await expectLater(client.send(_req()), throwsA(isA<TimeoutException>()));
  });

  test('the timeout is classified as an offline-style failure', () async {
    // This is the whole point: a slow network reaches the same friendly
    // "you're offline" message as a dead one, instead of leaking a raw error.
    final client = TimeoutHttpClient(
      _FakeClient(const Duration(seconds: 30)),
      timeout: const Duration(milliseconds: 50),
    );
    try {
      await client.send(_req());
      fail('should have timed out');
    } catch (e) {
      expect(isOfflineError(e), isTrue);
    }
  });

  test('closing the wrapper closes the inner client', () {
    final inner = _FakeClient(Duration.zero);
    TimeoutHttpClient(inner).close();
    expect(inner.closed, isTrue);
  });
}
