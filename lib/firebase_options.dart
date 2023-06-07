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
    apiKey: 'AIzaSyC89_4sqOOylxixxgzbMb9czvRBmShRc1A',
    appId: '1:418605546790:web:f260a9fddd0427f7ba15e7',
    messagingSenderId: '418605546790',
    projectId: 'taxi-driver-1a1c3',
    authDomain: 'taxi-driver-1a1c3.firebaseapp.com',
    databaseURL: 'https://taxi-driver-1a1c3-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-driver-1a1c3.appspot.com',
    measurementId: 'G-QJ6MEJMS72',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjSTUhTRun2EY7YJIWnvg0uyjTw4fTTY4',
    appId: '1:418605546790:android:5c472474a1421e34ba15e7',
    messagingSenderId: '418605546790',
    projectId: 'taxi-driver-1a1c3',
    databaseURL: 'https://taxi-driver-1a1c3-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-driver-1a1c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABakRpVE4IjAVwfUmL8zrb9OsOfAmUFSA',
    appId: '1:418605546790:ios:3398247754f5d7edba15e7',
    messagingSenderId: '418605546790',
    projectId: 'taxi-driver-1a1c3',
    databaseURL: 'https://taxi-driver-1a1c3-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-driver-1a1c3.appspot.com',
    iosClientId: '418605546790-823sm1r8idr76m0aiu8dok1r7r1h779k.apps.googleusercontent.com',
    iosBundleId: 'com.example.movinguy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABakRpVE4IjAVwfUmL8zrb9OsOfAmUFSA',
    appId: '1:418605546790:ios:3398247754f5d7edba15e7',
    messagingSenderId: '418605546790',
    projectId: 'taxi-driver-1a1c3',
    databaseURL: 'https://taxi-driver-1a1c3-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-driver-1a1c3.appspot.com',
    iosClientId: '418605546790-823sm1r8idr76m0aiu8dok1r7r1h779k.apps.googleusercontent.com',
    iosBundleId: 'com.example.movinguy',
  );
}
