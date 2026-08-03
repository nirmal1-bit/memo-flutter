import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => context.push(
          AppRoutes.setProfile,
          extra: ProfileRequestModel(
            headline: profile?.headline ?? '',
            bio: profile?.bio ?? '',
            profileUrl: profile?.profileUrl ?? '',
            location: profile?.location ?? '',
            gender: profile?.gender ?? '',
            age: profile?.age ?? 0,
            interests: profile?.interests ?? [],
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        icon: const Icon(Icons.edit_outlined, size: 18),
        label: Text(
          profile == null ? 'Set up profile' : 'Edit profile',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
