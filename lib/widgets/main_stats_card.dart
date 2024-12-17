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
                      value: stats.getLevelProgress() / 100.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                      backgroundColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8),
                      minHeight: 20.0
                    ),
                    LinearProgressIndicator(
                      // value: levelProgress(stats.totalXp - stats.newXp) / 100.0,
                      value: (
                        levelProgress(
                          (stats.totalXp - stats.newXp)
                          .clamp(xpToNextLevel(stats.getLevel() - 1), xpToNextLevel(stats.getLevel()))
                        )
                      ) / 100.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      minHeight: 20.0
                    ),
                    Text('${stats.getLevelProgress()} %', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                    // Text('${xpToNextLevel(stats.getLevel() - 1)} %', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                    // Text('${stats.totalXp - xpToNextLevel(stats.getLevel() - 1)} %', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                  ],
                ),

                SizedBox(height: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User Since: Oct 17, 2024", style: TextStyle(color: Colors.grey.shade400)),
                    Text("Last programmed on: Dec 12, 2024", style: TextStyle(color: Colors.grey.shade400)),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }

}
