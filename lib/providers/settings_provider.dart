import 'dart:developer';

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
  Future<UserSettings> setSettings(UserSettings newSettings) async {
    _settings = await UserSettings.save(newSettings.darkMode, newSettings.username, newSettings.onBoardingCompleted);
    notifyListeners();
    return settings!;
  }

  Future<bool> completeOnboarding() async {
    log("Onboarding completed");
    _settings = await UserSettings.save(_settings!.darkMode, _settings!.username, true);
    notifyListeners();
    return _settings!.onBoardingCompleted;
  }

  Future<bool> resetOnboarding() async {
    log("Onboarding reset");
    if (await UserSettings.clear()) {
      _settings = await UserSettings.load();
    }

    notifyListeners();
    return _settings!.onBoardingCompleted;
  }
}
