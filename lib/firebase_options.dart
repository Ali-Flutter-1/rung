// Firebase config for project rung-1c1b1. Values are client identifiers (safe
// to ship, like the Supabase anon key). Mirrors what `flutterfire configure`
// generates — running that tool later will simply regenerate this file.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase web is not configured for Rung.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'Firebase is not configured for $defaultTargetPlatform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATphoRpdAZUUZiSS8Bu4T8uUd4T-8_Od8',
    appId: '1:679728768976:android:a646661334b1a717e37bd5',
    messagingSenderId: '679728768976',
    projectId: 'rung-1c1b1',
    storageBucket: 'rung-1c1b1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1jDYe4wiTQ6BfNaIpAApim4ItrCgePtk',
    appId: '1:679728768976:ios:bfc5fe762bcb9154e37bd5',
    messagingSenderId: '679728768976',
    projectId: 'rung-1c1b1',
    storageBucket: 'rung-1c1b1.firebasestorage.app',
    iosBundleId: 'com.rung.app',
  );
}
