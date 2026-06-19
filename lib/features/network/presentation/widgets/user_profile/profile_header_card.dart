import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/profile_avatar.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/status_badge.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ProfileAvatar(imageUrl: profile?.profileUrl, size: 84),
          const SizedBox(height: 14),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.libre.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.softPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.softPrimary.withOpacity(0.6),
            ),
          ),
          if (profile != null && profile.headline.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              profile.headline,
              textAlign: TextAlign.center,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              RoleBadge(
                label: user.isPremium ? 'Premium' : 'Free Plan',
                icon: user.isPremium
                    ? Icons.workspace_premium_rounded
                    : Icons.person_outline_rounded,
                color: user.isPremium
                    ? AppColors.primary
                    : AppColors.softPrimary,
              ),
              if (user.activated)
                const RoleBadge(
                  label: 'Verified',
                  icon: Icons.verified_rounded,
                  color: Colors.green,
                ),
              if (!user.isPremium)
                RoleBadge(
                  label: '${user.trialLeft} trial left',
                  icon: Icons.timer_outlined,
                  color: AppColors.softPrimary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
