import 'dart:developer' as developer;
import 'dart:io';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/services/call_keep_service.dart';

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// background message handler
@pragma('vm:entry-point')
Future<void> onBackgroundMessageReceived(RemoteMessage message) async {
  developer.log(
    'Background message received | id: ${message.messageId}',
    name: 'FCM',
  );

  final CallKeepService callKeepService = CallKeepService();

  if (message.data['type'] == NotificationType.call) {
    callKeepService.showCallKit(message.data);
  }
}

const AndroidNotificationChannel _callNotificationChannel =
    AndroidNotificationChannel(
      'channel_id',
      'Call Notifications',
      description: 'Channel for call and event notifications',
      importance: Importance.high,
    );

abstract class NotificationType {
  static const String call = 'call';
  static const String chat = 'message';
}

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late final CallKeepService _callKeepService;

  Future<void> init() async {
    _callKeepService = CallKeepService();
    _callKeepService.init();

    await _requestPermissions();
    await _firebaseMessaging.subscribeToTopic('all');
    await _configureForegroundPresentationOptions();
    await _initializeLocalNotifications();
    await _registerMessageHandlers();
    await _logFcmToken();
  }

  Future<void> _configureForegroundPresentationOptions() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  //permisssions

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _requestIosPermissions();
    } else {
      await _requestAndroidPermissions();
    }
  }

  Future<void> _requestIosPermissions() async {
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _requestAndroidPermissions() async {
    final androidPlugin = localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final bool isGranted =
        await androidPlugin?.requestNotificationsPermission() ?? false;

    if (isGranted) {
      await androidPlugin?.createNotificationChannel(_callNotificationChannel);
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );

    await localNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    final String? payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    try {
      final Map<String, dynamic> data =
          jsonDecode(payload) as Map<String, dynamic>;
      developer.log('Notification tapped with payload: $data', name: 'FCM');
      // TODO: handle notification tap navigation
    } catch (e) {
      developer.log('Error parsing notification payload: $e', name: 'FCM');
    }
  }

  Future<void> _registerMessageHandlers() async {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageReceived);

    FirebaseMessaging.onMessage.listen(_onForegroundMessageReceived);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    final RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  void _onForegroundMessageReceived(RemoteMessage message) {
    developer.log(
      'Foreground message received | type: ${message.data['type']}',
      name: 'FCM',
    );

    final Map<String, dynamic> data = message.data;
    final RemoteNotification? notification = message.notification;

    switch (data['type']) {
      case NotificationType.call:
        _callKeepService.showCallKit(data);
        break;

      case NotificationType.chat:
        if (notification != null) {
          _showChatNotification(notification);
        }
        break;

      default:
        developer.log(
          'Unhandled notification type: ${data['type']}',
          name: 'FCM',
        );
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    developer.log(
      'App opened from notification | type: ${message.data['type']}',
      name: 'FCM',
    );
    // TODO: handle deep-link / navigation based on message.data
  }

  //display helpers

  void _showChatNotification(RemoteNotification notification) {
    localNotificationsPlugin
        .show(
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              _callNotificationChannel.id,
              _callNotificationChannel.name,
              channelDescription: _callNotificationChannel.description,
              color: AppColors.primary,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          id: notification.hashCode,
        )
        .then((_) => developer.log('Chat notification shown', name: 'FCM'))
        .catchError(
          (Object e) =>
              developer.log('Error showing notification: $e', name: 'FCM'),
        );
  }

  Future<void> _logFcmToken() async {
    final String? token = await _firebaseMessaging.getToken();
    developer.log('FCM Token: $token', name: 'FCM');
  }
}
