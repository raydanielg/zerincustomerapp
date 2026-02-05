import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ride_sharing_user_app/app.dart';
import 'package:ride_sharing_user_app/core/config/firebase_config.dart';
import 'package:ride_sharing_user_app/helper/notification_helper.dart';
// If init() is undefined, verify that di_container.dart actually has a function named 'init'
import 'package:ride_sharing_user_app/helper/di_container.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await FirebaseConfig.initialize();

    // Initialize dependencies (DI)
    // If 'init' is showing red, check di_container.dart for spelling errors
    Map<String, Map<String, String>> languages = await di.init();

    // Get initial notification
    final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    // Setup notifications
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    // Lock orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(MyApp(
      languages: languages,
      notificationData: remoteMessage?.data,
    ));
  } catch (e) {
    debugPrint('❌ Error initializing app: $e');
    runApp(const MaterialApp(home: Scaffold(body: Center(child: Text('Failed to initialize app.')))));
  }
}