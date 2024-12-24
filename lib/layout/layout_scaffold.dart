import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    required this.navigationShell,
    super.key
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: navigationShell.goBranch,
      destinations: [
        NavigationDestination(icon: Icon(Icons.home_rounded), label: "Home"),
        NavigationDestination(icon: Icon(Icons.code_rounded), label: "Languages"),
        NavigationDestination(icon: Icon(Icons.laptop_rounded), label: "Machines"),
      ],
    ),
  );
}
