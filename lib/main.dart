import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/router/router.dart';
import 'package:codestats_client/theme/theme.dart';
import 'package:codestats_client/theme/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    await findSystemLocale();
    await initializeDateFormatting();
  } catch (e) {
    debugPrint('Failed to initialize locale: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StatsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
      ],
      child: const CodeStatsApp(),
    ),
  );
}

class CodeStatsApp extends StatelessWidget {
  const CodeStatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    var themeMode = ThemeMode.system;

    if (settings.settings?.darkMode == 0) {
      themeMode = ThemeMode.light;
    } else if (settings.settings?.darkMode == 1) {
      themeMode = ThemeMode.system;
    } else if (settings.settings?.darkMode == 2) {
      themeMode = ThemeMode.dark;
    }

    TextTheme textTheme = createTextTheme(context, "JetBrains Mono", "Nunito");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: 'Code::Stats',
      themeAnimationDuration: Duration(milliseconds: 50),
      themeAnimationCurve: Curves.decelerate,
      themeMode: themeMode,
      theme: theme.light(),
      darkTheme: theme.dark(),
      routerConfig: router
    );
  }
}
