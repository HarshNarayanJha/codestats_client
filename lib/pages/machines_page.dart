import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/router/router.dart';
import 'package:codestats_client/widgets/code_stats_app_bar.dart';
import 'package:codestats_client/widgets/machines_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MachinesPage extends StatefulWidget {
  const MachinesPage({super.key});

  @override
  State<MachinesPage> createState() => _MachinesPageState();
}

class _MachinesPageState extends State<MachinesPage> {

  _fetchStats() async {
    if (context.mounted) {
      final statsProvider = Provider.of<StatsProvider>(context, listen: false);
      if (statsProvider.stats != null) {
        return;
      }

      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
      var settings = await settingsProvider.loadSettings();
      await statsProvider.fetchStats(settings);
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
          icon: const Icon(Icons.settings_rounded),
          tooltip: "Settings",
          onPressed: () => context.push(Routes.settingsPage),
        )
      ]),
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
          child: stats == null ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.0,
                children: [
                  Text("My Machines", style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: stats.machineXp.machines.length,
                    itemBuilder: (context, index) {
                      return MachinesStatsCard(
                        stats: stats.machineXp.getMachineByIndex(index),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        )
      )
    );
  }
}
