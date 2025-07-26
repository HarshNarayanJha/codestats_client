import 'dart:developer';

import 'package:codestats_client/models/user_settings.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/services/stats_service.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

/// Provides user stats data and notifies listeners of changes
class StatsProvider extends ChangeNotifier {
  /// Current user stats, may be null if not yet loaded
  UserStats? _stats;

  /// Creates a new StatsProvider with optional initial stats
  StatsProvider({UserStats? stats}) : _stats = stats;

  /// Gets the current user stats
  UserStats? get stats => _stats;

  final _statsService = StatsService();

  final String dataKey = 'stats_widget_data';

  /// Updates the user stats and notifies listeners
  void setStats(UserStats newStats) {
    _stats = newStats;
    notifyListeners();
  }

  Future<UserStats?> fetchStats(UserSettings userSettings) async {
    String user = userSettings.username;

    try {
      final stats = await _statsService.getStats(user);
      setStats(stats);

      return stats;
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
