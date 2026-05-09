import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeviceInfoHelper {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    var deviceIdentity = 'unknown';
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
        deviceIdentity = '${info.device}-${info.id}';
      } else if (Platform.isIOS) {
        final IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
        deviceIdentity = '${info.model}-${info.identifierForVendor}';
      }
    } on PlatformException {
      deviceIdentity = 'unknown';
    }
    return deviceIdentity;
  }

  Future<String> getDeviceName() async {
    String deviceName = '';
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.name;
      }
    } catch (e) {
      print('Error getting device name: $e');
    }
    return deviceName;
  }

  Future<String> getDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token ?? "";
  }

  String getPlatform() {
    if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    } else {
      return "unknown";
    }
  }
}
