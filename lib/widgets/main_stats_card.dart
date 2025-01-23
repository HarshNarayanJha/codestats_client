import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:codestats_client/models/user_stats.dart';

class MainStatsCard extends StatelessWidget {
  const MainStatsCard({super.key, required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.brown.shade400,
      elevation: 6.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              Row(),
              Text(
                'Level ${stats.getLevel()}',
                style: Theme.of(context).primaryTextTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)
              ),
              Text(
                '${stats.getTotalXpF()} XP (+ ${stats.getNewXpF()} XP)',
                style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400)
              ),
              SizedBox(height: 5.0),

              Stack(
                alignment: Alignment.center,
                children: [
                  LinearPercentIndicator(
                    percent: stats.getLevelProgress() / 100.0,
                    progressColor: Colors.orangeAccent,
                    backgroundColor: Colors.blueGrey,
                    barRadius: Radius.circular(8),
                    lineHeight: 20.0,
                    animation: true,
                  ),
                  LinearPercentIndicator(
                    percent: (
                      levelProgress(
                        (stats.totalXp - stats.newXp)
                        .clamp(xpToNextLevel(stats.getLevel() - 1), xpToNextLevel(stats.getLevel()))
                      )
                    ) / 100.0,
                    progressColor: Colors.lightGreen,
                    backgroundColor: Colors.transparent,
                    barRadius: Radius.circular(8),
                    lineHeight: 20.0,
                    animation: true,
                    center: Text(stats.getLevelProgressF(), style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),

              SizedBox(height: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.0,
                children: [
                  Text(
                    '${stats.getXpToNextLevel() - (stats.totalXp - xpToNextLevel(stats.getLevel() - 1))} XP to next level',
                    style: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400)
                  ),
                  Text("User Since: ${stats.getUserSinceF()}", style: TextStyle(color: Colors.grey.shade400)),
                  Text("Last programmed on: ${stats.getLastProgrammedF()}", style: TextStyle(color: Colors.grey.shade400)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
