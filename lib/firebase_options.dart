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
    apiKey: 'AIzaSyCnuPZ8yycVHTx3ND1o7l0d9fDv19Gq3Uo',
    appId: '1:313812641302:web:28f493096b66429fcbf737',
    messagingSenderId: '313812641302',
    projectId: 'cacalia-sys',
    authDomain: 'cacalia-sys.firebaseapp.com',
    storageBucket: 'cacalia-sys.firebasestorage.app',
    measurementId: 'G-T87YQ9D835',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBURR7SlTYuWuQIV-SONNVx1xEz0x-t0b4',
    appId: '1:313812641302:android:5c99460eba096fc6cbf737',
    messagingSenderId: '313812641302',
    projectId: 'cacalia-sys',
    storageBucket: 'cacalia-sys.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnvueQNAKukG5nSWKOwZTZPoDZszEZ-ik',
    appId: '1:313812641302:ios:0cbfb5c2f5fdf1becbf737',
    messagingSenderId: '313812641302',
    projectId: 'cacalia-sys',
    storageBucket: 'cacalia-sys.firebasestorage.app',
    iosBundleId: 'com.example.cacalia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnvueQNAKukG5nSWKOwZTZPoDZszEZ-ik',
    appId: '1:313812641302:ios:0cbfb5c2f5fdf1becbf737',
    messagingSenderId: '313812641302',
    projectId: 'cacalia-sys',
    storageBucket: 'cacalia-sys.firebasestorage.app',
    iosBundleId: 'com.example.cacalia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCnuPZ8yycVHTx3ND1o7l0d9fDv19Gq3Uo',
    appId: '1:313812641302:web:6e86c63f2c139947cbf737',
    messagingSenderId: '313812641302',
    projectId: 'cacalia-sys',
    authDomain: 'cacalia-sys.firebaseapp.com',
    storageBucket: 'cacalia-sys.firebasestorage.app',
    measurementId: 'G-38ELMNQE0S',
  );
}