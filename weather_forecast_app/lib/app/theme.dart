import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(colorSchemeSeed: Colors.blue);

  static ThemeData get dark =>
      ThemeData(colorSchemeSeed: Colors.blue, brightness: Brightness.dark);
}
