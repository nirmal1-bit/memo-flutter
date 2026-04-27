import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/services/device_id_service.dart';
import 'package:memo/features/auth/data/models/request/fcm_request.dart';
import 'package:memo/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FCMService {
  FCMService();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  StreamSubscription? _tokenSubscription;

  String getPlatformName() {
    if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    } else {
      return "unknown";
    }
  }

  Future<void> init() async {
    final token = await _messaging.getToken();

    print("FCM Token: $token");

    if (token != null) {
      await sendTokenToBackend(token);
    }

    _tokenSubscription?.cancel();

    _tokenSubscription = _messaging.onTokenRefresh.listen((newToken) async {
      await sendTokenToBackend(newToken);
    });
  }

  Future<void> dispose() async {
    await _tokenSubscription?.cancel();
  }

  Future<void> sendTokenToBackend(String token) async {
    final platform = getPlatformName();

    try {
      final authRepository = getIt<AuthRepository>();
      final response = await authRepository.sendToken(
        DeviceTokenRequest(
          deviceId: await DeviceIdService.getDeviceId(),
          fcmToken: token,
          platform: platform,
        ),
      );

      response.fold(
        (l) => print('failed to send device token: $l'),
        (r) => print('device token sent successfully'),
      );
    } catch (e, st) {
      print('error sending device token: $e');
      print('$st');
    }
  }
}
