import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/ai_chat/cubits/ai_chat_cubit.dart';
import 'package:memo/features/home/presentation/widgets/chat/chat_bubble.dart';

class AiChatPanel extends StatelessWidget {
  const AiChatPanel({
    super.key,
    required this.messagesController,
    required this.messages,
    required this.status,
    required this.errorMessage,
  });

  final ScrollController messagesController;
  final List<ChatMessage> messages;
  final ChatConnectionStatus status;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final isConnecting = status == ChatConnectionStatus.connecting;
    final isConnected = status == ChatConnectionStatus.connected;
    final isAnswering = status == ChatConnectionStatus.answering;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.scaffoldBackground),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      : isAnswering
                      ? 'Answering...'
                      : '',
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
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
              child: messages.isEmpty
                  ? Center(
                      child: Text(
                        isConnecting
                            ? 'Connecting to the Server...'
                            : 'Ask Menmo anything! It can help you with writing, brainstorming, or just have a casual chat.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 13,
                          color: AppColors.softTextGrey,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            controller: messagesController,
                            padding: const EdgeInsets.only(top: 2, bottom: 4),
                            itemCount: messages.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return ChatBubble(
                                alignEnd: message.isMe,
                                senderName: message.name,
                                text: message.message,
                                timeLabel: message.timeLabel,
                                status: context
                                    .read<AiChatCubit>()
                                    .state
                                    .status,
                              );
                            },
                          ),
                        ),
                        if (isAnswering) ...[
                          const SizedBox(height: 8),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Menmo is Thinking..."),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
