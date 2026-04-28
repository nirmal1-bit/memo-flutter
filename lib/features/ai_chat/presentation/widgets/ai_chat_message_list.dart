import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/ai_chat/presentation/ai_chat_data.dart';

class AiChatMessageRow extends StatelessWidget {
  const AiChatMessageRow({
    super.key,
    required this.message,
    required this.onChipTap,
    required this.onSaveMemory,
  });

  final ChatMessage message;
  final ValueChanged<String> onChipTap;
  final VoidCallback onSaveMemory;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == ChatSender.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[const AiChatAvatar(), const SizedBox(width: 8)],
          Flexible(
            child: switch (message.type) {
              ChatMsgType.text => AiChatTextBubble(
                text: message.text!,
                isUser: isUser,
              ),
              ChatMsgType.personCard => AiChatPersonCardBubble(
                data: message.personCard!,
              ),
              ChatMsgType.memoryConfirm => AiChatMemoryConfirmBubble(
                data: message.memoryConfirm!,
                onSave: onSaveMemory,
              ),
              ChatMsgType.suggestionChips => AiChatSuggestionChipsBubble(
                chips: message.chips!,
                onTap: onChipTap,
              ),
            },
          ),
        ],
      ),
    );
  }
}

class AiChatAvatar extends StatelessWidget {
  const AiChatAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.aiSurfaceBg,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.aiSurfaceBorder),
      ),
      child: const Icon(
        Icons.auto_awesome_rounded,
        size: 13,
        color: AppColors.timelineMem,
      ),
    );
  }
}

class AiChatTextBubble extends StatelessWidget {
  const AiChatTextBubble({super.key, required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isUser ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(isUser ? 18 : 4),
          bottomRight: Radius.circular(isUser ? 4 : 18),
        ),
        border: isUser ? null : Border.all(color: AppColors.dividerColor),
      ),
      child: Text(
        text,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 14,
          color: isUser ? AppColors.white : AppColors.softBlack,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class AiChatPersonCardBubble extends StatelessWidget {
  const AiChatPersonCardBubble({super.key, required this.data});

  final PersonCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(18),
        ),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: data.avatarColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      data.initials,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: data.avatarTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: AppTextStyles.libre.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.softPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.role,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 12,
                          color: AppColors.softTextGrey,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.lastInteraction,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 11,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: data.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.brandBackground,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        tag,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (data.insight != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: AppColors.aiSurfaceBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.aiSurfaceBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      size: 13,
                      color: AppColors.timelineMem,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        data.insight!,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 12,
                          color: AppColors.aiSurfaceText,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              width: double.infinity,
              height: 38,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.brandBackgroundLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.brandBackground,
                ),
                child: Text(
                  'Open profile',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
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

class AiChatMemoryConfirmBubble extends StatefulWidget {
  const AiChatMemoryConfirmBubble({
    super.key,
    required this.data,
    required this.onSave,
  });

  final MemoryConfirmData data;
  final VoidCallback onSave;

  @override
  State<AiChatMemoryConfirmBubble> createState() =>
      _AiChatMemoryConfirmBubbleState();
}

class _AiChatMemoryConfirmBubbleState extends State<AiChatMemoryConfirmBubble> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(18),
        ),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.memoryAmber,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  size: 13,
                  color: AppColors.memoryAmberText,
                ),
                const SizedBox(width: 7),
                Text(
                  _saved ? 'Memory saved!' : 'Save this memory?',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.memoryAmberText,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 14,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.data.personName,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.softBlack,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.brandBackground,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        widget.data.type,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.data.memoryText,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 13,
                      color: AppColors.softBlack,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (!_saved)
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => _saved = true);
                              widget.onSave();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Save memory',
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.dividerColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Edit first',
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.softTextGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: AppColors.statusGreen,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Added to Priya\'s memories',
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.statusGreen,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AiChatSuggestionChipsBubble extends StatelessWidget {
  const AiChatSuggestionChipsBubble({
    super.key,
    required this.chips,
    required this.onTap,
  });

  final List<String> chips;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips
          .map(
            (chip) => GestureDetector(
              onTap: () => onTap(chip),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.brandBackgroundLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      chip,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.softPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class AiChatTypingIndicator extends StatefulWidget {
  const AiChatTypingIndicator({super.key});

  @override
  State<AiChatTypingIndicator> createState() => _AiChatTypingIndicatorState();
}

class _AiChatTypingIndicatorState extends State<AiChatTypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const AiChatAvatar(),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) {
                  final delay = index * 0.15;
                  final value = (((_ctrl.value + delay) % 1.0 - 0.5).abs() * 2)
                      .clamp(0.3, 1.0);
                  return Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(value),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AiChatTimestampDivider extends StatelessWidget {
  const AiChatTimestampDivider({super.key, required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppColors.dividerColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              _fmt(time),
              style: AppTextStyles.rubik.copyWith(
                fontSize: 11,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(child: Divider(color: AppColors.dividerColor)),
        ],
      ),
    );
  }

  String _fmt(DateTime time) {
    final hour = time.hour > 12
        ? time.hour - 12
        : time.hour == 0
        ? 12
        : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
