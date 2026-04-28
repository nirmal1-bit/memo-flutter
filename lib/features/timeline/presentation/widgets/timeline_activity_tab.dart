import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/timeline/presentation/time_line_data.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_shared_widgets.dart';

class TimelineActivityTab extends StatelessWidget {
  const TimelineActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<TimelineEntry>> grouped = {};
    for (final entry in dummyTimeline) {
      final key = '${_mon(entry.date.month)} ${entry.date.year}';
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _TimelineFilterRow(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, sectionIndex) {
              final entry = grouped.entries.toList()[sectionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 6, left: 4),
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                  ...entry.value.map((event) => _TimelineItem(event: event)),
                ],
              );
            }, childCount: grouped.length),
          ),
        ),
      ],
    );
  }

  static String _mon(int month) => const [
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
  ][month];
}

class _TimelineFilterRow extends StatelessWidget {
  const _TimelineFilterRow();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          TimelineFilterChip(label: 'All', selected: true, onTap: _noop),
          SizedBox(width: 8),
          TimelineFilterChip(label: 'Calls', selected: false, onTap: _noop),
          SizedBox(width: 8),
          TimelineFilterChip(label: 'Messages', selected: false, onTap: _noop),
          SizedBox(width: 8),
          TimelineFilterChip(label: 'Meetings', selected: false, onTap: _noop),
          SizedBox(width: 8),
          TimelineFilterChip(label: 'Memories', selected: false, onTap: _noop),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.event});

  final TimelineEntry event;

  Color get _dotColor => switch (event.type) {
    TimelineEventType.call => AppColors.timelineCall,
    TimelineEventType.message => AppColors.timelineMsg,
    TimelineEventType.meeting => AppColors.timelineMeet,
    TimelineEventType.video => AppColors.timelineVid,
    TimelineEventType.memory => AppColors.timelineMem,
  };

  String get _typeLabel => switch (event.type) {
    TimelineEventType.call => 'Phone call',
    TimelineEventType.message => 'Message',
    TimelineEventType.meeting => 'In-person',
    TimelineEventType.video => 'Video call',
    TimelineEventType.memory => 'Memory',
  };

  IconData get _typeIcon => switch (event.type) {
    TimelineEventType.call => Icons.call_outlined,
    TimelineEventType.message => Icons.chat_bubble_outline_rounded,
    TimelineEventType.meeting => Icons.location_on_outlined,
    TimelineEventType.video => Icons.videocam_outlined,
    TimelineEventType.memory => Icons.auto_awesome_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    color: _dotColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: _dotColor.withOpacity(0.35),
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: _dotColor.withOpacity(0.08),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(_typeIcon, size: 12, color: _dotColor),
                        const SizedBox(width: 5),
                        Text(
                          _typeLabel,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _dotColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _fmtShort(event.date),
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 10.5,
                            color: _dotColor.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 9, 12, 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.softBlack,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          event.subtitle,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12.5,
                            color: AppColors.softTextGrey,
                          ),
                        ),
                        if (event.extra != null) ...[
                          const SizedBox(height: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.scaffoldBackground,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              event.extra!,
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 11.5,
                                color: AppColors.softTextGrey,
                              ),
                            ),
                          ),
                        ],
                        if (event.type == TimelineEventType.video) ...[
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.description_outlined,
                                  size: 13,
                                  color: AppColors.timelineVid,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'View transcript & extract memories',
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.timelineVid,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmtShort(DateTime date) => '${_mon(date.month)} ${date.day}';

  static String _mon(int month) => const [
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
  ][month];
}

void _noop() {}
