import 'package:http/http.dart' as http;

/// Wraps every Supabase REST request (auth, database, functions, storage) in a
/// hard timeout.
///
/// Realtime traffic rides a WebSocket on a different transport and is NOT
/// affected — persistent subscriptions must not be timed out.
///
/// Without this, a *slow* or half-open network (captive portal, high latency, a
/// connection that opened but stalled) is not the same as being offline: DNS
/// succeeds, so the call neither fails fast nor returns, and the UI hangs on a
/// spinner until the OS socket timeout (tens of seconds) finally fires. This
/// turns that hang into a prompt [TimeoutException], which the app already
/// classifies as an offline-style failure and shows a friendly message for.
class TimeoutHttpClient extends http.BaseClient {
  TimeoutHttpClient(this._inner, {this.timeout = const Duration(seconds: 12)});

  final http.Client _inner;
  final Duration timeout;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _inner.send(request).timeout(timeout);

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
