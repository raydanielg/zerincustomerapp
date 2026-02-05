import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCFGqSEiWMItei_AFIUgdM53PWrvyGmjFY",
          appId: "1:76471554747:android:9fb5d198e81cd2b26d0f9e",
          messagingSenderId: "76471554747",
          projectId: "drivevalley-fdb7f",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  }
}