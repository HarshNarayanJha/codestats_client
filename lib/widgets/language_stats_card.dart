import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/utils/language_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LanguageStatsCard extends StatelessWidget {
  const LanguageStatsCard({super.key, required this.stats});

  final LanguageDetails stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getLanguageColor(stats.name),
      child: InkWell(
        onTap: () => {

        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 5.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.0,
                    children: [
                      FittedBox(
                        child: Text(
                          stats.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Level ${stats.getLevel()}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)
                      ),
                      Text(
                        '${stats.xps.toString()} XP (+ ${stats.newXps.toString()} XP)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400)
                      ),
                      Text(
                        '${stats.getXpToNextLevel() - (stats.xps - xpToNextLevel(stats.getLevel() - 1))} XP to next level',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400)
                      ),
                    ],
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        percent: stats.getLevelProgress() / 100.0,
                        progressColor: Colors.orangeAccent,
                        backgroundColor: Colors.blueGrey,
                        // circularStrokeCap: CircularStrokeCap.round,
                        radius: 48,
                        lineWidth: 16.0,
                        animation: true,
                      ),
                      CircularPercentIndicator(
                        percent: (
                          levelProgress(
                            (stats.xps - stats.newXps)
                            .clamp(xpToNextLevel(stats.getLevel() - 1), xpToNextLevel(stats.getLevel()))
                          )
                        ) / 100.0,
                        progressColor: Colors.lightGreen,
                        backgroundColor: Colors.transparent,
                        // circularStrokeCap: CircularStrokeCap.round,
                        radius: 48,
                        lineWidth: 16.0,
                        animation: true,
                        center: Text('${stats.getLevelProgress().ceil()}%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
