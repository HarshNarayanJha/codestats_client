import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/language_colors.json');
}

Future<Color> getLanguageColor(String language, Brightness theme) async {
  var jsonAsset = await loadAsset();
  Map<String, dynamic> jsonData = json.decode(jsonAsset);
  Map<String, Map<String, String>> languageMap = {};

  jsonData.forEach((key, value) {
    if (value is Map) {
      languageMap[key.toLowerCase()] =
          Map<String, String>.from(value.cast<String, String>());
    }
  });

  var brightnessKey = theme == Brightness.light ? "light_mode" : "dark_mode";
  if (languageMap.containsKey(language.toLowerCase())) {
    return Color(int.parse(languageMap[language.toLowerCase()]![brightnessKey]!
        .replaceFirst('#', '0xff')));
  }

  return Colors.grey;
}
