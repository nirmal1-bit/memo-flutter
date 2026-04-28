import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/ai_chat/presentation/ai_chat_screen.dart';
import 'package:memo/features/network/presentation/screens/add_connection_screen.dart';
import 'package:memo/features/network/presentation/screens/network_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    AppColors.statusGreen,
    AppColors.statusGreen,
    AppColors.statusGreen,
    AppColors.statusGreen,
    AppColors.statusGreen,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation?.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentPage && mounted) {
        changePage(value);
      }
    });
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        toolbarHeight: 0,
      ),
      body: BottomBar(
        clip: Clip.hardEdge,
        fit: StackFit.expand,
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: AppColors.white,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(500),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        showIcon: true,
        width: 360,
        barColor: AppColors.softPrimary.withAlpha(200),
        start: 2,
        end: 0,
        scrollDeltaThreshold: 8,

        offset: 2,
        hideOnScroll: true,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 30,
        iconWidth: 30,
        body: (context, controller) => TabBarView(
          controller: tabController,

          children: [
            NetworkScreen(controller: controller),
            AddConnectionScreen(),
            AiChatScreen(),
            Placeholder(),
            Placeholder(),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            TabBar(
              indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              controller: tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: currentPage <= 4
                      ? colors[currentPage]
                      : AppColors.white,
                  width: 4,
                ),
                insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
              ),
              tabs: [
                _BottomTabIcon(
                  icon: Icons.home_rounded,
                  active: currentPage == 0,
                  activeColor: colors[0],
                  inactiveColor: AppColors.white,
                ),
                _BottomTabIcon(
                  icon: Icons.search_rounded,
                  active: currentPage == 1,
                  activeColor: colors[0],
                  inactiveColor: AppColors.white,
                ),
                _BottomTabIcon(
                  icon: Icons.chat_sharp,
                  active: currentPage == 2,
                  activeColor: colors[0],
                  inactiveColor: AppColors.white,
                ),
                _BottomTabIcon(
                  icon: Icons.favorite_rounded,
                  active: currentPage == 3,
                  activeColor: colors[0],
                  inactiveColor: AppColors.white,
                ),
                _BottomTabIcon(
                  icon: Icons.settings_rounded,
                  active: currentPage == 4,
                  activeColor: colors[0],
                  inactiveColor: AppColors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomTabIcon extends StatelessWidget {
  const _BottomTabIcon({
    required this.icon,
    required this.active,
    required this.activeColor,
    required this.inactiveColor,
  });

  final IconData icon;
  final bool active;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 40,
      child: Center(
        child: Icon(icon, color: active ? activeColor : inactiveColor),
      ),
    );
  }
}
