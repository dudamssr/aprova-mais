import 'package:flutter/material.dart';
import 'colors.dart';

class AppColors {
  AppColors._();

  static const Color background = paleBlue;
  static const Color cardBackground = Colors.white;

  static const Color heroGradientStart = navyBlue;
  static const Color heroGradientEnd = cobaltBlue;

  static const Color primaryBlue = cobaltBlue;
  static const Color accentBlue = ceruleanBlue;
  static const Color lightBlue = skyBlue;

  static const Color textDark = Color(0xFF1E2A3A);
  static const Color textMedium = Color(0xFF6B7A90);
  static const Color textLight = Color(0xFFAAB6C6);

  static const Color progressTrack = Color(0xFFE3E9F2);
  static const Color white70 = Color(0xB3FFFFFF);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        surface: AppColors.background,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(color: AppColors.textMedium),
      ),
    );
  }
}
