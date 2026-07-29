import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/features/ai_chat/presentation/aichat/ai_chat_screen.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/timeline/cubits/get_memories_cubit.dart';
import 'package:memo/features/timeline/cubits/get_timeline_cubit.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_activity/timeline_activity_tab.dart';
import 'package:memo/features/timeline/presentation/widgets/memory/timeline_memories_tab.dart';
import 'package:memo/features/timeline/presentation/widgets/header/timeline_profile_header.dart';

class TimeLineScreenParams {
  final UserProfile profile;
  final int connectionId;
  TimeLineScreenParams({required this.profile, required this.connectionId});
}

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({super.key, required this.params, Object? profile});
  final TimeLineScreenParams params;

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<GetMemoriesCubit>()
                ..getMemories(widget.params.connectionId),
        ),
        BlocProvider(
          create: (_) =>
              getIt<GetTimelineCubit>()
                ..getTimeline(widget.params.connectionId),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Non-sliver header. No innerBoxIsScrolled needed since
              // it's not reacting to a coordinated scroll offset anymore.
              TimelineProfileHeader(
                tabController: _tabController,
                profile: widget.params.profile,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TimelineMemoriesTab(
                      connectionId: widget.params.connectionId,
                    ),
                    TimelineActivityTab(
                      connectionId: widget.params.connectionId,
                    ),
                    AiChatScreen(connectionId: widget.params.connectionId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
