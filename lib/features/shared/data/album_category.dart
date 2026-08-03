import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

enum AlbumCategory {
  all,
  travel,
  date,
  food,
  celebration,
  activity,
  dailyLife,
  gift,
  other;

  String get apiValue => switch (this) {
        AlbumCategory.all => 'all',
        AlbumCategory.travel => 'travel',
        AlbumCategory.date => 'date',
        AlbumCategory.food => 'food',
        AlbumCategory.celebration => 'celebration',
        AlbumCategory.activity => 'activity',
        AlbumCategory.dailyLife => 'daily_life',
        AlbumCategory.gift => 'gift',
        AlbumCategory.other => 'other',
      };

  String get label => switch (this) {
        AlbumCategory.all => 'All',
        AlbumCategory.travel => 'Travel',
        AlbumCategory.date => 'Date',
        AlbumCategory.food => 'Food',
        AlbumCategory.celebration => 'Celebration',
        AlbumCategory.activity => 'Activity',
        AlbumCategory.dailyLife => 'Daily Life',
        AlbumCategory.gift => 'Gift',
        AlbumCategory.other => 'Other',
      };

  IconData get icon => switch (this) {
        AlbumCategory.all => Icons.photo_library_rounded,
        AlbumCategory.travel => Icons.flight_takeoff_rounded,
        AlbumCategory.date => Icons.favorite_rounded,
        AlbumCategory.food => Icons.restaurant_rounded,
        AlbumCategory.celebration => Icons.celebration_rounded,
        AlbumCategory.activity => Icons.directions_run_rounded,
        AlbumCategory.dailyLife => Icons.wb_sunny_rounded,
        AlbumCategory.gift => Icons.card_giftcard_rounded,
        AlbumCategory.other => Icons.more_horiz_rounded,
      };

  Color get color => switch (this) {
        AlbumCategory.all => AppColors.primary,
        AlbumCategory.travel => AppColors.primary,
        AlbumCategory.date => AppColors.accentRose,
        AlbumCategory.food => AppColors.statusOrange,
        AlbumCategory.celebration => AppColors.secondary,
        AlbumCategory.activity => AppColors.statusGreen,
        AlbumCategory.dailyLife => AppColors.yellow,
        AlbumCategory.gift => AppColors.buttonPrimary,
        AlbumCategory.other => AppColors.textGrey,
      };

  Color get bgColor => switch (this) {
        AlbumCategory.all => AppColors.brandBackground,
        AlbumCategory.travel => AppColors.brandBackground,
        AlbumCategory.date => const Color(0xFFFBEAF0),
        AlbumCategory.food => AppColors.chipOrangeBg,
        AlbumCategory.celebration => AppColors.chipPurpleBg,
        AlbumCategory.activity => AppColors.chipGreenBg,
        AlbumCategory.dailyLife => AppColors.highlightYellow,
        AlbumCategory.gift => AppColors.statusLightRed,
        AlbumCategory.other => AppColors.lightGrey,
      };

  static AlbumCategory fromApi(String value) => switch (value) {
        'travel' => AlbumCategory.travel,
        'date' => AlbumCategory.date,
        'food' => AlbumCategory.food,
        'celebration' => AlbumCategory.celebration,
        'activity' => AlbumCategory.activity,
        'daily_life' => AlbumCategory.dailyLife,
        'gift' => AlbumCategory.gift,
        _ => AlbumCategory.other,
      };
}
