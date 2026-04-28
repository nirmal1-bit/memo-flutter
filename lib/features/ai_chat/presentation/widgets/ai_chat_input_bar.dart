import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class AiChatInputBar extends StatelessWidget {
  const AiChatInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hasText,
    required this.onSend,
    required this.onAttach,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasText;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.dividerColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onAttach,
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 8, bottom: 1),
              decoration: BoxDecoration(
                color: AppColors.brandBackground,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.brandBackgroundLight),
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 20,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 14,
                  color: AppColors.softBlack,
                ),
                decoration: InputDecoration(
                  hintText: 'Ask anything about someone…',
                  hintStyle: AppTextStyles.rubik.copyWith(
                    fontSize: 14,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: hasText ? onSend : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: hasText ? AppColors.primary : AppColors.dividerColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Icons.send_rounded,
                size: 18,
                color: hasText ? AppColors.white : AppColors.textGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
