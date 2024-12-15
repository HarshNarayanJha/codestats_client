import 'dart:math';

import 'package:flutter/material.dart';

Color getLanguageColor(String language) {
  switch (language) {
    case 'Python':
      return Colors.yellow;
    case 'JavaScript':
      return Colors.orange;
    case 'Java':
      return Colors.red;
    case 'C++':
      return Colors.blue;
    case 'C#':
      return Colors.purple;
    case 'Ruby':
      return Colors.pink;
    case 'Go':
      return Colors.cyan;
    case 'Swift':
      return Colors.orange;
    case 'Rust':
      return Colors.brown;
    case 'PHP':
      return Colors.indigo;
    default:
      return Colors.grey;
  }
}

/// The factor used to calculate level progression.
// ignore: constant_identifier_names
const double LEVEL_FACTOR = 0.025;

/// Calculates level for given XP
int level(int xp) => (LEVEL_FACTOR * sqrt(xp.toDouble())).floor();

/// Gets XP needed for next level
int xpToNextLevel(int currLevel) => pow(((currLevel + 1) / LEVEL_FACTOR).ceil(), 2).toInt();

/// Gets progress percentage to next level (0-100)
double levelProgress(int xp) {
  var currLevel = level(xp);
  var currLevelXp = xpToNextLevel(currLevel - 1);
  var nextLevelXp = xpToNextLevel(currLevel);

  var haveXp = (xp) - currLevelXp;
  var neededXp = nextLevelXp - currLevelXp;

  var progress = (haveXp / neededXp * 100).round().toDouble();

  return progress > 100.0 ? 100.0 : progress;
}

/// Class representing experience points data organized by date.
class DateXp {
  /// Map of dates to their corresponding XP values.
  final Map<String, int> dates;

  /// Creates a new DateXp instance.
  DateXp({required this.dates});

  /// Creates a DateXp instance from JSON data.
  factory DateXp.fromJson(Map<String, dynamic> json) {
    return DateXp(
      dates: Map<String, int>.from(json['dates']),
    );
  }

  /// Converts the DateXp instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'dates': dates,
    };
  }
}

/// Class representing experience points data organized by programming language.
class LanguageXp {
  /// Map of language identifiers to their corresponding XP details.
  final Map<String, LanguageDetails> languages;

  /// Creates a new LanguageXp instance.
  LanguageXp({required this.languages});

  /// Creates a LanguageXp instance from JSON data.
  factory LanguageXp.fromJson(Map<String, dynamic> json) {
    var languagesMap = <String, LanguageDetails>{};
    json['languages'].forEach((key, value) {
      languagesMap[key] = LanguageDetails.fromJson(value, key);
    });
    return LanguageXp(languages: languagesMap);
  }

  /// Converts the LanguageXp instance to a JSON map.
  Map<String, dynamic> toJson() {
    var languagesMap = <String, Map<String, dynamic>>{};
    languages.forEach((key, value) {
      languagesMap[key] = value.toJson();
    });
    return {
      'languages': languagesMap,
    };
  }
}

/// Class representing the experience points details for a specific programming language.
class LanguageDetails {

  /// The language name
  final String name;
  /// The amount of new XP earned in the past 12 hours.
  final int newXps;
  /// The total accumulated XP for this language.
  final int xps;

  /// Creates a new LanguageDetails instance.
  LanguageDetails({required this.name, required this.newXps, required this.xps});

  /// Creates a LanguageDetails instance from JSON data.
  factory LanguageDetails.fromJson(Map<String, dynamic> json, String key) {
    return LanguageDetails(
      name: key,
      newXps: json['new_xps'] ?? 0,
      xps: json['xps'] ?? 0,
    );
  }

  /// Converts the LanguageDetails instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'new_xps': newXps,
      'xps': xps,
    };
  }

  int getLevel() {
    return level(xps);
  }

  int getXpToNextLevel() {
    return xpToNextLevel(getLevel());
  }

  double getLevelProgress() {
    return levelProgress(xps);
  }
}

/// Class representing experience points data organized by machine/platform.
class MachineXp {
  /// Map of machine identifiers to their corresponding XP details.
  final Map<String, MachineDetails> machines;

  /// Creates a new MachineXp instance.
  MachineXp({required this.machines});

  /// Creates a MachineXp instance from JSON data.
  factory MachineXp.fromJson(Map<String, dynamic> json) {
    var machinesMap = <String, MachineDetails>{};
    json['machines'].forEach((key, value) {
      machinesMap[key] = MachineDetails.fromJson(value);
    });
    return MachineXp(machines: machinesMap);
  }

  /// Converts the MachineXp instance to a JSON map.
  Map<String, dynamic> toJson() {
    var machinesMap = <String, Map<String, dynamic>>{};
    machines.forEach((key, value) {
      machinesMap[key] = value.toJson();
    });
    return {
      'machines': machinesMap,
    };
  }
}

/// Class representing the experience points details for a specific machine/platform.
class MachineDetails {
  /// The amount of new XP earned in the past 12 hours.
  final int newXps;

  /// The total accumulated XP for this machine.
  final int xps;

  /// Creates a new MachineDetails instance.
  MachineDetails({required this.newXps, required this.xps});

  /// Creates a MachineDetails instance from JSON data.
  factory MachineDetails.fromJson(Map<String, dynamic> json) {
    return MachineDetails(
      newXps: json['new_xps'] ?? 0,
      xps: json['xps'] ?? 0,
    );
  }

  /// Converts the MachineDetails instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'new_xps': newXps,
      'xps': xps,
    };
  }

  int getLevel() {
    return level(xps);
  }

  int getXpToNextLevel() {
    return xpToNextLevel(getLevel());
  }

  double getLevelProgress() {
    return levelProgress(xps);
  }
}

/// A class representing user statistics and experience points (XP).
class UserStats {

  /// The user identifier.
  final String user;

  /// The amount of new XP earned in past 12 hours.
  final int newXp;

  /// The total accumulated XP.
  final int totalXp;

  /// XP data organized by date.
  final DateXp dateXp;

  /// XP data organized by programming language.
  final LanguageXp languageXp;

  /// XP data organized by machine/platform.
  final MachineXp machineXp;

  /// Creates a new UserStats instance.
  UserStats({
    required this.user,
    required this.newXp,
    required this.totalXp,
    required this.dateXp,
    required this.languageXp,
    required this.machineXp,
  });

  /// Creates a UserStats instance from JSON data.
  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      user: json['user'],
      newXp: json['new_xp'],
      totalXp: json['total_xp'],
      dateXp: DateXp.fromJson(json),
      languageXp: LanguageXp.fromJson(json),
      machineXp: MachineXp.fromJson(json),
    );
  }

  /// Converts the UserStats instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'new_xp': newXp,
      'total_xp': totalXp,
      ...dateXp.toJson(),
      ...languageXp.toJson(),
      ...machineXp.toJson(),
    };
  }

  int getLevel() {
    return level(totalXp);
  }

  int getXpToNextLevel() {
    return xpToNextLevel(getLevel());
  }

  double getLevelProgress() {
    return levelProgress(totalXp);
  }
}
