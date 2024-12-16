import 'package:codestats_client/models/user_stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsService {
  // ignore: constant_identifier_names
  static const BASE_URL = "https://codestats.net/api/users";

  StatsService();

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
