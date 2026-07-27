import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/profile/presentation/widgets/settings_group.dart';
import 'package:memo/features/profile/presentation/widgets/settings_switch_tile.dart';
import 'package:memo/features/profile/presentation/widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _messageAlerts = true;
  bool _darkMode = false;
  final bool _autoPlayVideos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.softPrimary,
        title: Text(
          'Settings',
          style: AppTextStyles.libre.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsGroup(
                children: [
                  SettingsTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Profile',
                    subtitle: 'Edit your public profile and avatar',
                    onTap: () => context.push(AppRoutes.setProfile),
                  ),
                  SettingsTile(
                    icon: Icons.badge_outlined,
                    title: 'View profile',
                    subtitle: 'See what other people see',
                    onTap: () => context.push(AppRoutes.userProfile),
                  ),
                  SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    title: 'Privacy',
                    subtitle: 'Control what people can discover',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Preferences',
                style: AppTextStyles.libre.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.softPrimary,
                ),
              ),
              const SizedBox(height: 12),
              SettingsGroup(
                children: [
                  SettingsSwitchTile(
                    icon: Icons.notifications_active_outlined,
                    title: 'Push notifications',
                    subtitle: 'Get notified about updates and requests',
                    value: _pushNotifications,
                    onChanged: (value) =>
                        setState(() => _pushNotifications = value),
                  ),
                  SettingsSwitchTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'Message alerts',
                    subtitle: 'Receive alerts for new chat activity',
                    value: _messageAlerts,
                    onChanged: (value) =>
                        setState(() => _messageAlerts = value),
                  ),
                  SettingsSwitchTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark mode',
                    subtitle: 'Preview the app in a darker theme',
                    value: _darkMode,
                    onChanged: (value) => setState(() => _darkMode = value),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Support',
                style: AppTextStyles.libre.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.softPrimary,
                ),
              ),
              const SizedBox(height: 12),
              SettingsGroup(
                children: [
                  SettingsTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Help center',
                    subtitle: 'Get answers and troubleshooting tips',
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About Memo',
                    subtitle: 'App version, terms, and privacy policy',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.replace(AppRoutes.login);
                    SessionService().removeToken();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.statusRed,
                    side: const BorderSide(color: AppColors.statusRed),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: Text(
                    'Sign out',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.statusRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
