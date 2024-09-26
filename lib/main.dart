import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xilancer/app.dart';

import 'helper/firebase_messaging_helper.dart';
import 'helper/notification_helper.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  await setupFlutterNotifications();
  final messageData = message.data;
  final sPref = await SharedPreferences.getInstance();
  final strings = sPref.getString('translated_string') ?? "{}";
  var translatedString = jsonDecode(strings);
  final id = messageData['id'] is String
      ? int.tryParse(messageData['id'])
      : messageData['id'];

  String title = message.data['title'] ?? "";
  String description = message.data['body'] ?? "";
  String identity = message.data['identity'] ?? "";
  String type = message.data['type'] ?? "name";
  if (type == "Order") {
    title = description;
    description = "${translatedString["Order Id"] ?? "Order Id"}: #$identity";
  }
  if (type == "Withdraw") {
    title = description;
    description = "${translatedString["Id"] ?? "Id"}: #$identity";
  }
  if (type == "message") {
    var liveChatData = jsonDecode(message.data["livechat"] ?? "{}");
    // log(message.data.toString());
    try {
      title = liveChatData["client"]?["first_name"]?.toString() ?? "";

      description =
          jsonDecode(message.data['body'] ?? "{}")?["message"]?.toString() ??
              "";
    } catch (e) {}
  }
  NotificationHelper().triggerNotification(
    id: id,
    body: description,
    title: title,
    payload: message.data,
    channelName: type,
  );
}

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "nav_key");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) {
      staticFunctionOnForeground(NotificationResponse(
        notificationResponseType: NotificationResponseType.selectedNotification,
        id: id,
        payload: payload,
      ));
    },
  );

  flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: const AndroidInitializationSettings('notification_icon'),
      iOS: initializationSettingsDarwin,
    ),
    onDidReceiveBackgroundNotificationResponse: staticFunctionOnForeground,
    onDidReceiveNotificationResponse: staticFunctionOnForeground,
  );
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  // final bool? granted = await androidImplementation?.requestPermission();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  setNotificationDetails(
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails());
  debugPrint((notificationDetails?.notificationResponse?.payload).toString());

  runApp(const XilancerApp());
}
