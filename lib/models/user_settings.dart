import 'package:codestats_client/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  final int darkMode;
  final String username;

  const UserSettings({
    required this.darkMode,
    required this.username,
  });

  static Future<UserSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getInt(SettingsPage.keyDarkMode) ?? 1;
    var username = prefs.getString(SettingsPage.keyUsername) ?? '';
    return UserSettings(
      darkMode: darkMode,
      username: username,
    );
  }
}
