import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class ChatComposer extends StatelessWidget {
  const ChatComposer({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isBusy,
    this.onVoice,
    this.scrollPadding = const EdgeInsets.all(20),
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isBusy;
  final VoidCallback? onVoice;
  final EdgeInsets scrollPadding;

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
              scrollPadding: scrollPadding,
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
          if (onVoice != null) ...[
            Material(
              color: AppColors.brandBackground,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: onVoice,
                borderRadius: BorderRadius.circular(16),
                child: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.record_voice_over,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
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
