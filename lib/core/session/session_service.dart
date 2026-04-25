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

  // ----------------- Vendor Status -----------------

  Future<String> get hasVendorStatus async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.vendorStatusKey) ?? 'pending';
  }

  Future<void> saveVendorStatus(String value) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.vendorStatusKey, value);
  }

  // ----------------- Premium -----------------

  Future<bool> get hasPremium async {
    final prefs = await _prefs;
    return prefs.getBool(StorageKeys.premiumKey) ?? false;
  }

  Future<void> savePremium(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(StorageKeys.premiumKey, value);
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

  // ----------------- Phone & Password -----------------

  Future<String> get getPhoneNumber async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.phoneNumber) ?? '';
  }

  Future<void> savePhoneNumber(String value) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.phoneNumber, value);
  }

  Future<String> get getPassword async {
    final prefs = await _prefs;
    return prefs.getString(StorageKeys.password) ?? '';
  }

  Future<void> savePassword(String value) async {
    final prefs = await _prefs;
    await prefs.setString(StorageKeys.password, value);
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
