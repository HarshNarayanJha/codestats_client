import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';

class MainStatsCard extends StatelessWidget {
  const MainStatsCard({super.key, required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.brown.shade400,
      elevation: 6.0,
      // shadowColor: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              Row(),
              Text(
                'Level ${stats.level()}',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)
              ),
              Text(
                '${stats.totalXp.toString()} XP (+ ${stats.newXp.toString()} XP)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400)
              ),
              SizedBox(height: 5.0),
              // change to multi progress bar for new xp

              Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: stats.levelProgress() / 100.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    backgroundColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 20.0
                  ),
                  LinearProgressIndicator(
                    value: stats.levelProgress(stats.totalXp - stats.newXp) / 100.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 20.0
                  ),
                  Text('${stats.levelProgress()} %', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
      ),
    );
  }

}
