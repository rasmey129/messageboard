// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvxW754XM3l0ytwn1zdmxLMyebI_eeiUY',
    appId: '1:410522016963:web:df8ff9f0d338ec063dd676',
    messagingSenderId: '410522016963',
    projectId: 'chatbox-e934c',
    authDomain: 'chatbox-e934c.firebaseapp.com',
    storageBucket: 'chatbox-e934c.firebasestorage.app',
    measurementId: 'G-FRKSQD7B6P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDodms6iXbg6X5p9H9KTpeoPEXSTKBdjk8',
    appId: '1:410522016963:android:f21b97bec612a2a33dd676',
    messagingSenderId: '410522016963',
    projectId: 'chatbox-e934c',
    storageBucket: 'chatbox-e934c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANqEe4D8s5CRxvxqZiwYEDP8ow4rUYzwY',
    appId: '1:410522016963:ios:fb5482b96bc8e2003dd676',
    messagingSenderId: '410522016963',
    projectId: 'chatbox-e934c',
    storageBucket: 'chatbox-e934c.firebasestorage.app',
    iosBundleId: 'com.example.messageboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANqEe4D8s5CRxvxqZiwYEDP8ow4rUYzwY',
    appId: '1:410522016963:ios:fb5482b96bc8e2003dd676',
    messagingSenderId: '410522016963',
    projectId: 'chatbox-e934c',
    storageBucket: 'chatbox-e934c.firebasestorage.app',
    iosBundleId: 'com.example.messageboard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvxW754XM3l0ytwn1zdmxLMyebI_eeiUY',
    appId: '1:410522016963:web:4967c834b8830de83dd676',
    messagingSenderId: '410522016963',
    projectId: 'chatbox-e934c',
    authDomain: 'chatbox-e934c.firebaseapp.com',
    storageBucket: 'chatbox-e934c.firebasestorage.app',
    measurementId: 'G-YEN0WRX4CH',
  );
}
