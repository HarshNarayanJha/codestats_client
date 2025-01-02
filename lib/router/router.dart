import 'package:codestats_client/layout/layout_scaffold.dart';
import 'package:codestats_client/pages/home_page.dart';
import 'package:codestats_client/pages/languages_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _sectionNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'section');

class Routes {
  Routes._();

  static const String homePage = "/home";
  static const String languagesPage = "/languages";
  static const String machinesPage = "/machines";
  static const String subSettingsPage = "settings";
  static const String settingsPage = "/home/settings";
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.homePage,

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell
      ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
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
              routes: [
                GoRoute(
                  name: 'settings',
                  path: Routes.subSettingsPage,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const Placeholder(),
                    );
                  },
                ),
              ]
            ),
          ],
        ),
        StatefulShellBranch(
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
          routes: [
            GoRoute(
              name: 'machines',
              path: Routes.machinesPage,
              pageBuilder: (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: const Placeholder(),
                );
              },
            ),
          ]
        ),
      ]
    )
  ]
);
