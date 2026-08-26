import 'package:flutter/material.dart';
 
/// Paleta de cores centralizada do app.
/// Baseada no design original (tons de azul).
class AppColors {
  AppColors._();
 
  static const Color background = Color(0xFFEFF3F8);
  static const Color cardBackground = Color(0xFFFFFFFF);
 
  // Gradiente do card de saudação
  static const Color heroGradientStart = Color(0xFF223A63);
  static const Color heroGradientEnd = Color(0xFF3E6296);
 
  static const Color primaryBlue = Color(0xFF3E6296);
  static const Color accentBlue = Color(0xFF5B8DEF);
  static const Color lightBlue = Color(0xFFDCE7F7);
 
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
        background: AppColors.background,
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