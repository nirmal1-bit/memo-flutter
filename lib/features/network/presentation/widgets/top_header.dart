import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.people_alt_rounded,
              color: AppColors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.libre.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.softPrimary,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13.5,
                    height: 1.45,
                    color: AppColors.softTextGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
