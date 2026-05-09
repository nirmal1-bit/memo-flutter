import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/timeline/data/response/time_line_response.dart';
import 'timeline_helpers.dart';

// ─── TimelineItem ─────────────────────────────────────────────────────────────

class TimelineItem extends StatelessWidget {
  const TimelineItem({super.key, required this.event, required this.type});

  final TimeLineResponse event;
  final TimelineActivityType type;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TimelineDot(color: type.color),
          const SizedBox(width: 10),
          Expanded(
            child: TimelineCard(event: event, type: type),
          ),
        ],
      ),
    );
  }
}

// ─── TimelineDot ──────────────────────────────────────────────────────────────

class TimelineDot extends StatelessWidget {
  const TimelineDot({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Column(
        children: [
          Container(
            width: 9,
            height: 9,
            margin: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(width: 1, color: AppColors.dividerColor),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── TimelineCard ─────────────────────────────────────────────────────────────

class TimelineCard extends StatelessWidget {
  const TimelineCard({super.key, required this.event, required this.type});

  final TimeLineResponse event;
  final TimelineActivityType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimelineCardHeader(event: event, type: type),
          TimelineCardBody(event: event),
        ],
      ),
    );
  }
}

class TimelineCardHeader extends StatelessWidget {
  const TimelineCardHeader({
    super.key,
    required this.event,
    required this.type,
  });

  final TimeLineResponse event;
  final TimelineActivityType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: type.color.withOpacity(0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Icon(type.icon, size: 12, color: type.color),
          const SizedBox(width: 5),
          Text(
            type.cardLabel,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: type.color,
            ),
          ),
          const Spacer(),
          Text(
            formatShortDate(event.createdAt),
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 10.5,
              color: type.color.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── TimelineCardBody ─────────────────────────────────────────────────────────

class TimelineCardBody extends StatelessWidget {
  const TimelineCardBody({super.key, required this.event});

  final TimeLineResponse event;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Text(
        "Summary:",
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 12.5,
          fontWeight: FontWeight.bold,
          color: AppColors.softBlack,
        ),
      ),
      const SizedBox(height: 3),
      Text(
        event.summary ?? "No summary provided.",
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 12.5,
          fontWeight: FontWeight.w400,
          color: AppColors.softBlack,
        ),
      ),
    ];

    if (event.status.trim().isNotEmpty) {
      children.add(const SizedBox(height: 7));
      children.add(TimelineStatusBadge(status: event.status));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 9, 12, 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

// ─── TimelineStatusBadge ──────────────────────────────────────────────────────

class TimelineStatusBadge extends StatelessWidget {
  const TimelineStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 11.5,
          color: AppColors.softTextGrey,
        ),
      ),
    );
  }
}
