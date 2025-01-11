import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
              segments: const [
                ButtonSegment(
                  value: 0,
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: 1,
                  icon: Icon(Icons.smartphone),
                ),
                ButtonSegment(
                  value: 2,
                  icon: Icon(Icons.dark_mode),
                ),
              ],
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
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
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
    // final prefs = await SharedPreferences.getInstance();
    // darkMode = prefs.getInt(SettingsPage.keyDarkMode);
    // username = prefs.getString(SettingsPage.keyUsername);
  }

  Future<void> saveSettings() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt(SettingsPage.keyDarkMode, darkMode ?? 1);
    // await prefs.setString(SettingsPage.keyUsername, username ?? '');
  }
}
