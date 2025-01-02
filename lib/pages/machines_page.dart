import 'dart:developer';

import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/router/router.dart';
import 'package:codestats_client/services/stats_service.dart';
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
            onPressed: () => context.push(Routes.settingsPage),
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
