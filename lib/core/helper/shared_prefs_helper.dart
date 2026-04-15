import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get hasSeenOnboarding =>
      _prefs.getBool('hasSeenOnboarding') ?? false;
  static Future<void> setHasSeenOnboarding(bool value) async =>
      await _prefs.setBool('hasSeenOnboarding', value);

  static bool get isAuthenticated => _prefs.getBool('isAuthenticated') ?? false;
  static Future<void> setIsAuthenticated(bool value) async =>
      await _prefs.setBool('isAuthenticated', value);

  static String? get userRole => _prefs.getString('userRole');
  static Future<void> setUserRole(String role) async =>
      await _prefs.setString('userRole', role);

  static String? get token => _prefs.getString('token');
  static Future<void> setToken(String tokenValue) async =>
      await _prefs.setString('token', tokenValue);

  static Future<void> clearAuth() async {
    await _prefs.remove('isAuthenticated');
    await _prefs.remove('userRole');
    await _prefs.remove('token');
  }
}
