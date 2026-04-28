import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/ai_chat/presentation/ai_chat_data.dart';

class AiChatEmptyState extends StatelessWidget {
  const AiChatEmptyState({super.key, required this.onQuickAction});

  final ValueChanged<String> onQuickAction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.aiSurfaceBg,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.aiSurfaceBorder, width: 1.5),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 28,
              color: AppColors.timelineMem,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'What can I help you remember?',
            style: AppTextStyles.libre.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.softPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Ask about any person, add a memory,\nor get context before a conversation.',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              color: AppColors.softTextGrey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ...quickActions.map(
            (action) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => onQuickAction(action.label),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.dividerColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.brandBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          action.icon,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          action.label,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.softBlack,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: AppColors.textGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
