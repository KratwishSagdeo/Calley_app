import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Language preference
  Future<void> saveLanguageCode(String languageCode) async {
    await _prefs.setString('language_code', languageCode);
  }

  String getLanguageCode() {
    return _prefs.getString('language_code') ?? 'en';
  }

  // First launch flag
  Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await _prefs.setBool('first_launch', isFirstLaunch);
  }

  bool isFirstLaunch() {
    return _prefs.getBool('first_launch') ?? true;
  }

  // Onboarding completed
  Future<void> setOnboardingCompleted(bool completed) async {
    await _prefs.setBool('onboarding_completed', completed);
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool('onboarding_completed') ?? false;
  }

  // Theme preference
  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool('dark_mode', isDark);
  }

  bool isDarkMode() {
    return _prefs.getBool('dark_mode') ?? false;
  }

  // Notification settings
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool('notifications_enabled', enabled);
  }

  bool isNotificationsEnabled() {
    return _prefs.getBool('notifications_enabled') ?? true;
  }

  // Call settings
  Future<void> setAutoDialEnabled(bool enabled) async {
    await _prefs.setBool('auto_dial_enabled', enabled);
  }

  bool isAutoDialEnabled() {
    return _prefs.getBool('auto_dial_enabled') ?? false;
  }

  // Clear all preferences
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}