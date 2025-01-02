import 'dart:developer';

import 'package:codestats_client/router/router.dart';
import 'package:codestats_client/widgets/day_stats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:codestats_client/services/stats_service.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/widgets/main_stats_card.dart';
import 'package:codestats_client/widgets/language_stats_card.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/responsive/responsive_layout.dart';

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
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>().stats ?? UserStats.empty();

    return Scaffold(
      appBar: AppBar(
        title: Text("Code::Stats", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),
        primary: true,
        actions: [
          IconButton(
            icon: Icon(Icons.sync_rounded),
            tooltip: "Sync",
            onPressed: () async {
              await _fetchStats();
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Fetched Latest Stats!"),
                  showCloseIcon: true,
                  behavior: SnackBarBehavior.floating,
                )
              );

            },
          ),
          IconButton(
            icon: Icon(Icons.settings_rounded),
            tooltip: "Settings",
            onPressed: () => context.go(Routes.settingsPage),
          )
        ]
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          color: Colors.blueGrey,
          onRefresh: () async {
            await _fetchStats();
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Fetched Latest Stats!"),
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
              )
            );

          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome ${stats.user}!",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 30),
                  MainStatsCard(
                    stats: stats
                  ),
                  SizedBox(height: 30),

                  DayStats(stats: stats),

                  SizedBox(height: 30),
                  Divider(thickness: 0.5),
                  SizedBox(height: 30),

                  Text(
                    "Languages you speak!",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  ResponsiveLayout(
                    desktopBody: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width ~/ 300,
                        childAspectRatio: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: stats.languageXp.getTopLanguages().length,
                      itemBuilder: (context, index) {
                        return LanguageStatsCard(
                          stats: stats.languageXp.getTopLanguages()[stats.languageXp.getTopLanguages().keys.toList()[index]]!,
                        );
                      },
                    ),
                    mobileBody: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: stats.languageXp.getTopLanguages().length,
                      itemBuilder: (context, index) {
                        return LanguageStatsCard(
                          stats: stats.languageXp.getLanguageByIndex(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
