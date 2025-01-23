import 'package:codestats_client/models/user_settings.dart';
import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const keyDarkMode = "dark_mode";
  static const keyUsername = "username";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  int? darkMode;
  String? username;

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
                  value: 0,
                  icon: Icon(Icons.light_mode)//, color: Theme.of(context).primaryIconTheme.color),
                ),
                ButtonSegment(
                  value: 1,
                  icon: Icon(Icons.smartphone)//, color: Theme.of(context).primaryIconTheme.color),
                ),
                ButtonSegment(
                  value: 2,
                  icon: Icon(Icons.dark_mode)//, color: Theme.of(context).primaryIconTheme.color),
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
                }
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy & Security'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AboutListTile(
            icon: const Icon(Icons.info),
            applicationVersion: "v0.0.1",
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

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getInt(SettingsPage.keyDarkMode);
      username = prefs.getString(SettingsPage.keyUsername);
    });

    _usernameController.text = username ?? '';
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SettingsPage.keyDarkMode, darkMode ?? 1);
    await prefs.setString(SettingsPage.keyUsername, username ?? '');

    if (mounted && darkMode != null && username != null) {
      context.read<SettingsProvider>().setSettings(UserSettings(darkMode: darkMode!, username: username!));
      context.read<StatsProvider>().fetchStats(context.read<SettingsProvider>().settings!);
    }
  }
}
