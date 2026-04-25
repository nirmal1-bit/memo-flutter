import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.edit_note_rounded,
              color: AppColors.white,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'InkList',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
