import 'package:flutter/material.dart';

abstract class AppColors {
  // PRIMARY THEME
  static const Color primary = Color(0xFF935FA7); // Purple
  static const Color buttonPrimary = Color(0xFF7A4D8C); // Deeper Purple CTA
  static const Color secondary = Color(0xFF2E1A38); // Deep Forest Purple
  static const Color secondary2 = Color(0xFFDDBFE8); // Soft Lavender

  // TIMELINE & SURFACE ACCENTS
  static const memoryAmber = Color(0xFFFFF3E0);
  static const memoryAmberBorder = Color(0xFFFFCC80);
  static const memoryAmberText = Color(0xFF8D4E00);
  static const timelineCall = Color(0xFF935FA7);
  static const timelineMsg = Color(0xFF7A4D8C);
  static const timelineMeet = Color(0xFFB48FC4);
  static const timelineVid = Color(0xFF2E1A38);
  static const timelineMem = Color(0xFFFF8C42);
  static const aiSurfaceBg = Color(0xFFFAF5FF);
  static const aiSurfaceBorder = Color(0xFFD9C4E6);
  static const aiSurfaceText = Color(0xFF5A2D82);
  static const chipGreenBg = Color(0xFFEAF6EE);
  static const chipGreenText = Color(0xFF1A6B40);
  static const chipPurpleBg = Color(0xFFF0EAF6);
  static const chipPurpleText = Color(0xFF5A2D82);
  static const chipOrangeBg = Color(0xFFFFF0E5);
  static const chipOrangeText = Color(0xFFB85C00);
  static const highlightYellow = Color(0xFFFFF9C4);

  // TEXT COLORS
  static const Color textDark = Color(0xFF221429); // Deep Purple Charcoal
  static const Color textLightDark = Color(0xFF5B3F6B);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color textBlue = Color(0xFF935FA7); // legacy alias → primary
  static const Color lightWhite = Color(0xFFF5F5F5);

  // SEMANTIC TEXT
  static const Color textHeading = Color(0xFF221429); // Deep purple charcoal
  static const Color textBody = Color(0xFF5B3F6B); // Muted dark purple-grey
  static const Color textCaption = Color(0xFF8C7499); // Soft purple-grey
  static const Color textOnPrimary = Color(
    0xFFFFFFFF,
  ); // White on purple buttons

  static const Color shadow = Color(0xFFEAE4EE);

  // STATUS COLORS
  static const Color statusRed = Color(0xFFE8385F);
  static const Color statusLightRed = Color(0xFFFDE3EA);
  static const Color statusGreen = Color(0xFF5AAF7A);
  static const Color statusOrange = Color(0xFFFF8C42);

  // BACKGROUNDS
  static const Color scaffoldBackground = Color(0xFFF5F4F7);
  static const Color brandBackground = Color(0xFFF0EAF6); // soft lavender tint
  static const Color brandBackgroundLight = Color(
    0xFFE4D8EF,
  ); // soft lavender border
  static const Color secondaryButtonBackground = Color(0xFFEAEAEA);
  static const Color fabRedBackground = Color(0xFF7A4D8C);

  // ACCENTS
  static const Color accentRose = Color(0xFFB48FC4);

  // BORDERS
  static const Color border = Color(0xFFD9C4E6);
  static const Color dashBorder = Color(0xFFE8D8F2);
  static const Color dividerColor = Color(0xFFEDE3F5);

  static const Color greyColor = Color(0xFFDDDDDD);
  static const Color lightGrey = Color(0xFFF4F4F4);

  // BASICS
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const fadedBlack = Color(0x0D000000);

  // CARDS
  static const Color card = Color(0xFFFFFFFF);

  // SOFT COLORS
  static const Color softPrimary = Color(0xFF6B3F80); // darker purple
  static const Color softBlack = Color(0xFF2E2E2E);
  static const Color softGrey = Color(0xFFE8E8E8);
  static const Color textFieldLabel = Color(0xFFF0F0F0);

  static const Color yellow = Color(0xFFFFC857);

  // DARK MODE
  static const Color darkScaffold = Color(0xFF1F1A22);
  static const Color darkSurface = Color(0xFF2A2230);
  static const Color darkElevatedSurface = Color(0xFF362B3F);
  static const Color darkShadow = Color(0xFF110D16);

  // GRADIENTS
  static const LinearGradient userGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFDDBFE8), // Soft Lavender
      Color(0xFF935FA7), // Primary purple
    ],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [
      Color(0xFF935FA7), // Purple
      Color(0xFF7A4D8C), // Deeper Purple
    ],
  );

  // SHIMMER
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;

  // EXTRA TEXT
  static const Color softTextGrey = Color(0xFF5A5A5A);
  static const Color ironGrey = Color(0xFF8A8A8A);
}
