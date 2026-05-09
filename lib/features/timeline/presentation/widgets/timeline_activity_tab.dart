import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/timeline/cubits/get_timeline_cubit.dart';
import 'package:memo/features/timeline/data/response/time_line_response.dart';
import 'package:memo/features/timeline/presentation/widgets/common/timeline_shared_widgets.dart';

class TimelineActivityTab extends StatefulWidget {
  const TimelineActivityTab({super.key, required this.connectionId});

  final int connectionId;

  @override
  State<TimelineActivityTab> createState() => _TimelineActivityTabState();
}

class _TimelineActivityTabState extends State<TimelineActivityTab> {
  String? _filter;

  static const _availableTypes = <String>[
    'call',
    'message',
    'meeting',
    'video',
    'memory',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTimelineCubit, BaseApiState<List<TimeLineResponse>>>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: _TimelineFilterRow(
                  availableTypes: _availableTypes,
                  selectedType: _filter,
                  onSelected: (type) =>
                      setState(() => _filter = type.isEmpty ? null : type),
                ),
              ),
            ),
            _buildStateSliver(state),
          ],
        );
      },
    );
  }

  Widget _buildStateSliver(BaseApiState<List<TimeLineResponse>> state) {
    return state.when(
      initial: () => const TimelineActivityLoadingSliver(),
      loading: () => const TimelineActivityLoadingSliver(),
      error: (message) => TimelineActivityStatusSliver(
        icon: Icons.error_outline_rounded,
        title: 'Unable to load activity',
        message: message,
      ),
      noInternet: () => const TimelineActivityStatusSliver(
        icon: Icons.wifi_off_rounded,
        title: 'No internet connection',
        message: 'Check your connection and try again.',
      ),
      validationError: (validationError) => TimelineActivityStatusSliver(
        icon: Icons.warning_amber_rounded,
        title: validationError.message,
        message: validationError.errors.isNotEmpty
            ? validationError.errors.values.first.toString()
            : 'Please review the request and try again.',
      ),
      success: (timeline) {
        final items = timeline.toList()
          ..sort((left, right) => right.createdAt.compareTo(left.createdAt));

        final filtered = _filter == null
            ? items
            : items
                  .where((entry) => _activityType(entry.status) == _filter)
                  .toList();

        if (items.isEmpty) {
          return const TimelineActivityStatusSliver(
            icon: Icons.timeline_rounded,
            title: 'No activity yet',
            message: 'Timeline events for this connection will appear here.',
          );
        }

        if (filtered.isEmpty) {
          return const TimelineActivityStatusSliver(
            icon: Icons.filter_alt_off_rounded,
            title: 'No activity in this category',
            message: 'Try a different filter to view more entries.',
          );
        }

        final Map<String, List<TimeLineResponse>> grouped = {};
        for (final entry in filtered) {
          final key = '${_mon(entry.createdAt.month)} ${entry.createdAt.year}';
          grouped.putIfAbsent(key, () => []).add(entry);
        }

        final groupedEntries = grouped.entries.toList();
        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, sectionIndex) {
              final entry = groupedEntries[sectionIndex];
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
            }, childCount: groupedEntries.length),
          ),
        );
      },
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

  String? _activityType(String status) {
    final normalized = status.trim().toLowerCase();
    if (normalized.contains('video')) {
      return 'video';
    }
    if (normalized.contains('meet')) {
      return 'meeting';
    }
    if (normalized.contains('message') || normalized.contains('chat')) {
      return 'message';
    }
    if (normalized.contains('memory')) {
      return 'memory';
    }
    if (normalized.contains('call')) {
      return 'call';
    }
    return 'call';
  }
}

class _TimelineFilterRow extends StatelessWidget {
  const _TimelineFilterRow({
    required this.availableTypes,
    required this.selectedType,
    required this.onSelected,
  });

  final List<String> availableTypes;
  final String? selectedType;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TimelineFilterChip(
            label: 'All',
            selected: selectedType == null,
            onTap: () => onSelected(''),
          ),
          ...availableTypes.map(
            (type) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TimelineFilterChip(
                label: _labelForType(type),
                selected: selectedType == type,
                onTap: () => onSelected(type),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _labelForType(String type) => switch (type) {
    'call' => 'Calls',
    'message' => 'Messages',
    'meeting' => 'Meetings',
    'video' => 'Video',
    'memory' => 'Memories',
    _ => type,
  };
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.event});

  final TimeLineResponse event;

  _TimelineActivityType get _type => _activityTypeFromStatus(event.status);

  Color get _dotColor => switch (_type) {
    _TimelineActivityType.call => AppColors.timelineCall,
    _TimelineActivityType.message => AppColors.timelineMsg,
    _TimelineActivityType.meeting => AppColors.timelineMeet,
    _TimelineActivityType.video => AppColors.timelineVid,
    _TimelineActivityType.memory => AppColors.timelineMem,
  };

  String get _typeLabel => switch (_type) {
    _TimelineActivityType.call => 'Call',
    _TimelineActivityType.message => 'Message',
    _TimelineActivityType.meeting => 'Meeting',
    _TimelineActivityType.video => 'Video call',
    _TimelineActivityType.memory => 'Memory',
  };

  IconData get _typeIcon => switch (_type) {
    _TimelineActivityType.call => Icons.call_outlined,
    _TimelineActivityType.message => Icons.chat_bubble_outline_rounded,
    _TimelineActivityType.meeting => Icons.location_on_outlined,
    _TimelineActivityType.video => Icons.videocam_outlined,
    _TimelineActivityType.memory => Icons.auto_awesome_rounded,
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
                          _fmtShort(event.createdAt),
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
                          event.summary ?? '',
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.softBlack,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          event.agoraChannelName.isEmpty
                              ? event.status
                              : event.agoraChannelName,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12.5,
                            color: AppColors.softTextGrey,
                          ),
                        ),
                        if (event.status.trim().isNotEmpty) ...[
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
                              event.status,
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 11.5,
                                color: AppColors.softTextGrey,
                              ),
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

class TimelineActivityLoadingSliver extends StatelessWidget {
  const TimelineActivityLoadingSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class TimelineActivityStatusSliver extends StatelessWidget {
  const TimelineActivityStatusSliver({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.dividerColor),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary, size: 34),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Libre',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.softPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 13,
                  height: 1.5,
                  color: AppColors.softTextGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _TimelineActivityType { call, message, meeting, video, memory }

_TimelineActivityType _activityTypeFromStatus(String status) {
  final normalized = status.trim().toLowerCase();
  if (normalized.contains('video')) {
    return _TimelineActivityType.video;
  }
  if (normalized.contains('meet')) {
    return _TimelineActivityType.meeting;
  }
  if (normalized.contains('message') || normalized.contains('chat')) {
    return _TimelineActivityType.message;
  }
  if (normalized.contains('memory')) {
    return _TimelineActivityType.memory;
  }
  if (normalized.contains('call')) {
    return _TimelineActivityType.call;
  }
  return _TimelineActivityType.call;
}
