import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';
import 'package:memo/features/home/presentation/widgets/profile/icon_row.dart';
import 'package:memo/features/home/presentation/widgets/profile/section_card.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final memberSince = DateFormat('MMM d, yyyy').format(user.createdAt);

    final rows = <Widget>[
      IconRow(
        icon: Icons.calendar_today_outlined,
        label: 'Member since',
        value: memberSince,
      ),
      const Divider(color: AppColors.dividerColor, height: 20),
      IconRow(
        icon: user.isPremium
            ? Icons.workspace_premium_rounded
            : Icons.star_border_rounded,
        label: 'Plan',
        value: user.isPremium ? 'Premium' : 'Free',
      ),
    ];

    if (!user.isPremium) {
      rows.addAll([
        const Divider(color: AppColors.dividerColor, height: 20),
        IconRow(
          icon: Icons.timer_outlined,
          label: 'Trial remaining',
          value: '${user.trialLeft}',
        ),
      ]);
    }

    rows.addAll([
      const Divider(color: AppColors.dividerColor, height: 20),
      IconRow(
        icon: user.activated
            ? Icons.verified_outlined
            : Icons.error_outline_rounded,
        label: 'Account status',
        value: user.activated ? 'Activated' : 'Not activated',
      ),
    ]);

    return SectionCard(
      title: 'Account',
      child: Column(children: rows),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final fields = <({String label, String value, IconData icon})>[
      if (profile.bio.isNotEmpty)
        (label: 'Bio', value: profile.bio, icon: Icons.person_outline_rounded),
      if (profile.location.isNotEmpty)
        (
          label: 'Location',
          value: profile.location,
          icon: Icons.location_on_outlined,
        ),
      if (profile.gender.isNotEmpty)
        (label: 'Gender', value: profile.gender, icon: Icons.wc_rounded),
      if (profile.age > 0)
        (
          label: 'Age',
          value: profile.age.toString(),
          icon: Icons.cake_outlined,
        ),
    ];

    if (fields.isEmpty) return const SizedBox.shrink();

    return SectionCard(
      title: 'About',
      child: Column(
        children: [
          for (int i = 0; i < fields.length; i++) ...[
            IconRow(
              icon: fields[i].icon,
              label: fields[i].label,
              value: fields[i].value,
            ),
            if (i < fields.length - 1)
              const Divider(color: AppColors.dividerColor, height: 20),
          ],
        ],
      ),
    );
  }
}
