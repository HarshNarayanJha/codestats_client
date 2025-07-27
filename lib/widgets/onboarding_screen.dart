import 'dart:developer';

import 'package:codestats_client/models/user_settings.dart';
import 'package:codestats_client/models/user_stats.dart';
import 'package:codestats_client/providers/settings_provider.dart';
import 'package:codestats_client/providers/stats_provider.dart';
import 'package:codestats_client/widgets/language_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onDone;

  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _usernameFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  int _darkMode = 1;
  String _username = "";

  UserStats _stats = UserStats.sample();

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFormKey.currentState?.dispose();
    _introKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      resizeToAvoidBottomInset: true,
      freeze: true,
      animationDuration: 250,
      pages: [
        PageViewModel(
          titleWidget: Text(
            "Welcome to Code::Stats",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Column(
            spacing: 36.0,
            children: [
              Text(
                "Track and visualize your coding activity.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              FilledButton(
                onPressed: () {
                  _introKey.currentState?.next();
                },
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                        RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(8.0)))),
                child: const Text("Get Started"),
              ),
            ],
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          scrollViewKeyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          titleWidget: Text(
            "Enter your Code::Stats username",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Column(
            spacing: 48.0,
            children: [
              Text(
                "Please tell us the username you used to sign up for Code::Stats.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Form(
                  key: _usernameFormKey,
                  child: Column(
                    spacing: 16.0,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        enableInteractiveSelection: true,
                        selectionControls: materialTextSelectionControls,
                        decoration: InputDecoration(
                            labelText: "Username", icon: Icon(Icons.person_rounded), border: OutlineInputBorder()),
                        maxLines: 1,
                        minLines: 1,
                        onSaved: (value) {
                          log("Saved $value");
                          _username = value?.trim() ?? "";
                        },
                        onChanged: (value) {
                          setState(() {
                            _username = value.trim();
                          });
                        },
                        validator: (value) {
                          log("Validate ${value.toString()}");
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a valid username";
                          }
                          return null;
                        },
                      ),
                      FilledButton(
                        onPressed: submitUsername,
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(8.0)))),
                        child: const Text("This is my username"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: "Welcome $_username!",
          bodyWidget: Column(
            spacing: 32.0,
            children: [
              Text(
                "Choose a theme",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SegmentedButton<int>(
                segments: [
                  ButtonSegment(
                      value: 0,
                      icon: Icon(Icons.light_mode),
                      label: Text("Light", style: Theme.of(context).textTheme.labelSmall)),
                  ButtonSegment(
                      value: 1,
                      icon: Icon(Icons.smartphone),
                      label: Text("System", style: Theme.of(context).textTheme.labelSmall)),
                  ButtonSegment(
                      value: 2,
                      icon: Icon(Icons.dark_mode),
                      label: Text("Dark", style: Theme.of(context).textTheme.labelSmall)),
                ],
                showSelectedIcon: false,
                selected: {_darkMode},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _darkMode = newSelection.first;
                  });

                  saveSettings();
                },
              ),
              LanguageStatsCard(stats: _stats.languageXp.getLanguageByIndex(0))
            ],
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        )
      ],
      onDone: widget.onDone,
      showSkipButton: false,
      showBackButton: false,
      showNextButton: false,
      // back: const Icon(Icons.arrow_back_rounded),
      // next: const Icon(Icons.arrow_forward_rounded),
      done: Text("Done", style: Theme.of(context).textTheme.labelLarge),
      doneStyle: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).colorScheme.tertiary,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Future<bool> checkUsername(String username) async {
    // try to fetch the stats
    log("Trying to check for username");
    try {
      final fetchedStats = await context
          .read<StatsProvider>()
          .fetchStats(UserSettings(darkMode: 1, username: username, onBoardingCompleted: false));
      if (fetchedStats != null && fetchedStats.languageXp.languages.isNotEmpty) {
        _stats = fetchedStats;
      }
    } catch (e) {
      // exception, probably 404, will check, return false
      log("username was not found");
      return false;
    }

    log("username is valid");
    return true;
  }

  Future<void> submitUsername() async {
    if (_usernameFormKey.currentState?.validate() ?? false) {
      _usernameFormKey.currentState!.save();

      if (await checkUsername(_username)) {
        saveSettings();
        _introKey.currentState?.next();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Username not found",
                style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              action: SnackBarAction(
                  label: "Clear",
                  textColor: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    _usernameFormKey.currentState?.reset();
                    _usernameController.clear();
                    _username = "";
                  }),
            ),
          );
        }
      }
    }
  }

  Future<void> saveSettings() async {
    // onboarding is not yet completed
    await context
        .read<SettingsProvider>()
        .setSettings(UserSettings(darkMode: _darkMode, username: _username, onBoardingCompleted: false));
  }
}
