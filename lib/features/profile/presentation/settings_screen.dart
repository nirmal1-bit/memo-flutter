import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/core/session/shared_prefrences_init.dart';
import 'package:memo/core/constants/storage_keys.dart';
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
  int _matchesRange = 4000;

  @override
  void initState() {
    super.initState();
    _matchesRange =
        SharedPreferencesInit().sharedPreferences.getInt(
          StorageKeys.matchesRange,
        ) ??
        4000;
  }

  String _rangeLabel(int meters) => '${(meters / 1000).round()} km';

  Future<void> _selectMatchesRange() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (_) => _SettingsRangePicker(initialRange: _matchesRange),
    );
    if (selected == null) return;
    await SharedPreferencesInit().sharedPreferences.setInt(
      StorageKeys.matchesRange,
      selected,
    );
    if (mounted) setState(() => _matchesRange = selected);
  }

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
                    onTap: () {
                      context.push(AppRoutes.sharedAlbum);
                    },
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
                  SettingsTile(
                    icon: Icons.near_me_outlined,
                    title: 'Match distance',
                    subtitle:
                        'Show matches within ${_rangeLabel(_matchesRange)}',
                    onTap: _selectMatchesRange,
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
                    onTap: () {
                      context.push(AppRoutes.faceVerificationSteps);
                    },
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

class _SettingsRangePicker extends StatefulWidget {
  const _SettingsRangePicker({required this.initialRange});
  final int initialRange;

  @override
  State<_SettingsRangePicker> createState() => _SettingsRangePickerState();
}

class _SettingsRangePickerState extends State<_SettingsRangePicker> {
  late double _range;

  @override
  void initState() {
    super.initState();
    _range = widget.initialRange.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final kilometers = (_range / 1000).round();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Match distance',
            style: AppTextStyles.libre.copyWith(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Show matches within $kilometers km of you.',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              color: AppColors.textLightDark,
            ),
          ),
          Slider(
            value: _range,
            min: 1000,
            max: 200000,
            divisions: 199,
            activeColor: AppColors.primary,
            label: '$kilometers km',
            onChanged: (value) => setState(() => _range = value),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, _range.round()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Save distance'),
            ),
          ),
        ],
      ),
    );
  }
}
