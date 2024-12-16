import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/utils/language_utils.dart';

class LanguageStatsCard extends StatelessWidget {
  const LanguageStatsCard({super.key, required this.stats});

  final LanguageDetails stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getLanguageColor(stats.name),
      elevation: 6.0,
      // shadowColor: Colors.blueGrey,
      child: InkWell(
        onTap: () => {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                stats.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)
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
              SizedBox(height: 20.0),

              // change to multi progress bar for new xp
              Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: stats.getLevelProgress() / 100.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    backgroundColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 15.0
                  ),
                  LinearProgressIndicator(
                    value: levelProgress(stats.xps - stats.newXps) / 100.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 15.0
                  ),
                  Text(
                    '${stats.getLevelProgress()} %',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
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
