import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';

class LanguageStatsCard extends StatelessWidget {
  const LanguageStatsCard({super.key, required this.stats});

  final LanguageDetails stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.amber,
      elevation: 6.0,
      // shadowColor: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(stats.name, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600)),
                  Text(stats.level().toString(), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500)),
                  Text(stats.xps.toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
                ]
              ),
            ],
          ),
      ),
    );
  }

}
