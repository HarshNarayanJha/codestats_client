import 'package:codestats_client/services/stats_service.dart';
import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/widgets/main_stats_card.dart';
import 'package:codestats_client/widgets/language_stats_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _statsService = StatsService();
  UserStats? _stats;

  _fetchStats() async {
    String user = "harshnj";

    try {
      final stats = await _statsService.getStats(user);
      setState(() {
        _stats = stats;
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.sca,
        title: Text("Code::Stats", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _fetchStats();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Welcome ${_stats?.user ?? 'User#12344'}!", style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),

                SizedBox(height: 30),
                MainStatsCard(
                  stats: _stats ?? UserStats.sample()
                ),
                SizedBox(height: 30),

                Text("Languages you speak!", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: _stats?.languageXp.languages.entries.map((entry) {
                    return LanguageStatsCard(stats: entry.value);
                  }).toList() ?? [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
