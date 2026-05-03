import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.alignEnd,
    required this.senderName,
    required this.text,
    required this.timeLabel,
  });

  final bool alignEnd;
  final String senderName;
  final String text;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    final bubbleMaxWidth = MediaQuery.sizeOf(context).width * 0.72;

    return Align(
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!alignEnd) ...[
            Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 5),
              child: Text(
                senderName,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.softTextGrey,
                ),
              ),
            ),
          ],
          Container(
            constraints: BoxConstraints(maxWidth: bubbleMaxWidth),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: alignEnd ? AppColors.primary : AppColors.brandBackground,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(alignEnd ? 18 : 6),
                bottomRight: Radius.circular(alignEnd ? 6 : 18),
              ),
            ),
            child: Text(
              text,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13.5,
                height: 1.35,
                color: alignEnd ? AppColors.white : AppColors.softBlack,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            timeLabel,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 10.5,
              color: AppColors.softTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}
