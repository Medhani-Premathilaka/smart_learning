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

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJnQcYgtHSMPfvFOeIldEAdmocF78lNZc',
    appId: '1:639608617727:ios:02ac372c22e3d357ea2aca',
    messagingSenderId: '639608617727',
    projectId: 'slearning-96921',
    storageBucket: 'slearning-96921.firebasestorage.app',
    iosBundleId: 'com.example.slearning',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCw5P3eBxzx_h1vRV2cgA-Sm2iE2qEwyyo',
    appId: '1:639608617727:web:8d73ac6f756a61dcea2aca',
    messagingSenderId: '639608617727',
    projectId: 'slearning-96921',
    authDomain: 'slearning-96921.firebaseapp.com',
    storageBucket: 'slearning-96921.firebasestorage.app',
    measurementId: 'G-3266LFFZX2',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCw5P3eBxzx_h1vRV2cgA-Sm2iE2qEwyyo',
    appId: '1:639608617727:web:0bf4d6bcb356041eea2aca',
    messagingSenderId: '639608617727',
    projectId: 'slearning-96921',
    authDomain: 'slearning-96921.firebaseapp.com',
    storageBucket: 'slearning-96921.firebasestorage.app',
    measurementId: 'G-N97BNBEG1T',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJnQcYgtHSMPfvFOeIldEAdmocF78lNZc',
    appId: '1:639608617727:ios:02ac372c22e3d357ea2aca',
    messagingSenderId: '639608617727',
    projectId: 'slearning-96921',
    storageBucket: 'slearning-96921.firebasestorage.app',
    iosBundleId: 'com.example.slearning',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjR_UOl0nVQzl715Wce3fguCL-Y1BYavI',
    appId: '1:639608617727:android:cabd64e5773e29ebea2aca',
    messagingSenderId: '639608617727',
    projectId: 'slearning-96921',
    storageBucket: 'slearning-96921.firebasestorage.app',
  );

}