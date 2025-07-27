import 'package:codestats_client/models/user_settings.dart';
import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  static const keyDarkMode = "dark_mode";
  static const keyUsername = "username";
  static const keyOnboardingCompleted = "onboarding_completed";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? darkMode;
  String? username;
  bool? onBoardingCompleted;

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: SegmentedButton<int>(
              segments: [
                ButtonSegment(
                    value: 0, icon: Icon(Icons.light_mode) //, color: Theme.of(context).primaryIconTheme.color),
                    ),
                ButtonSegment(
                    value: 1, icon: Icon(Icons.smartphone) //, color: Theme.of(context).primaryIconTheme.color),
                    ),
                ButtonSegment(
                    value: 2, icon: Icon(Icons.dark_mode) //, color: Theme.of(context).primaryIconTheme.color),
                    ),
              ],
              showSelectedIcon: false,
              selected: {darkMode ?? 1},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  darkMode = newSelection.first;
                });
                saveSettings();
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Username'),
            subtitle: const Text('Your Code::Stats username'),
            trailing: SizedBox(
              width: 125,
              child: TextField(
                  autocorrect: false,
                  controller: _usernameController,
                  onSubmitted: (value) {
                    username = value;
                    saveSettings();
                  }),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Code::Stats'),
            subtitle: const Text('Visit Code::Stats website'),
            onTap: () => launchUrl(Uri.parse('https://codestats.net')),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('GitHub Repository'),
            subtitle: const Text('View source code'),
            onTap: () => launchUrl(Uri.parse('https://github.com/HarshNarayanJha/codestats_client')),
          ),
          AboutListTile(
            icon: const Icon(Icons.info),
            applicationVersion: "1.0.0-beta2",
            applicationName: "Code::Stats Client",
            applicationIcon: const Icon(Icons.bar_chart),
            applicationLegalese: "© 2025 Harsh Narayan Jha",
            aboutBoxChildren: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('A mobile client for Code::Stats written in Flutter'),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.restart_alt_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text("Reset onboarding",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                )),
            onTap: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => ResetOnboardingAlertDialog(onReset: resetOnboarding),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    loadSettings();
    super.initState();
  }

  Future<void> resetOnboarding() async {
    await context.read<SettingsProvider>().resetOnboarding();
    if (mounted) {
      context.go(Routes.homePage);
    }
  }

  Future<void> loadSettings() async {
    final settings = await context.read<SettingsProvider>().loadSettings();
    setState(() {
      darkMode = settings.darkMode;
      username = settings.username;
      onBoardingCompleted = settings.onBoardingCompleted;
    });

    _usernameController.text = username ?? '';
  }

  Future<void> saveSettings() async {
    final settings = await context
        .read<SettingsProvider>()
        .setSettings(UserSettings(darkMode: darkMode!, username: username!, onBoardingCompleted: onBoardingCompleted!));

    if (mounted) {
      await context.read<StatsProvider>().fetchStats(settings);
    }
  }
}

class ResetOnboardingAlertDialog extends StatelessWidget {
  final VoidCallback onReset;

  const ResetOnboardingAlertDialog({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Clear saved data?"),
      icon: Icon(Icons.delete),
      content: Text(
          "All your data will be deleted from this device. Your stats on the code-stats.net server will NOT be deleted."),
      actions: [
        TextButton(
          onPressed: onReset,
          child: Text(
            'Clear',
            style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('No'),
        )
      ],
    );
  }
}
