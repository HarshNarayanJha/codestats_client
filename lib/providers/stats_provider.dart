import 'package:codestats_client/models/user_stats.dart';
import 'package:flutter/material.dart';

/// Provides user stats data and notifies listeners of changes
class StatsProvider extends ChangeNotifier {
  /// Current user stats, may be null if not yet loaded
  UserStats? _stats;

  /// Creates a new StatsProvider with optional initial stats
  StatsProvider({UserStats? stats}) : _stats = stats;

  /// Gets the current user stats
  UserStats? get stats => _stats;

  /// Updates the user stats and notifies listeners
  void setStats(UserStats newStats) {
    _stats = newStats;
    notifyListeners();
  }
}
