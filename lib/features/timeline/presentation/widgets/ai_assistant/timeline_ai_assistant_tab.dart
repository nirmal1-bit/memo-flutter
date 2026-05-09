import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/timeline/presentation/time_line_data.dart';

class TimelineAiAssistantTab extends StatefulWidget {
  const TimelineAiAssistantTab({super.key});

  @override
  State<TimelineAiAssistantTab> createState() => _TimelineAiAssistantTabState();
}

class _TimelineAiAssistantTabState extends State<TimelineAiAssistantTab> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  final List<AiMessage> _messages = [
    const AiMessage(
      isAi: true,
      text:
          'Hi! I\'m Priya\'s assistant. Ask me anything about her — past interactions, what to say next, her preferences, or how your relationship has evolved.',
    ),
  ];

  final List<String> _suggestions = [
    'Summarise my relationship with Priya',
    'What should I talk about next?',
    'What does she care about at work?',
    'When did we last speak?',
  ];

  void _send(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(AiMessage(isAi: false, text: text.trim()));
      _messages.add(
        AiMessage(
          isAi: true,
          text:
              'Based on your 18 memories and call history with Priya: ${text.contains('relationship') ? 'You\'ve known Priya for 2 years, met at ProductConf Bangalore in Feb 2026. You have 5 interactions logged — 2 calls, 1 video call, and 2 async messages. She tends to be warm but concise. Strongest connection point: shared interest in product-led growth.' : 'You last spoke on Apr 14, 2026 over a 38-minute video call about her company\'s roadmap pivot. She mentioned eng bandwidth as the main challenge. A good follow-up would be asking how the Q3 PLG timeline is shaping up.'}',
        ),
      );
    });

    _controller.clear();
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_messages.length == 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _suggestions
                  .map(
                    (suggestion) => GestureDetector(
                      onTap: () => _send(suggestion),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.brandBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.brandBackgroundLight,
                          ),
                        ),
                        child: Text(
                          suggestion,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.softPrimary,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: message.isAi
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    if (message.isAi) ...[
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.aiSurfaceBg,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.aiSurfaceBorder),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          size: 14,
                          color: Color(0xFFFF8C42),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: message.isAi
                              ? AppColors.white
                              : AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(message.isAi ? 4 : 16),
                            bottomRight: Radius.circular(message.isAi ? 16 : 4),
                          ),
                          border: message.isAi
                              ? Border.all(color: AppColors.dividerColor)
                              : null,
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 13,
                            height: 1.5,
                            color: message.isAi
                                ? AppColors.softBlack
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.dividerColor)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontFamily: 'Rubik', fontSize: 13.5),
                  decoration: InputDecoration(
                    hintText: 'Ask about Priya…',
                    hintStyle: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 13.5,
                      color: AppColors.textGrey,
                    ),
                    filled: true,
                    fillColor: AppColors.scaffoldBackground,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: _send,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => _send(_controller.text),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    size: 18,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
