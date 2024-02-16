import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'NotoSansKR',
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.yellow,
  ),
);
ThemeData darkMode = ThemeData(
  fontFamily: 'NotoSansKR',
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade800,
  ),
);
