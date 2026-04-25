import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class NetworkSearchBar extends StatelessWidget {
  const NetworkSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 13,
          color: AppColors.textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Search people or content',
          hintStyle: AppTextStyles.rubik.copyWith(
            fontSize: 13,
            color: AppColors.textLight,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textGrey,
            size: 18,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
