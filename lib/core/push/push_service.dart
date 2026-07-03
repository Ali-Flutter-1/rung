import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'push_bootstrap.dart';

/// Owns the device's FCM token lifecycle: ask permission, register the token to
/// the backend for the signed-in user, keep it fresh, and remove it on logout.
/// All methods no-op when Firebase isn't ready, so callers never need to guard.
class PushService {
  PushService({required this.onRegister, required this.onDelete});

  /// Persists (token, platform) to the backend for the signed-in user.
  final Future<void> Function(String token, String platform) onRegister;

  /// Removes a token from the backend (this device stops receiving pushes).
  final Future<void> Function(String token) onDelete;

  FirebaseMessaging get _fm => FirebaseMessaging.instance;
  String? _token;
  bool _inited = false;

  Future<void> _init() async {
    if (_inited) return;
    _inited = true;
    await _fm.requestPermission(alert: true, badge: true, sound: true);
    // Show notifications while the app is foregrounded (iOS).
    await _fm.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    _fm.onTokenRefresh.listen(_save);
  }

  /// Call after sign-in: grab this device's token and register it.
  Future<void> registerForUser() async {
    if (!firebaseReady) return;
    try {
      await _init();
      final token = await _fm.getToken();
      if (token != null) await _save(token);
    } catch (e) {
      if (kDebugMode) debugPrint('[push] register failed: $e');
    }
  }

  Future<void> _save(String token) async {
    // Avoid repeating the same registration/log spam when reactive providers
    // re-trigger registration without an actual token change.
    if (_token == token) return;
    _token = token;
    final platform =
        defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
    // Handy for testing: copy this from the console to send a Firebase test push.
    if (kDebugMode) debugPrint('[push] FCM token ($platform): $token');
    try {
      await onRegister(token, platform);
    } catch (e) {
      if (kDebugMode) debugPrint('[push] save token failed: $e');
    }
  }

  /// Call on logout: stop this device receiving pushes for the account.
  Future<void> unregister() async {
    if (!firebaseReady) return;
    try {
      final token = _token ?? await _fm.getToken();
      if (token != null) await onDelete(token);
      await _fm.deleteToken();
    } catch (e) {
      if (kDebugMode) debugPrint('[push] unregister failed: $e');
    }
    _token = null;
  }
}
