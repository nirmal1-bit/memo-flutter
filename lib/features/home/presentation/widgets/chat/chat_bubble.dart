import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.alignEnd,
    required this.text,
    required this.timeLabel,
    this.isCall = false,
    this.status = ChatConnectionStatus.connected,
  });

  final bool alignEnd;
  final String text;
  final String timeLabel;
  final bool isCall;
  final ChatConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (alignEnd) ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: (alignEnd)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          isCall
              ? _CallBubble(alignEnd: alignEnd, text: text)
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: alignEnd
                        ? AppColors.primary
                        : AppColors.brandBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(alignEnd ? 18 : 6),
                      bottomRight: Radius.circular(alignEnd ? 6 : 18),
                    ),
                  ),
                  child: alignEnd
                      ? Text(
                          text,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 13.5,
                            height: 1.35,
                            color: AppColors.white,
                          ),
                        )
                      : MarkdownBody(
                          data: text,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: AppTextStyles.rubik.copyWith(
                              fontSize: 13.5,
                              height: 1.35,
                              color: AppColors.softBlack,
                            ),
                            strong: AppTextStyles.rubik.copyWith(
                              fontSize: 13.5,
                              height: 1.35,
                              color: AppColors.softBlack,
                              fontWeight: FontWeight.w700,
                            ),
                            em: AppTextStyles.rubik.copyWith(
                              fontSize: 13.5,
                              height: 1.35,
                              color: AppColors.softBlack,
                              fontStyle: FontStyle.italic,
                            ),
                            a: AppTextStyles.rubik.copyWith(
                              fontSize: 13.5,
                              height: 1.35,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                            code: AppTextStyles.rubik.copyWith(
                              fontSize: 13,
                              height: 1.35,
                              color: AppColors.softBlack,
                              backgroundColor: AppColors.white,
                            ),
                            codeblockPadding: EdgeInsets.zero,
                            blockSpacing: 8,
                            pPadding: EdgeInsets.zero,
                            listBullet: AppTextStyles.rubik.copyWith(
                              fontSize: 13.5,
                              height: 1.35,
                              color: AppColors.softBlack,
                            ),
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

class _CallBubble extends StatelessWidget {
  const _CallBubble({required this.alignEnd, required this.text});

  final bool alignEnd;
  final String text;

  @override
  Widget build(BuildContext context) {
    final background = alignEnd ? AppColors.primary : AppColors.brandBackground;
    final foreground = alignEnd ? AppColors.white : AppColors.softBlack;

    return Container(
      constraints: const BoxConstraints(minWidth: 220),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: alignEnd ? AppColors.primary : AppColors.dividerColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: foreground.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.videocam_rounded, color: foreground, size: 27),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text.isEmpty ? 'Video call' : text,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Video conversation',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 11.5,
                  color: foreground.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
