import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.rubik.copyWith(
            fontSize: 14,
            color: AppColors.ironGrey,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.primary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: AppTextStyles.rubik.copyWith(
          fontSize: 14,
          color: AppColors.softBlack,
        ),
      ),
    );
  }
}
