import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/router/router.dart';
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
    ChangeNotifierProvider(
      create: (context) => StatsProvider(),
      child: const CodeStatsApp(),
    )
  );
}

class CodeStatsApp extends StatelessWidget {
  const CodeStatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Code::Stats',
      themeAnimationDuration: Duration(milliseconds: 50),
      themeAnimationCurve: Curves.decelerate,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light, primarySwatch: Colors.blueGrey),
        useMaterial3: true,
      ),
      // TODO: Work on dark mode
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark, primarySwatch: Colors.blueGrey),
        useMaterial3: true,
      ),
      routerConfig: router
    );
  }
}
