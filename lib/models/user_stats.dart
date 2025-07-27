import 'dart:math';

import 'package:intl/intl.dart';

/// The factor used to calculate level progression.
// ignore: constant_identifier_names
const double LEVEL_FACTOR = 0.025;

/// Calculates level for given XP
int level(int xp) {
  if (xp <= 0) {
    return 0;
  }
  return (LEVEL_FACTOR * sqrt(xp.toDouble())).floor();
}

/// Gets XP needed for next level
int xpToNextLevel(int currLevel) {
  if (currLevel < 0) {
    return 0;
  }

  return pow(((currLevel + 1) / LEVEL_FACTOR).ceil(), 2).toInt();
}

/// Gets progress percentage to next level (0-100)
double levelProgress(int xp) {
  if (xp <= 0) {
    return 0;
  }

  var currLevel = level(xp);
  var currLevelXp = xpToNextLevel(currLevel - 1);
  var nextLevelXp = xpToNextLevel(currLevel);

  var haveXp = xp - currLevelXp;
  var neededXp = nextLevelXp - currLevelXp;

  var progress = (haveXp / neededXp * 100).round().toDouble();

  return progress > 100.0 ? 100.0 : progress;
}

/// Class representing experience points data organized by date.
class DateXp {
  /// Map of dates to their corresponding XP values.
  final Map<DateTime, int> dates;

  /// Creates a new DateXp instance.
  DateXp({required this.dates});

  Map<DateTime, int> getHeatmapDates(int year) {
    Map<DateTime, int> result = {};

    dates.forEach((date, value) {
      var normalizedDate = DateTime(year, date.month, date.day);
      result[normalizedDate] = (result[normalizedDate] ?? 0) + value;
    });

    return result;
  }

  /// Returns the first date xp was sent
  DateTime getUserSince() {
    // ignore: no_leading_underscores_for_local_identifiers
    var _dates = dates.keys.toList(growable: false);
    if (dates.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(73474936873);
    }

    _dates.sort((a, b) => a.compareTo(b));
    return _dates.first;
  }

  DateTime getLastProgrammed() {
    // ignore: no_leading_underscores_for_local_identifiers
    var _dates = dates.keys.toList(growable: false);
    if (_dates.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(349759326400);
    }

    _dates.sort((a, b) => a.compareTo(b));
    return _dates.last;
  }

  /// Creates a DateXp instance from JSON data.
  factory DateXp.fromJson(Map<String, dynamic> json) {
    var dates = Map<String, int>.from(json['dates']);
    var datesMap = Map<DateTime, int>.fromEntries(dates.entries.map((e) {
      return MapEntry<DateTime, int>(DateTime.parse(e.key), e.value);
    }));
    return DateXp(
      dates: datesMap,
    );
  }

  /// Converts the DateXp instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, int> dateStrings = {};
    dates.forEach((key, value) {
      dateStrings[key.toIso8601String()] = value;
    });
    return {
      'dates': dateStrings,
    };
  }
}

/// Class representing experience points data organized by programming language.
class LanguageXp {
  /// Map of language identifiers to their corresponding XP details.
  final Map<String, LanguageDetails> languages;

  /// Creates a new LanguageXp instance.
  LanguageXp({required this.languages});

  Map<String, LanguageDetails> getTopLanguages({int top = 5}) {
    var sortedLanguages = Map.fromEntries(languages.entries.toList().take(top));
    return sortedLanguages;
  }

  LanguageDetails getLanguageByIndex(int index) {
    if (index >= languages.length) {
      throw IndexError.withLength(index, languages.keys.length);
    }
    return languages[languages.keys.toList()[index]]!;
  }

  LanguageXp sortLanguagesByXp({bool decreasing = true}) {
    var languagesMap = Map.fromEntries(languages.entries.toList()
      ..sort((a, b) {
        if (decreasing) {
          return b.value.xps.compareTo(a.value.xps);
        } else {
          return a.value.xps.compareTo(b.value.xps);
        }
      }));

    return LanguageXp(languages: languagesMap);
  }

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

