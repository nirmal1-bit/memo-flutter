class DeviceTokenRequest {
  DeviceTokenRequest({
    required this.deviceId,
    required this.fcmToken,
    required this.platform,
  });

  final String deviceId;
  final String fcmToken;
  final String platform;

  Map<String, dynamic> toJson() => {
    'device_id': deviceId,
    'fcm_token': fcmToken,
    'platform': platform,
  };
}
