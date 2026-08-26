import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: lightBackground,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: accentColor,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: textDark),
    titleLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: darkBackground,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: navyBlue,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: turquoiseBlue,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: textLight),
    titleLarge: TextStyle(color: textLight, fontWeight: FontWeight.bold),
  ),
);
