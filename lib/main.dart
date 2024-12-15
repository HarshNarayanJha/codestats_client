import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:codestats_client/pages/home_page.dart';

void main() {
  runApp(const CodeStatsApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'name',
      path: '/',
      builder: (context, state) => HomePage()
    ),
  ]
);

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
      routerConfig: _router
    );
  }
}
