import 'package:codestats_client/layout/layout_scaffold.dart';
import 'package:codestats_client/pages/home_page.dart';
import 'package:codestats_client/pages/languages_page.dart';
import 'package:codestats_client/pages/machines_page.dart';
import 'package:codestats_client/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _languagesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'languages');
final _machinesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'machines');

class Routes {
  Routes._();

  static const String homePage = "/home";
  static const String languagesPage = "/languages";
  static const String machinesPage = "/machines";
  static const String settingsPage = "/settings";
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.homePage,
  debugLogDiagnostics: true,

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell
      ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              name: 'home',
              path: Routes.homePage,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const HomePage(),
                );
              },
              // builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _languagesNavigatorKey,
          routes: [
            GoRoute(
              name: 'languages',
              path: Routes.languagesPage,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const LanguagesPage(),
                );
              },
            ),
          ]
        ),
        StatefulShellBranch(
          navigatorKey: _machinesNavigatorKey,
          routes: [
            GoRoute(
              name: 'machines',
              path: Routes.machinesPage,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const MachinesPage(),
                );
              },
            ),
          ]
        ),
      ]
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'settings',
      path: Routes.settingsPage,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SettingsPage(),
        );
      },
    ),
  ]
);
