
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


void requestNotificationPermissions(FirebaseMessaging messaging) async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

  void registerNotificationListeners(BuildContext context) {
  // Initialize flutter_local_notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Define the Android notification channel (you'll need to create this)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  // Initialize the plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Replace with your icon
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create the notification channel on Android
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Foreground notification listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a foreground message: ${message.notification?.title}');

    // Display a notification using flutter_local_notifications
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background', // Replace with your notification icon
            ),
          ));
    }
  });

  // App opened from a background message (when the user taps on the notification)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('App opened by notification: ${message.notification?.title}');

    // ... other navigation logic based on message.data
  });
  }

void subscribeToGlobalTopic(FirebaseMessaging messaging) async {
  await messaging.subscribeToTopic('global');
  print('Subscribed to global topic');
}
