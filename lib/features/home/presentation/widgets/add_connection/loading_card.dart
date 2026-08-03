import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2.4),
          ),
          const SizedBox(width: 12),
          Text(
            'Searching people...',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              color: AppColors.softTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}
