import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/router/router.dart';
import 'package:codestats_client/widgets/code_stats_app_bar.dart';
import 'package:codestats_client/widgets/day_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
  Future<void> _fetchStats() async {
    if (context.mounted) {
      final statsProvider = Provider.of<StatsProvider>(context, listen: false);
      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

      if (settingsProvider.settings == null) {
        await settingsProvider.loadSettings();
      }

      await statsProvider.fetchStats(settingsProvider.settings!);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>().stats;

    return Scaffold(
      appBar: CodeStatsAppBar(actions: [
        IconButton(
          icon: const Icon(Icons.sync_rounded),
          tooltip: "Sync",
          onPressed: () async {
            await _fetchStats();
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Fetched Latest Stats!"),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
            ));
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          tooltip: "Settings",
          onPressed: () => context.push(Routes.settingsPage),
        )
      ]),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await _fetchStats();
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Fetched Latest Stats!"),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
            ));
          },
          child: stats == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15.0,
                      children: <Widget>[
                        Text(
                          "Welcome ${stats.user}!",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        MainStatsCard(stats: stats),
                        DayStats(stats: stats),
                        Divider(thickness: 0.5),
                        Text(
                          "Languages you speak!",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
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
                                stats: stats.languageXp
                                    .getTopLanguages()[stats.languageXp.getTopLanguages().keys.toList()[index]]!,
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
                        Text(
                          "Your Year in a Glance",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        HeatMap(
                            datasets: stats.dateXp.getHeatmapDates(DateTime.now().year),
                            colorMode: ColorMode.opacity,
                            // startDate: DateTime(DateTime.now().year, 1, 1),
                            endDate: DateTime(DateTime.now().year, 12, 31),
                            colorsets: {
                              0: Colors.lightBlueAccent.shade700,
                            },
                            defaultColor: Colors.grey.shade300,
                            size: 16,
                            margin: EdgeInsets.all(1),
                            borderRadius: 20.0,
                            scrollable: true,
                            showColorTip: false,
                            onClick: (p) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(NumberFormat.compact(explicitSign: false).format(stats.dateXp.dates[p])),
                                showCloseIcon: true,
                              ));
                            })
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
