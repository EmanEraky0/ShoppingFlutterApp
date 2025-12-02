import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopping_flutter_app/core/widgets/custom_dialogs.dart';

class NotificationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static String? deviceToken;

  // Call this from main.dart
  static Future<void> initialize() async {
    await _initLocalNotifications();
    await setupFCM();
  }


  // 1️⃣ Local notifications setup (Android + iOS)
  // --------------------------------------------------------
  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        print("User tapped on a notification: ${response.payload}");
      },
    );

    // Android channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel_id',
      'High Importance Notifications',
      description: 'This channel is used for critical notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }


  // 2️⃣ Firebase Messaging Setup
  // --------------------------------------------------------
  static Future<void> setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions (iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("iOS Permission: ${settings.authorizationStatus}");

    // Get token
    deviceToken = await messaging.getToken();
    print("FCM Token: $deviceToken");

    // --------------------------------------------------------
    // Foreground notifications
    // --------------------------------------------------------
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null) {
         // this for to show two status
        // ✔ Android notification in status bar
        // ✔ Popup dialog inside app
        _showLocalNotification(notification);
        showCustomDialog(navigatorKey.currentContext!,notification.title!, notification.body!);
      }

      print("Foreground message: ${notification?.title}");
    });

    // --------------------------------------------------------
    // When tapping notification and app is in background
    // --------------------------------------------------------
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification opened app: ${message.data}");
    });

    // --------------------------------------------------------
    // When app is opened from terminated state
    // --------------------------------------------------------
    RemoteMessage? initialMsg = await messaging.getInitialMessage();
    if (initialMsg != null) {
      print("Opened from terminated state: ${initialMsg.data}");
    }
  }
  // --------------------------------------------------------
  // 3️⃣ Show local notification (Foreground only)
  // --------------------------------------------------------
  static void _showLocalNotification(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel_id',
          'High Importance Notifications',
          channelDescription: 'Used for important notifications.',
          priority: Priority.high,
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }





  static void _showDialog(String title, String body) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
