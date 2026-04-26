import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_keys.dart';

@singleton
class SessionService {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // ----------------- Onboarding -----------------

  Future<bool> get hasOnboarding async {
    final prefs = await _prefs;
    return prefs.getBool(StorageKeys.hasOnboarding) ?? false;
  }

  Future<void> saveOnboarding(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(StorageKeys.hasOnboarding, value);
  }

  // ----------------- App Theme -----------------

  Future<String> get themeMode async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.themeMode) ?? 'light';
  }

  Future<void> saveThemeMode(String value) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.themeMode, value);
  }

  Future<void> saveUserId(String value) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.userId, value);
  }

  Future<String> get userId async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.userId) ?? '';
  }

  // ----------------- Token & Session -----------------

  Future<String> get token async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.token) ?? '';
  }

  Future<void> saveToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.token, token);
  }

  Future<void> removeToken() async {
    final prefs = await _prefs;
    await prefs.remove(StorageKeys.token);
  }

  Future<bool> get hasSession async {
    final prefs = await _prefs;
    final token = prefs.getString(StorageKeys.token) ?? '';
    return token.isNotEmpty;
  }

  // ----------------- Clear All -----------------

  Future<void> clearSession() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  // save and get user role

  Future<String> get userRole async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.userRoleKey) ?? 'user';
  }

  Future<void> saveUserRole(String value) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.userRoleKey, value);
  }
}
