import 'package:flutter/material.dart';

abstract class AppColors {
  // PRIMARY THEME
  static const Color primary = Color(0xFF087E8B); // Teal
  static const Color buttonPrimary = Color(0xFFFF5A5F); // Coral CTA
  static const Color secondary = Color(0xFF7B4B94); // Teal
  static const Color secondary2 = Color(0xFF020887); // Teal

  // TEXT COLORS
  static const Color textDark = Color(0xFF3C3C3C); // Gunmetal
  static const Color textLightDark = Color(0xFF6E6E6E);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color textBlue = Color(0xFF087E8B); // reuse teal
  static const Color lightWhite = Color(0xFFF5F5F5);

  static const Color shadow = Color(0xFFEAEAEA);

  // STATUS COLORS (aligned with palette)
  static const Color statusRed = Color(0xFFFF5A5F);
  static const Color statusLightRed = Color(0xFFFFE5E6);
  static const Color statusGreen = Color(
    0xFF2FBF71,
  ); // added complementary green
  static const Color statusOrange = Color(0xFFFF8C42); // softer orange

  // BACKGROUNDS
  static const Color scaffoldBackground = Color(0xFFF5F5F5);
  static const Color brandBackground = Color(0xFFEFF7F8); // teal tint
  static const Color brandBackgroundLight = Color(0xFFD6EEF0);
  static const Color secondaryButtonBackground = Color(0xFFEAEAEA);
  static const Color fabRedBackground = Color(0xFFFF5A5F);

  // ACCENTS
  static const Color accentRose = Color(0xFFC1839F);

  // DEFAULT / BORDERS
  static const Color border = Color(0xFFB0B0B0);
  static const Color dashBorder = Color(0xFFD6EEF0);
  static const Color dividerColor = Color(0xFFE0E0E0);

  static const Color greyColor = Color(0xFFDDDDDD);
  static const Color lightGrey = Color(0xFFF4F4F4);

  // BASICS
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const fadedBlack = Color(0x0D000000);

  // CARDS
  static const Color card = Color(0xFFFFFFFF);

  // SOFT COLORS (harmonized)
  static const Color softPrimary = Color(0xFF055F6B); // darker teal
  static const Color softBlack = Color(0xFF2E2E2E);
  static const Color softGrey = Color(0xFFE8E8E8);
  static const Color textFieldLabel = Color(0xFFF0F0F0);

  static const Color yellow = Color(0xFFFFC857); // works well with coral

  // DARK MODE (derived)
  static const Color darkScaffold = Color(0xFF1F1F1F);
  static const Color darkSurface = Color(0xFF2A2A2A);
  static const Color darkElevatedSurface = Color(0xFF333333);
  static const Color darkShadow = Color(0xFF121212);

  // GRADIENTS (updated to match palette)
  static const LinearGradient userGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFC1839F), // Old Rose
      Color(0xFF3C3C3C), // Gunmetal
    ],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [
      Color(0xFF087E8B), // Teal
      Color(0xFFFF5A5F), // Coral
    ],
  );

  // SHIMMER
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;

  // EXTRA TEXT
  static const Color softTextGrey = Color(0xFF5A5A5A);
  static const Color ironGrey = Color(0xFF8A8A8A);
}
