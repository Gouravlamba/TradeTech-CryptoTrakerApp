import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.secondry,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 8,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
    scaffoldBackgroundColor: Color(0xFF575757),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(fontSize: 14),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.primary),
  );

//dark theme
  static final darkTheme = ThemeData();
}
