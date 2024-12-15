import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/widgets/card_widget.dart';
import 'package:codestats_client/widgets/main_stats_card.dart';
import 'package:codestats_client/widgets/language_stats_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.top,
        title: Text("Code::Stats"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Welcome Harsh!", style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            MainStatsCard(
              stats: UserStats(
                totalXp: 229587,
                machineXp: MachineXp(machines: {}),
                user: '',
                newXp: 11013,
                dateXp: DateXp(dates: {}),
                languageXp: LanguageXp(languages: {}),
              )
            ),
          ],
        ),
      ),
    );
  }
}
