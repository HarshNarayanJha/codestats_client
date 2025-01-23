import 'package:codestats_client/models/user_settings.dart';
import 'package:flutter/material.dart';

/// Provides user settings and notifies listeners of changes
class SettingsProvider extends ChangeNotifier {

  /// Current user settings
  UserSettings? _settings;

  SettingsProvider() {
    loadSettings();
  }

  Future<UserSettings> loadSettings() async {
    _settings = await UserSettings.load();
    notifyListeners();
    return settings!;
  }

  /// Gets the current user settings
  UserSettings? get settings => _settings;

  /// Updates the user settings and notifies listeners
  void setSettings(UserSettings newSettings) {
    _settings = newSettings;
    notifyListeners();
  }
}
