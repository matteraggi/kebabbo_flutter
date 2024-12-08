
import 'package:firebase_messaging/firebase_messaging.dart';
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

  void registerNotificationListeners() {
    // Foreground notification listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.notification?.title}');
      // You can show a notification, popup, or update the UI here
    });

    // App opened from a background message (when the user taps on the notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened by notification: ${message.notification?.title}');
      // Handle the redirection or logic when the notification is tapped
    });
  }

void subscribeToGlobalTopic(FirebaseMessaging messaging) async {
  await messaging.subscribeToTopic('global');
  print('Subscribed to global topic');
}

