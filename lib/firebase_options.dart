// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBr4e4M692RstLI_s4TmjBFkqI7i52gLTA',
    appId: '1:436961639203:web:b15958fff4be71f0832a96',
    messagingSenderId: '436961639203',
    projectId: 'serenibot-1d581',
    authDomain: 'serenibot-1d581.firebaseapp.com',
    storageBucket: 'serenibot-1d581.appspot.com',
    measurementId: 'G-YB3G4JH4QQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpIFDILO_YPV7SpcYOAo8lvU0In_1MGeo',
    appId: '1:436961639203:android:f527b52f0778b418832a96',
    messagingSenderId: '436961639203',
    projectId: 'serenibot-1d581',
    storageBucket: 'serenibot-1d581.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9N-hLjUA2GQOWct5v6RknO8dm4Ey4jt8',
    appId: '1:436961639203:ios:16c2db9b1f330ea8832a96',
    messagingSenderId: '436961639203',
    projectId: 'serenibot-1d581',
    storageBucket: 'serenibot-1d581.appspot.com',
    iosBundleId: 'com.example.sereniChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9N-hLjUA2GQOWct5v6RknO8dm4Ey4jt8',
    appId: '1:436961639203:ios:76fb89fa4779555a832a96',
    messagingSenderId: '436961639203',
    projectId: 'serenibot-1d581',
    storageBucket: 'serenibot-1d581.appspot.com',
    iosBundleId: 'com.example.sereniChat.RunnerTests',
  );
}