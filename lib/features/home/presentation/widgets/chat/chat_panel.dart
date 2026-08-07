import 'package:flutter/material.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/home/presentation/widgets/chat/chat_bubble.dart';

class ChatPanel extends StatelessWidget {
  const ChatPanel({
    super.key,
    required this.messagesController,
    required this.messages,
    required this.status,
    required this.errorMessage,
    this.isFromAi = false,
    this.isLoadingMore = false,
    this.isLoading = false,
  });

  final bool isFromAi;
  final ScrollController messagesController;
  final List<ChatMessage> messages;
  final ChatConnectionStatus status;
  final String? errorMessage;
  final bool isLoadingMore;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isConnecting = status == ChatConnectionStatus.connecting;
    final isConnected = status == ChatConnectionStatus.connected;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isConnected
                      ? AppColors.statusGreen
                      : isConnecting
                      ? const Color(0xFFFF8C42)
                      : AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isConnected
                    ? 'Connected'
                    : isConnecting
                    ? 'Connecting...'
                    : 'Conversation',
                style: AppTextStyles.libre.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.softPrimary,
                ),
              ),
            ],
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                errorMessage!,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
          const SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? const ChatLoading()
                : messages.isEmpty
                ? Center(
                    child: Text(
                      isConnecting
                          ? 'Connecting to the conversation...'
                          : 'No messages yet. Say hello.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 13,
                        color: AppColors.softTextGrey,
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    controller: messagesController,
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    // With reverse=true, the last list item is rendered at
                    // the top (the older-message edge).
                    itemCount: messages.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (isLoadingMore && index == messages.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        );
                      }
                      final message = messages[index];
                      return ChatBubble(
                        alignEnd: message.isMe,
                        text: message.message,
                        timeLabel: message.timeLabel,
                        isCall: message.isCall,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
