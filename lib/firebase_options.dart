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
    apiKey: 'AIzaSyAI9OjmlPtNBszPGG8M8lsxF7RSuppzplc',
    appId: '1:1019264195982:web:8229eb3ac3a3112af7d8df',
    messagingSenderId: '1019264195982',
    projectId: 'seth-login',
    authDomain: 'seth-login.firebaseapp.com',
    databaseURL: 'https://seth-login-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'seth-login.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGRW2MXFT03UZId15t6mVTeMSHzdQ01k8',
    appId: '1:1019264195982:android:08559a1b4b6fc645f7d8df',
    messagingSenderId: '1019264195982',
    projectId: 'seth-login',
    databaseURL: 'https://seth-login-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'seth-login.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVashVGi44KFjXWrY0UtaGtuc5lUkEvkg',
    appId: '1:1019264195982:ios:ef9e38657332457bf7d8df',
    messagingSenderId: '1019264195982',
    projectId: 'seth-login',
    databaseURL: 'https://seth-login-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'seth-login.firebasestorage.app',
    iosBundleId: 'com.example.mylogin',
  );

}