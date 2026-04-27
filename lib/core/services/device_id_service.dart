import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  static const _storage = FlutterSecureStorage();
  static const _key = "device_id";

  static Future<String> getDeviceId() async {
    String? id = await _storage.read(key: _key);

    if (id != null) {
      return id;
    }

    id = const Uuid().v4();

    await _storage.write(key: _key, value: id);

    return id;
  }
}
