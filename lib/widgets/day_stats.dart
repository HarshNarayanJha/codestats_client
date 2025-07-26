import 'package:codestats_client/models/user_stats.dart';
import 'package:flutter/material.dart';

class DayStats extends StatelessWidget {
  const DayStats({super.key, required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(spacing: 8.0, children: [
                    Text("Average XP/day", style: Theme.of(context).textTheme.labelLarge),
                    Text("6,710", style: Theme.of(context).textTheme.titleLarge),
                  ]),
                  Column(spacing: 8.0, children: [
                    Text("Most XP", style: Theme.of(context).textTheme.labelLarge),
                    Column(
                      children: [
                        Text("25,625", style: Theme.of(context).textTheme.titleLarge),
                        Text("Dec 11, 2024", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ]),
                  Column(spacing: 8.0, children: [
                    Text("Most Focused", style: Theme.of(context).textTheme.labelLarge),
                    Column(
                      children: [
                        Text("6 h 22 m", style: Theme.of(context).textTheme.titleLarge),
                        Text("Dec 10, 2024", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ]),
                ]),
            // SizedBox(height: 5),
            // Text("Top flows", style: Theme.of(context).textTheme.titleLarge),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Column(
            //       spacing: 8.0,
            //       children: [
            //         Text("Average XP/day", style: Theme.of(context).textTheme.labelLarge),
            //         Text("6,710", style: Theme.of(context).textTheme.titleLarge),
            //       ]
            //     ),
            //     Column(
            //       spacing: 8.0,
            //       children: [
            //         Text("Most XP", style: Theme.of(context).textTheme.labelLarge),
            //         Column(
            //           children: [
            //             Text("25,625", style: Theme.of(context).textTheme.titleLarge),
            //             Text("Dec 11, 2024", style: Theme.of(context).textTheme.bodySmall),
            //           ],
            //         ),
            //       ]
            //     ),
            //     Column(
            //       spacing: 8.0,
            //       children: [
            //         Text("Most Focused", style: Theme.of(context).textTheme.labelLarge),
            //         Column(
            //           children: [
            //             Text("6 h 22 m", style: Theme.of(context).textTheme.titleLarge),
            //             Text("Dec 10, 2024", style: Theme.of(context).textTheme.bodySmall),
            //           ],
            //         ),
            //       ]
            //     ),
            //   ]
            // ),
          ]),
    );
  }
}
