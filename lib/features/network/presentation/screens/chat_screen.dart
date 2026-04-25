import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/cubits/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.connection});

  final ConnectionResponse connection;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messagesController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.connection.otherUserDetails;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        foregroundColor: AppColors.softPrimary,
        titleSpacing: 0,
        title: Text(
          'Chat',
          style: AppTextStyles.libre.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Start video call',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Starting video call with ${user.name}...'),
              ),
            ),
            icon: const Icon(Icons.videocam_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<ChatCubit, ChatState>(
          listenWhen: (previous, current) =>
              previous.messages.length != current.messages.length ||
              previous.status != current.status,
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_messagesController.hasClients) {
                _messagesController.animateTo(
                  _messagesController.position.maxScrollExtent + 120,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              }
            });

            if (state.status == ChatConnectionStatus.error &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ChatPanel(
                      messagesController: _messagesController,
                      messages: state.messages,
                      status: state.status,
                      errorMessage: state.errorMessage,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SafeArea(
                    top: false,
                    child: _ChatComposer(
                      controller: _messageController,
                      onSend: () => _sendMessage(context),
                      isBusy: state.status == ChatConnectionStatus.connecting,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }

    context.read<ChatCubit>().sendMessage(text);
    _messageController.clear();
  }
}

class _ChatPanel extends StatelessWidget {
  const _ChatPanel({
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
            child: messages.isEmpty
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
                : ListView.separated(
                    controller: messagesController,
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    itemCount: messages.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _ChatBubble(
                        alignEnd: message.isMe,
                        senderName: message.name,
                        text: message.message,
                        timeLabel: message.timeLabel,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({
    required this.controller,
    required this.onSend,
    required this.isBusy,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: isBusy ? 'Connecting...' : 'Write a message...',
                filled: true,
                fillColor: AppColors.brandBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: isBusy ? null : onSend,
              borderRadius: BorderRadius.circular(16),
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.send_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
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
