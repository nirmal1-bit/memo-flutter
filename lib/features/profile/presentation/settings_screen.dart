import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _messageAlerts = true;
  bool _darkMode = false;
  bool _autoPlayVideos = false;

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
              _HeaderCard(
                onEditProfile: () => context.push(AppRoutes.userProfile),
                onSetupProfile: () => context.push(AppRoutes.setProfile),
              ),
              const SizedBox(height: 20),
              Text(
                'Account',
                style: AppTextStyles.libre.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.softPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _SettingsGroup(
                children: [
                  _SettingsTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Profile details',
                    subtitle: 'Edit your public profile and avatar',
                    onTap: () => context.push(AppRoutes.setProfile),
                  ),
                  _SettingsTile(
                    icon: Icons.badge_outlined,
                    title: 'View profile',
                    subtitle: 'See what other people see',
                    onTap: () => context.push(AppRoutes.userProfile),
                  ),
                  _SettingsTile(
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
              _SettingsGroup(
                children: [
                  _SettingsSwitchTile(
                    icon: Icons.notifications_active_outlined,
                    title: 'Push notifications',
                    subtitle: 'Get notified about updates and requests',
                    value: _pushNotifications,
                    onChanged: (value) =>
                        setState(() => _pushNotifications = value),
                  ),
                  _SettingsSwitchTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'Message alerts',
                    subtitle: 'Receive alerts for new chat activity',
                    value: _messageAlerts,
                    onChanged: (value) =>
                        setState(() => _messageAlerts = value),
                  ),
                  _SettingsSwitchTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark mode',
                    subtitle: 'Preview the app in a darker theme',
                    value: _darkMode,
                    onChanged: (value) => setState(() => _darkMode = value),
                  ),
                  _SettingsSwitchTile(
                    icon: Icons.play_circle_outline_rounded,
                    title: 'Auto-play videos',
                    subtitle: 'Automatically play media previews',
                    value: _autoPlayVideos,
                    onChanged: (value) =>
                        setState(() => _autoPlayVideos = value),
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
              _SettingsGroup(
                children: [
                  _SettingsTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Help center',
                    subtitle: 'Get answers and troubleshooting tips',
                    onTap: () {},
                  ),
                  _SettingsTile(
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
                  onPressed: () {},
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

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.onEditProfile,
    required this.onSetupProfile,
  });

  final VoidCallback onEditProfile;
  final VoidCallback onSetupProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: AppColors.appBarGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withValues(alpha: 0.18),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.26),
                  ),
                ),
                child: Center(
                  child: Text(
                    'M',
                    style: AppTextStyles.libre.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Memo profile',
                      style: AppTextStyles.libre.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Customize your account, privacy, and preferences.',
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 13.5,
                        color: AppColors.white.withValues(alpha: 0.92),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HeaderActionButton(
                  icon: Icons.edit_outlined,
                  label: 'Edit profile',
                  onTap: onEditProfile,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeaderActionButton(
                  icon: Icons.add_card_outlined,
                  label: 'Set up profile',
                  onTap: onSetupProfile,
                  filled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: filled
                ? AppColors.white.withValues(alpha: 0.0)
                : AppColors.white.withValues(alpha: 0.24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: filled ? AppColors.primary : AppColors.white,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: filled ? AppColors.primary : AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            if (index > 0) const Divider(height: 1, thickness: 1),
            children[index],
          ],
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.brandBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.softBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12.5,
                        color: AppColors.softTextGrey,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.ironGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.brandBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.softBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 12.5,
                    color: AppColors.softTextGrey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.brandBackgroundLight,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
