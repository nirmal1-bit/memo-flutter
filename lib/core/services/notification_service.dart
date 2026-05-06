import 'dart:developer' as debug;
import 'dart:io';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/services/call_keep_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late CallKeepService _callKeepService;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'channel_id',
  'Call Notifications',
  description: 'Channel for call and event notifications',
  importance: Importance.high,
);

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();

const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsDarwin,
);

class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _requestPermissions();

    await _messaging.subscribeToTopic('all');

    FirebaseMessaging.onMessage.listen(_onMessageReceived);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    _callKeepService = CallKeepService();
    CallKeepService().init();
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        try {
          if (response.payload != null && response.payload!.isNotEmpty) {
            final Map<String, dynamic> data = jsonDecode(response.payload!);
            // _handleDataMessage(data, foreground: false, openedApp: true);
          }
        } catch (e) {
          debug.log('Error parsing notification payload: $e');
        }
      },
    );

    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {}

    final token = await _messaging.getToken();
    debug.log('FCM Token: $token');
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else {
      bool? granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      if (granted ?? false) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.createNotificationChannel(channel);
      }
    }
  }

  void _onMessageReceived(RemoteMessage message) {
    print("Notification: ${message.notification}, Data: ${message.data}");

    final data = message.data;
    final notification = message.notification;
    if (data['type'] == 'call') {
      _callKeepService.showCallKit(data);
      print("The data is $data");
    }
    if (notification != null && data['type'] == 'chat') {
      flutterLocalNotificationsPlugin
          .show(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            notificationDetails: NotificationDetails(
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: AppColors.primary,
              ),
            ),
          )
          .then((_) {
            print("Notification shown successfully"); // add this
          })
          .catchError((e) {
            print("Error showing notification: $e"); // add this
          });
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) async {}

  // void _handleDataMessage(
  //   Map<String, dynamic> data, {
  //   bool foreground = false,
  //   bool openedApp = false,
  // }) {
  //   _callKeepService.showCallKit(data);
  // }

  // void _handleCallDecline(Map<String, dynamic>? body) {
  //   print("Call declined");
  // }
}
