import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

// ─── Date formatting ──────────────────────────────────────────────────────────

const _kMonths = [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String formatShortDate(DateTime date) => '${_kMonths[date.month]} ${date.day}';

// ─── Activity type metadata ───────────────────────────────────────────────────

enum TimelineActivityType { call, message, meeting, video, memory }

extension TimelineActivityTypeX on TimelineActivityType {
  String get filterLabel => switch (this) {
    TimelineActivityType.call => 'Calls',
    TimelineActivityType.message => 'Messages',
    TimelineActivityType.meeting => 'Meetings',
    TimelineActivityType.video => 'Video',
    TimelineActivityType.memory => 'Memories',
  };

  String get cardLabel => switch (this) {
    TimelineActivityType.call => 'Call',
    TimelineActivityType.message => 'Message',
    TimelineActivityType.meeting => 'Meeting',
    TimelineActivityType.video => 'Video call',
    TimelineActivityType.memory => 'Memory',
  };

  IconData get icon => switch (this) {
    TimelineActivityType.call => Icons.call_outlined,
    TimelineActivityType.message => Icons.chat_bubble_outline_rounded,
    TimelineActivityType.meeting => Icons.location_on_outlined,
    TimelineActivityType.video => Icons.videocam_outlined,
    TimelineActivityType.memory => Icons.auto_awesome_rounded,
  };

  Color get color => switch (this) {
    TimelineActivityType.call => AppColors.timelineCall,
    TimelineActivityType.message => AppColors.timelineMsg,
    TimelineActivityType.meeting => AppColors.timelineMeet,
    TimelineActivityType.video => AppColors.timelineVid,
    TimelineActivityType.memory => AppColors.timelineMem,
  };
}
