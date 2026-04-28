import 'package:flutter/material.dart';
import 'package:memo/features/timeline/presentation/time_line_data.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_ai_assistant_tab.dart';
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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          TimelineProfileSliverHeader(
            tabController: _tabController,
            innerBoxIsScrolled: innerBoxIsScrolled,
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            TimelineMemoriesTab(),
            TimelineActivityTab(),
            TimelineAiAssistantTab(),
            TimelineFaceDataTab(),
          ],
        ),
      ),
    );
  }
}
