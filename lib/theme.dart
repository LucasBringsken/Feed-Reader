import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xFF767B91);
  static Color primaryAccent = const Color(0xFF2a324b);
  static Color secondaryColor = const Color.fromARGB(255, 174, 178, 192);
  static Color secondaryAccent = const Color(0xFFD4D9E5);
  static Color appBarColor = const Color(0xFF9FA4B6);
  static Color dividerColor = const Color(0x4D38383B);
  static Color textColor = const Color(0xFF2A324B);
}

ThemeData primaryTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  scaffoldBackgroundColor: AppColors.secondaryAccent,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appBarColor,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: AppColors.textColor,
      fontSize: 12,
      letterSpacing: 1,
      fontStyle: FontStyle.italic,
    ),
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 14,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    titleSmall: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    titleMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.secondaryColor.withValues(alpha: 1),
    border: InputBorder.none,
    labelStyle: TextStyle(color: AppColors.textColor),
    prefixIconColor: AppColors.textColor,
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.secondaryAccent,
    surfaceTintColor: Colors.transparent,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.appBarColor,
    foregroundColor: AppColors.textColor,
  ),
);