  factory LanguageDetails.sample() {
    return LanguageDetails(name: "Python", newXps: 245, xps: 567920);
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

  String getNewXpF() {
    return NumberFormat.decimalPattern().format(newXps);
  }

  String getTotalXpF() {
    return NumberFormat.decimalPattern().format(xps);
  }

  String getXpToNextLevelF() {
    return NumberFormat.decimalPattern().format(getXpToNextLevel());
  }

  String getLevelProgressF() {
    return NumberFormat.percentPattern().format(getLevelProgress() / 100.0);
  }
}

/// Class representing experience points data organized by machine/platform.
class MachineXp {
  /// Map of machine identifiers to their corresponding XP details.
  final Map<String, MachineDetails> machines;

  /// Creates a new MachineXp instance.
  MachineXp({required this.machines});

  Map<String, MachineDetails> getTopMachines({int top = 5}) {
    var sortedMachines = Map.fromEntries(machines.entries.toList().take(top));
    return sortedMachines;
  }

  MachineDetails getMachineByIndex(int index) {
    if (index >= machines.length) {
      throw IndexError.withLength(index, machines.keys.length);
    }
    return machines[machines.keys.toList()[index]]!;
  }

  MachineXp sortMachinesByXp({bool decreasing = true}) {
    var languagesMap = Map.fromEntries(machines.entries.toList()
      ..sort((a, b) {
        if (decreasing) {
          return b.value.xps.compareTo(a.value.xps);
        } else {
          return a.value.xps.compareTo(b.value.xps);
        }
      }));

    return MachineXp(machines: languagesMap);
  }

  /// Creates a MachineXp instance from JSON data.
  factory MachineXp.fromJson(Map<String, dynamic> json) {
    var machinesMap = <String, MachineDetails>{};
    json['machines'].forEach((key, value) {
      machinesMap[key] = MachineDetails.fromJson(value, key);
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
  /// Machine name
  final String name;

  /// The amount of new XP earned in the past 12 hours.
  final int newXps;

  /// The total accumulated XP for this machine.
  final int xps;

  /// Creates a new MachineDetails instance.
  MachineDetails({required this.name, required this.newXps, required this.xps});

  /// Creates a MachineDetails instance from JSON data.
  factory MachineDetails.fromJson(Map<String, dynamic> json, String key) {
    return MachineDetails(
      name: key,
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

  String getNewXpF() {
    return NumberFormat.decimalPattern().format(newXps);
  }

  String getTotalXpF() {
    return NumberFormat.decimalPattern().format(xps);
  }

  String getXpToNextLevelF() {
    return NumberFormat.decimalPattern().format(getXpToNextLevel());
  }

  String getLevelProgressF() {
    return NumberFormat.percentPattern().format(getLevelProgress() / 100.0);
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
      languageXp: LanguageXp.fromJson(json).sortLanguagesByXp(),
      machineXp: MachineXp.fromJson(json),
    );
  }

  factory UserStats.sample() {
    return UserStats(
      totalXp: 232432,
      machineXp: MachineXp(machines: {}),
      user: '',
      newXp: 13858,
      dateXp: DateXp(dates: {}),
      languageXp: LanguageXp(languages: {"Python": LanguageDetails.sample()}),
    );
  }

  factory UserStats.empty() {
    return UserStats(
      totalXp: 0,
      machineXp: MachineXp(machines: {}),
      user: 'defaultuser',
      newXp: 0,
      dateXp: DateXp(dates: {}),
      languageXp: LanguageXp(languages: {}),
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

  String getNewXpF() {
    return NumberFormat.decimalPattern().format(newXp);
  }

  String getTotalXpF() {
    return NumberFormat.decimalPattern().format(totalXp);
  }

  int getLevel() {
    return level(totalXp);
  }

  int getXpToNextLevel() {
    return xpToNextLevel(getLevel());
  }

  String getXpToNextLevelF() {
    return NumberFormat.decimalPattern().format(getXpToNextLevel());
  }

  double getLevelProgress() {
    return levelProgress(totalXp);
  }

  String getLevelProgressF() {
    return NumberFormat.percentPattern().format(getLevelProgress() / 100.0);
  }

  String getUserSinceF() {
    return DateFormat("MMM dd, yyyy").format(dateXp.getUserSince());
  }

  String getLastProgrammedF() {
    return DateFormat("MMM dd, yyyy").format(dateXp.getLastProgrammed());
  }
}
