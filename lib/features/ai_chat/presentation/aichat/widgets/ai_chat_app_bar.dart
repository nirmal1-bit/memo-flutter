import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class AiChatAppBar extends StatelessWidget {
  const AiChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyles.libre.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.softPrimary,
                    letterSpacing: -0.3,
                  ),
                  children: const [
                    TextSpan(text: 'menmo'),
                    TextSpan(
                      text: '.',
                      style: TextStyle(color: AppColors.timelineMem),
                    ),
                  ],
                ),
              ),
              Text(
                'Your personal memory AI',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 11,
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.brandBackground,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.brandBackgroundLight),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.people_outline_rounded,
                  size: 13,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  '12 connections',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppColors.userGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'AK',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
