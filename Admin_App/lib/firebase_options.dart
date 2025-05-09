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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBs6I_wx9gKg5QAAYeQAoukh_DvNtCZQr0',
    appId: '1:748280935846:web:1516291818898b08108b67',
    messagingSenderId: '748280935846',
    projectId: 'spacehub-4da14',
    authDomain: 'spacehub-4da14.firebaseapp.com',
    storageBucket: 'spacehub-4da14.firebasestorage.app',
    measurementId: 'G-LJN4XVR5TW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-Y_cC4tWuJBt-kkjjK4API1jhNHH28cI',
    appId: '1:748280935846:android:6f3fd9a2c8705441108b67',
    messagingSenderId: '748280935846',
    projectId: 'spacehub-4da14',
    storageBucket: 'spacehub-4da14.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB76DrWg94COgI5Xc28PvGj1i3VvOZwkhY',
    appId: '1:748280935846:ios:bd417867a2f655be108b67',
    messagingSenderId: '748280935846',
    projectId: 'spacehub-4da14',
    storageBucket: 'spacehub-4da14.firebasestorage.app',
    androidClientId: '748280935846-43t0cij5lkla49uulub5lqs7e4hil1e0.apps.googleusercontent.com',
    iosClientId: '748280935846-u2m33u116ohsimn5i0e1nttckj4jo9ls.apps.googleusercontent.com',
    iosBundleId: 'com.ahmad616.adminApp',
  );
}
