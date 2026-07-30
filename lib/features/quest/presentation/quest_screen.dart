import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/shared/presentation/shared_bucket_list_screen.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key, required this.connectionId});
  final int connectionId;

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen>
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: Column(
        children: [
          _QuestTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SharedBucketListScreen(connectionId: widget.connectionId),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestTabBar extends StatelessWidget {
  const _QuestTabBar({required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground,
      child: TabBar(
        controller: tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textGrey,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2.5,
        labelStyle: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 12,
        ),
        tabs: const [
          Tab(text: 'Bucket List'),
          Tab(text: 'Couple Trivia'),
          Tab(text: 'Weekly Goal'),
        ],
      ),
    );
  }
}
