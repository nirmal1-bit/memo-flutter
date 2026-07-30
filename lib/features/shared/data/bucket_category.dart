import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

enum BucketCategory {
  all,
  travel,
  food,
  adventure,
  experience,
  learning,
  relationship,
  other;

  String get apiValue => switch (this) {
        BucketCategory.all => 'all',
        BucketCategory.travel => 'travel',
        BucketCategory.food => 'food',
        BucketCategory.adventure => 'adventure',
        BucketCategory.experience => 'experience',
        BucketCategory.learning => 'learning',
        BucketCategory.relationship => 'relationship',
        BucketCategory.other => 'other',
      };

  String get label => switch (this) {
        BucketCategory.all => 'All',
        BucketCategory.travel => 'Travel',
        BucketCategory.food => 'Food',
        BucketCategory.adventure => 'Adventure',
        BucketCategory.experience => 'Experience',
        BucketCategory.learning => 'Learning',
        BucketCategory.relationship => 'Relationship',
        BucketCategory.other => 'Other',
      };

  IconData get icon => switch (this) {
        BucketCategory.all => Icons.list_alt_rounded,
        BucketCategory.travel => Icons.flight_takeoff_rounded,
        BucketCategory.food => Icons.restaurant_rounded,
        BucketCategory.adventure => Icons.terrain_rounded,
        BucketCategory.experience => Icons.auto_awesome_rounded,
        BucketCategory.learning => Icons.school_rounded,
        BucketCategory.relationship => Icons.favorite_rounded,
        BucketCategory.other => Icons.more_horiz_rounded,
      };

  Color get color => switch (this) {
        BucketCategory.all => AppColors.primary,
        BucketCategory.travel => AppColors.primary,
        BucketCategory.food => AppColors.statusOrange,
        BucketCategory.adventure => AppColors.statusGreen,
        BucketCategory.experience => AppColors.yellow,
        BucketCategory.learning => AppColors.buttonPrimary,
        BucketCategory.relationship => AppColors.accentRose,
        BucketCategory.other => AppColors.textGrey,
      };

  Color get bgColor => switch (this) {
        BucketCategory.all => AppColors.brandBackground,
        BucketCategory.travel => AppColors.brandBackground,
        BucketCategory.food => AppColors.chipOrangeBg,
        BucketCategory.adventure => AppColors.chipGreenBg,
        BucketCategory.experience => AppColors.highlightYellow,
        BucketCategory.learning => AppColors.chipPurpleBg,
        BucketCategory.relationship => const Color(0xFFFBEAF0),
        BucketCategory.other => AppColors.lightGrey,
      };

  static BucketCategory fromApi(String value) => switch (value) {
        'travel' => BucketCategory.travel,
        'food' => BucketCategory.food,
        'adventure' => BucketCategory.adventure,
        'experience' => BucketCategory.experience,
        'learning' => BucketCategory.learning,
        'relationship' => BucketCategory.relationship,
        _ => BucketCategory.other,
      };
}
