import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/ai_chat/presentation/aichat/ai_chat_screen.dart';
import 'package:memo/features/network/presentation/screens/add_connection_screen.dart';
import 'package:memo/features/network/presentation/screens/network_screen.dart';
import 'package:memo/features/profile/presentation/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    NetworkScreen(),
    AiChatScreen(connectionId: 1),
    AddConnectionScreen(),
    SettingsScreen(),
  ];

  // Each tab gets its own accent color from your palette
  final List<Color> _tabColors = [
    AppColors.primary, // Teal  — Home
    AppColors.statusRed, // Purple — Chat
    AppColors.buttonPrimary, // Coral  — Search
    AppColors.statusOrange, // Orange — Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: _tabColors[_currentIndex],
            unselectedItemColor: AppColors.textGrey,
            selectedColorOpacity: 0.10,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            itemShape: const StadiumBorder(),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_rounded, size: 24),
                title: const Text(
                  'Home',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                selectedColor: _tabColors[0],
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite, size: 24),
                title: const Text(
                  'Matches',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                selectedColor: _tabColors[1],
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.search_rounded, size: 24),
                title: const Text(
                  'Search',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                selectedColor: _tabColors[2],
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings_rounded, size: 24),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                selectedColor: _tabColors[3],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
