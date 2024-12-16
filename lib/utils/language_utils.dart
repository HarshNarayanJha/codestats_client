import 'package:flutter/material.dart';

Color getLanguageColor(String language) {
  switch (language) {
    case 'Python':
      return Colors.yellow.shade900;
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
