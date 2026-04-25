import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class NetworkSearchBar extends StatelessWidget {
  const NetworkSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.softBlack.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          style: AppTextStyles.rubik.copyWith(
            fontSize: 13.5,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              color: AppColors.textLight,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.textGrey,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }
}
