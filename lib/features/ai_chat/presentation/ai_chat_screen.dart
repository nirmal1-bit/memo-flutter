import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/ai_chat/presentation/ai_chat_data.dart';
import 'package:memo/features/ai_chat/presentation/widgets/ai_chat_attach_option.dart';
import 'package:memo/features/ai_chat/presentation/widgets/ai_chat_app_bar.dart';
import 'package:memo/features/ai_chat/presentation/widgets/ai_chat_empty_state.dart';
import 'package:memo/features/ai_chat/presentation/widgets/ai_chat_input_bar.dart';
import 'package:memo/features/ai_chat/presentation/widgets/ai_chat_message_list.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isTyping = false;
  bool _inputHasText = false;

  late final List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List.from(initialMessages);
    _inputController.addListener(() {
      setState(() {
        _inputHasText = _inputController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.scrollController.hasClients) return;
      if (animated) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      } else {
        widget.scrollController.jumpTo(
          widget.scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  void _sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          sender: ChatSender.user,
          type: ChatMsgType.text,
          text: trimmed,
          time: DateTime.now(),
        ),
      );
      _isTyping = true;
    });
    _inputController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_getAiReply(trimmed));
      });
      _scrollToBottom();
    });
  }

  ChatMessage _getAiReply(String input) {
    final lower = input.toLowerCase();

    if (lower.contains('remember') || lower.contains('memory')) {
      return ChatMessage(
        sender: ChatSender.ai,
        type: ChatMsgType.memoryConfirm,
        memoryConfirm: MemoryConfirmData(
          personName: 'Priya Menon',
          memoryText: input,
          type: 'Work',
        ),
        time: DateTime.now(),
      );
    }

    if (lower.contains('james') || lower.contains('lin')) {
      return ChatMessage(
        sender: ChatSender.ai,
        type: ChatMsgType.personCard,
        personCard: const PersonCardData(
          initials: 'JL',
          name: 'James Lin',
          role: 'Product Designer · Figma',
          lastInteraction: 'Last interaction · 5 days ago',
          insight:
              'You met at Config 2024. He mentioned he was exploring a new role. Might be worth checking in.',
          tags: ['Designer', 'Config 2024', 'San Francisco'],
          avatarColor: Color(0xFFE6F1FB),
          avatarTextColor: Color(0xFF185FA5),
        ),
        time: DateTime.now(),
      );
    }

    return ChatMessage(
      sender: ChatSender.ai,
      type: ChatMsgType.text,
      text:
          'I found relevant context in your memories. Based on your interactions and notes, '
          '${lower.contains('say') || lower.contains('message') ? 'a good opening would be asking about their recent work — you have shared context from your last conversation that makes it feel personal.' : 'here\'s what I know: you\'ve had consistent interactions over the past few months and the relationship is warm. A simple check-in would go a long way.'}',
      time: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AiChatAppBar(),
            Expanded(
              child: _messages.isEmpty
                  ? AiChatEmptyState(onQuickAction: _sendMessage)
                  : GestureDetector(
                      onTap: () => _focusNode.unfocus(),
                      child: ListView.builder(
                        controller: widget.scrollController,
                        padding: EdgeInsets.fromLTRB(
                          16,
                          12,
                          16,
                          bottomPadding > 0 ? 8 : 16,
                        ),
                        itemCount: _messages.length + (_isTyping ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length) {
                            return const AiChatTypingIndicator();
                          }
                          final message = _messages[index];
                          final showDate =
                              index == 0 ||
                              !_sameMinute(
                                _messages[index - 1].time,
                                message.time,
                              );
                          return Column(
                            children: [
                              if (showDate)
                                AiChatTimestampDivider(time: message.time),
                              AiChatMessageRow(
                                message: message,
                                onChipTap: _sendMessage,
                                onSaveMemory: () => _showMemorySaved(context),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),
            AiChatInputBar(
              controller: _inputController,
              focusNode: _focusNode,
              hasText: _inputHasText,
              onSend: () => _sendMessage(_inputController.text),
              onAttach: () => _showAttachSheet(context),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  bool _sameMinute(DateTime a, DateTime b) =>
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day &&
      a.hour == b.hour &&
      a.minute == b.minute;

  void _showMemorySaved(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.statusGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'Memory saved successfully',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAttachSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add to memory',
              style: AppTextStyles.libre.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.softPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Attach context for the AI to remember',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                color: AppColors.softTextGrey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                AiChatAttachOption(
                  icon: Icons.image_outlined,
                  label: 'Image',
                  color: AppColors.primary,
                  bg: AppColors.brandBackground,
                ),
                AiChatAttachOption(
                  icon: Icons.face_retouching_natural_rounded,
                  label: 'Face scan',
                  color: AppColors.secondary,
                  bg: AppColors.chipPurpleBg,
                ),
                AiChatAttachOption(
                  icon: Icons.mic_outlined,
                  label: 'Voice note',
                  color: AppColors.timelineMem,
                  bg: AppColors.chipOrangeBg,
                ),
                AiChatAttachOption(
                  icon: Icons.description_outlined,
                  label: 'Document',
                  color: AppColors.softTextGrey,
                  bg: AppColors.lightGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
