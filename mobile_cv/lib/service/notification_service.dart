import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationService = Provider<NotificationService>((ref) => NotificationService());

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  AndroidInitializationSettings? initializationSettingsAndroid;

  Future<void> initializeLocalNotifications(Function(String?) onSelectNotification) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin!.initialize(initializationSettings, onSelectNotification: (val) {
      flutterLocalNotificationsPlugin!.cancelAll();
      onSelectNotification(val);
    });
  }

  Future<void> showNotification(int id, String title, String body) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'message_channel', 'Message',
        channelDescription: 'Message', importance: Importance.max, groupKey: "message_group", priority: Priority.high);

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin!.show(id, title, body, platformChannelSpecifics);
  }

  Future<void> createNotificationChannel() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannelGroup androidNotificationChannelGroup =
        AndroidNotificationChannelGroup("message_group", 'Message Group', description: 'Message Group');

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannelGroup(androidNotificationChannelGroup);

    const AndroidNotificationChannel androidPlatformChannelSpecifics = AndroidNotificationChannel(
        'message_channel', 'Message',
        description: 'Message',
        importance: Importance.max,
        enableLights: true,
        ledColor: Colors.green,
        groupId: "message_group",
        sound: RawResourceAndroidNotificationSound('notification'));

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidPlatformChannelSpecifics);
  }
}
