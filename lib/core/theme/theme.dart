import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class AppTheme {
  // light theme
  static ThemeData appTheme(BuildContext context) => ThemeData(
    fontFamily: 'Rubik',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.softPrimary.withAlpha(123),
    ),
  );

  // dark theme
  static ThemeData darkTheme(BuildContext context) => ThemeData(
    fontFamily: 'Rubik',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor:
        AppColors.scaffoldBackground, // define in AppColors
  );
}
