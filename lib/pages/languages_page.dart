import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/responsive/responsive_layout.dart';
import 'package:codestats_client/router/router.dart';
import 'package:codestats_client/widgets/code_stats_app_bar.dart';
import 'package:codestats_client/widgets/language_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  _fetchStats() async {
    if (context.mounted) {
      final statsProvider = Provider.of<StatsProvider>(context, listen: false);
      final settingsProvider =
          Provider.of<SettingsProvider>(context, listen: false);

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
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 16.0,
                            children: [
                              Text("My Languages",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              ResponsiveLayout(
                                desktopBody: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width ~/
                                            300,
                                    childAspectRatio: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: stats.languageXp.languages.length,
                                  itemBuilder: (context, index) {
                                    return LanguageStatsCard(
                                      stats: stats.languageXp
                                          .getLanguageByIndex(index),
                                    );
                                  },
                                ),
                                mobileBody: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: stats.languageXp.languages.length,
                                  itemBuilder: (context, index) {
                                    return LanguageStatsCard(
                                      stats: stats.languageXp
                                          .getLanguageByIndex(index),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))));
  }
}
