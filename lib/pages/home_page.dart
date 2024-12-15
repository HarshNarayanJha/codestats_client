import 'package:flutter/material.dart';
import 'package:codestats_client/models/user_stats.dart';
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
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 30),

              Text("Languages you speak!", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  LanguageStatsCard(stats: LanguageDetails(name: 'Python', xps: 70061, newXps: 5240)),
                  LanguageStatsCard(stats: LanguageDetails(name: 'JavaScript', xps: 45230, newXps: 2150)),
                  LanguageStatsCard(stats: LanguageDetails(name: 'Java', xps: 38750, newXps: 1890)),
                  LanguageStatsCard(stats: LanguageDetails(name: 'C++', xps: 25480, newXps: 980)),
                  LanguageStatsCard(stats: LanguageDetails(name: 'Dart', xps: 18940, newXps: 2340)),
                  LanguageStatsCard(stats: LanguageDetails(name: 'Ruby', xps: 15670, newXps: 780)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
