import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/features/ai_chat/presentation/ai_chat_screen.dart';
import 'package:memo/features/network/presentation/screens/other_user_profile.dart';
import 'package:memo/features/timeline/cubits/get_memories_cubit.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_activity_tab.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_face_data_tab.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_memories_tab.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_profile_header.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({super.key, required this.otherUserProfileArgs});

  final OtherUserProfileArguments otherUserProfileArgs;

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GetMemoriesCubit>()
            ..getMemories(widget.otherUserProfileArgs.connectionId),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            TimelineProfileSliverHeader(
              otherUserProfileArgs: widget.otherUserProfileArgs,
              tabController: _tabController,
              innerBoxIsScrolled: innerBoxIsScrolled,
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              TimelineMemoriesTab(
                connectionId: widget.otherUserProfileArgs.connectionId,
              ),
              TimelineActivityTab(),
              AiChatScreen(
                connectionId: widget.otherUserProfileArgs.connectionId,
              ),
              TimelineFaceDataTab(),
            ],
          ),
        ),
      ),
    );
  }
}
