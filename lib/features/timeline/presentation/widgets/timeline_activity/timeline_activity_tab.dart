import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/timeline/cubits/get_timeline_cubit.dart';
import 'package:memo/features/timeline/data/response/time_line_response.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_activity/time_line_filters_row.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_activity/time_line_status.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_activity/timeline_helpers.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_activity/timeline_itme.dart';

class TimelineActivityTab extends StatelessWidget {
  const TimelineActivityTab({super.key, required this.connectionId});

  final int connectionId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetTimelineCubit>();

    return BlocBuilder<GetTimelineCubit, BaseApiState<List<TimeLineResponse>>>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TimelineFilterRow(
                  selectedType: null,
                  onSelected: (TimelineActivityType? value) {},
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
      initial: () => const TimelineLoadingSliver(),
      loading: () => const TimelineLoadingSliver(),
      error: (message) => TimelineStatusSliver(
        icon: Icons.error_outline_rounded,
        title: 'Unable to load activity',
        message: message,
      ),
      noInternet: () => const TimelineStatusSliver(
        icon: Icons.wifi_off_rounded,
        title: 'No internet connection',
        message: 'Check your connection and try again.',
      ),
      validationError: (err) => TimelineStatusSliver(
        icon: Icons.warning_amber_rounded,
        title: err.message,
        message: err.errors.isNotEmpty
            ? err.errors.values.first.toString()
            : 'Please review the request and try again.',
      ),
      success: _buildSuccessSliver,
    );
  }

  Widget _buildSuccessSliver(List<TimeLineResponse> timeline) {
    if (timeline.isEmpty) {
      return const TimelineStatusSliver(
        icon: Icons.timeline_rounded,
        title: 'No activity yet',
        message: 'Timeline events for this connection will appear here.',
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => TimelineItem(
            event: timeline[index],
            type: TimelineActivityType.call,
          ),
          childCount: timeline.length,
        ),
      ),
    );
  }
}
