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
    apiKey: 'AIzaSyDr0P2ghMHLfckIA1KOcisMoFZnBDIVLbY',
    appId: '1:244654474858:web:41ccdcb97e6186d1142c13',
    messagingSenderId: '244654474858',
    projectId: 'smart-parking-app-68bcf',
    authDomain: 'smart-parking-app-68bcf.firebaseapp.com',
    storageBucket: 'smart-parking-app-68bcf.appspot.com',
    measurementId: 'G-YNTJ0YVTRH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBx1P3As-JvI4YI0zAM-JAtevIJ_S3_ALs',
    appId: '1:244654474858:android:bd2d41b4b627d350142c13',
    messagingSenderId: '244654474858',
    projectId: 'smart-parking-app-68bcf',
    storageBucket: 'smart-parking-app-68bcf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfNRbLXKWTAKPOUUehi6HznY1BUlVBZvg',
    appId: '1:244654474858:ios:db4bb0a91de1ebf0142c13',
    messagingSenderId: '244654474858',
    projectId: 'smart-parking-app-68bcf',
    storageBucket: 'smart-parking-app-68bcf.appspot.com',
    iosClientId: '244654474858-u5p1euta84qna09cvhunmet5p116eq92.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileApp',
  );
}
