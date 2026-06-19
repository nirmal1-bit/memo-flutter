import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  LocationHelper._();

  static Future<Map<String, String>> getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      print('Location permission denied.');
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position.longitude.toString());
      print(position.latitude.toString());
      return {
        'longitude': position.longitude.toString(),
        'latitude': position.latitude.toString(),
      };
    } catch (e) {
      print('Error fetching location: $e');
      return {}; // Return an empty map or null if there's an error
    }
  }
}
