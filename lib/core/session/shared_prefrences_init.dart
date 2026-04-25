import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInit {
  SharedPreferencesInit._();

  factory SharedPreferencesInit() {
    _instance ??= SharedPreferencesInit._();
    return _instance!;
  }
  static SharedPreferencesInit? _instance;
  SharedPreferences? _sharedPreferences;

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get sharedPreferences {
    return _sharedPreferences!;
  }
}
