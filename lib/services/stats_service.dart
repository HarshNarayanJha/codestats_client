import 'package:codestats_client/models/user_stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service for interacting with Code::Stats API
class StatsService {
  /// Base URL for the Code::Stats API user endpoints
  // ignore: constant_identifier_names
  static const BASE_URL = "https://codestats.net/api/users";

  /// Creates a new StatsService instance
  StatsService();

  /// Fetches user statistics from the Code::Stats API
  ///
  /// [user] - Username to fetch stats for
  ///
  /// Returns [UserStats] containing the user's coding statistics
  ///
  /// Throws [Exception] if the API request fails
  Future<UserStats> getStats(String user) async {
    final uri = Uri.parse("$BASE_URL/$user");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return UserStats.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user stats');
    }
  }
}
