import 'package:flutter/material.dart';

enum ChatMsgType { text, personCard, memoryConfirm, suggestionChips }

enum ChatSender { user, ai }

class ChatMessage {
  const ChatMessage({
    required this.sender,
    required this.type,
    required this.time,
    this.text,
    this.personCard,
    this.memoryConfirm,
    this.chips,
  });

  final ChatSender sender;
  final ChatMsgType type;
  final String? text;
  final PersonCardData? personCard;
  final MemoryConfirmData? memoryConfirm;
  final List<String>? chips;
  final DateTime time;
}

class PersonCardData {
  const PersonCardData({
    required this.initials,
    required this.name,
    required this.role,
    required this.lastInteraction,
    required this.tags,
    required this.avatarColor,
    required this.avatarTextColor,
    this.insight,
  });

  final String initials;
  final String name;
  final String role;
  final String lastInteraction;
  final String? insight;
  final List<String> tags;
  final Color avatarColor;
  final Color avatarTextColor;
}

class MemoryConfirmData {
  const MemoryConfirmData({
    required this.personName,
    required this.memoryText,
    required this.type,
  });

  final String personName;
  final String memoryText;
  final String type;
}

final initialMessages = <ChatMessage>[
  ChatMessage(
    sender: ChatSender.ai,
    type: ChatMsgType.text,
    text:
        'Good morning! I noticed you have a follow-up with Priya this week. Want a quick briefing before you reach out?',
    time: DateTime(2026, 4, 28, 9, 38),
  ),
  ChatMessage(
    sender: ChatSender.user,
    type: ChatMsgType.text,
    text: 'Yes — what do I know about her?',
    time: DateTime(2026, 4, 28, 9, 39),
  ),
  ChatMessage(
    sender: ChatSender.ai,
    type: ChatMsgType.personCard,
    personCard: PersonCardData(
      initials: 'PM',
      name: 'Priya Menon',
      role: 'Product Lead · Series B startup',
      lastInteraction: 'Last interaction · 12 days ago',
      insight:
          'You last spoke about their roadmap pivot. She mentioned hiring pressure — asking about the team\'s morale could be a great opener.',
      tags: ['Prefers voice notes', 'Follow-up due', 'Mumbai'],
      avatarColor: Color(0xFFEFF7F8),
      avatarTextColor: Color(0xFF055F6B),
    ),
    time: DateTime(2026, 4, 28, 9, 39),
  ),
  ChatMessage(
    sender: ChatSender.user,
    type: ChatMsgType.text,
    text: 'Also remind me — what are her preferences?',
    time: DateTime(2026, 4, 28, 9, 40),
  ),
  ChatMessage(
    sender: ChatSender.ai,
    type: ChatMsgType.text,
    text:
        'Based on your notes: Priya prefers async voice messages over long texts. She\'s most responsive on Thursdays. Her birthday is March 14 — you noted she loves dark chocolate.',
    time: DateTime(2026, 4, 28, 9, 40),
  ),
  ChatMessage(
    sender: ChatSender.ai,
    type: ChatMsgType.suggestionChips,
    chips: [
      'What to say to Priya?',
      'Show her timeline',
      'Add a memory about her',
    ],
    time: DateTime(2026, 4, 28, 9, 40),
  ),
];

const quickActions = [
  (icon: Icons.person_search_rounded, label: 'Who did I meet last week?'),
  (icon: Icons.lightbulb_outline_rounded, label: 'What should I say to James?'),
  (icon: Icons.add_circle_outline_rounded, label: 'Remember something new'),
  (icon: Icons.history_rounded, label: 'Show recent interactions'),
];
