import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/utils/language_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LanguageStatsCard extends StatelessWidget {
  const LanguageStatsCard({super.key, required this.stats});

  final LanguageDetails stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<Color>(
        future: getLanguageColor(stats.name, theme.brightness),
        builder: (context, snapshot) {
          return Card(
            color: snapshot.data,
            child: InkWell(
              onTap: () => {},
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
                              child: Text(stats.name,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.w800)),
                            ),
                            SizedBox(height: 5.0),
                            Text('Level ${stats.getLevel()}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            Text(
                                '${stats.getTotalXpF()} XP (+ ${stats.getNewXpF()} XP)',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall),
                            Text(
                                '${stats.getXpToNextLevel() - (stats.xps - xpToNextLevel(stats.getLevel() - 1))} XP to next level',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                              percent: stats.getLevelProgress() / 100.0,
                              progressColor: Colors.orangeAccent,
                              backgroundColor: Colors.blueGrey,
                              radius: 48,
                              lineWidth: 16.0,
                              animation: true,
                            ),
                            CircularPercentIndicator(
                              percent: (levelProgress((stats.xps - stats.newXps)
                                      .clamp(
                                          xpToNextLevel(stats.getLevel() - 1),
                                          xpToNextLevel(stats.getLevel())))) /
                                  100.0,
                              progressColor: Colors.lightGreen,
                              backgroundColor: Colors.transparent,
                              radius: 48,
                              lineWidth: 16.0,
                              animation: true,
                              center: Text(stats.getLevelProgressF(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.bold)),
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
        });
  }
}
