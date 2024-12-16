import 'package:codestats_client/providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codestats_client/services/stats_service.dart';
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

  _fetchStats() async {
    String user = "harshnj";
    try {
      final stats = await _statsService.getStats(user);

      if (!mounted) {
        return;
      }
      context.read<StatsProvider>().setStats(stats);

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
                Text(
                  "Welcome ${context.watch<StatsProvider>().stats?.user ?? 'user'}!",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 30),
                MainStatsCard(
                  stats: context.watch<StatsProvider>().stats ?? UserStats.sample()
                ),
                SizedBox(height: 30),

                Text(
                  "Languages you speak!",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // crossAxisCount: MediaQuery.of(context).size.width ~/ 300,
                  // childAspectRatio: 1,
                  // crossAxisSpacing: 5,
                  // mainAxisSpacing: 5,
                  children: context.watch<StatsProvider>().stats?.languageXp.languages.entries.map((entry) {
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
