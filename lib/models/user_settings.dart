import 'dart:developer';

import 'package:codestats_client/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  final int darkMode;
  final String username;
  final bool onBoardingCompleted;

  const UserSettings({
    required this.darkMode,
    required this.username,
    required this.onBoardingCompleted,
  });

  static Future<UserSettings> load() async {
    log("Loading Settings");
    final prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getInt(SettingsPage.keyDarkMode) ?? 1;
    var username = prefs.getString(SettingsPage.keyUsername) ?? '';
    var onBoardingCompleted = prefs.getBool(SettingsPage.keyOnboardingCompleted) ?? false;

    return UserSettings(darkMode: darkMode, username: username, onBoardingCompleted: onBoardingCompleted);
  }

  static Future<UserSettings> save(int darkMode, String username, bool onBoardingCompleted) async {
    log("Saving Settings");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SettingsPage.keyDarkMode, darkMode);
    await prefs.setString(SettingsPage.keyUsername, username);
    await prefs.setBool(SettingsPage.keyOnboardingCompleted, onBoardingCompleted);

    return UserSettings(darkMode: darkMode, username: username, onBoardingCompleted: onBoardingCompleted);
  }

  static Future<bool> clear() async {
    log("Clearing Settings");
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
