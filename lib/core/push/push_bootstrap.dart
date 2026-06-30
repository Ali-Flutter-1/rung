import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

/// True once Firebase initialized this session — gates all push work so the app
/// runs fine even if Firebase is misconfigured (mirrors `supabaseReady`).
bool firebaseReady = false;

/// Required FCM hook. Notification messages are rendered by the OS when the app
/// is backgrounded/terminated, so there's nothing to do here — but the handler
/// must exist and be a top-level/static function.
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {}

/// Self-guarding Firebase init — called from main(). Never throws.
Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
    firebaseReady = true;
  } catch (e) {
    if (kDebugMode) debugPrint('[firebase] init failed: $e');
    firebaseReady = false;
  }
}
