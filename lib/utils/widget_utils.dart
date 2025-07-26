import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/widgets/language_stats_card.dart';
import 'package:codestats_client/widgets/main_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WidgetUtils {
  WidgetUtils._();

  static const String appGroupId = "group.codeStats.statsWidget";
  static const String androidWidgetName = "StatsWidget";
  static const String iOSWidgetName = "StatsWidget";
  static const String usernameDataKey = "username";
  static const String leveltextDataKey = "level_text";
  static const String currentXpDataKey = "current_xp";
  static const String lang1DataKey = "lang1";
  static const String lang2DataKey = "lang2";
  static const String lang3DataKey = "lang3";
  static const String xpToNextDataKey = "xp_to_next";
  static const String lastProgrammedDataKey = "last_programmed";
  static const String progressImageDataKey = "progress_filename";

  static void updateStatsWidget(UserStats stats) {
    final topLangauages = stats.languageXp.getTopLanguages(top: 3);

    HomeWidget.saveWidgetData<String>(usernameDataKey, stats.user);
    HomeWidget.saveWidgetData<String>(leveltextDataKey, 'Level ${stats.getLevel()}');
    HomeWidget.saveWidgetData<String>(currentXpDataKey, '${stats.getTotalXpF()} XP (+ ${stats.getNewXpF()} XP)');
    HomeWidget.saveWidgetData<String>(lang1DataKey, topLangauages.keys.elementAt(0));
    HomeWidget.saveWidgetData<String>(lang2DataKey, topLangauages.keys.elementAt(1));
    HomeWidget.saveWidgetData<String>(lang3DataKey, topLangauages.keys.elementAt(2));
    HomeWidget.saveWidgetData<String>(xpToNextDataKey, '${stats.getXpToNextLevelF()} XP to next level');
    HomeWidget.saveWidgetData<String>(lastProgrammedDataKey, 'Last programmed on: ${stats.getLastProgrammedF()}');

    // save the progress image
    HomeWidget.renderFlutterWidget(MainCardProgress(stats: stats),
        key: progressImageDataKey, logicalSize: const Size(400, 400));

    HomeWidget.updateWidget(iOSName: iOSWidgetName, androidName: androidWidgetName);

    print("Successfully updated the widget Data!");
  }
}

class MainCardProgress extends StatelessWidget {
  const MainCardProgress({super.key, required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          percent: (levelProgress((stats.totalXp - stats.newXp)
                  .clamp(xpToNextLevel(stats.getLevel() - 1), xpToNextLevel(stats.getLevel())))) /
              100.0,
          progressColor: Colors.lightGreen,
          backgroundColor: Colors.transparent,
          barRadius: Radius.circular(8),
          lineHeight: 20.0,
          animation: true,
          center: Text(stats.getLevelProgressF(),
              style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
