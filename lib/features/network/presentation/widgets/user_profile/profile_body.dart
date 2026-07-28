import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/account_info_section.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/edit_profile_button.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/interest_section.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/profile_header_card.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/qr_section.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user, this.isOther = false});

  final UserProfileResponse user;
  final bool isOther;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isOther) ...[
            ProfileHeaderCard(user: user),
            const SizedBox(height: 16),
          ],

          if (!isOther) EditProfileButton(user: user),
          if (!isOther) ...[
            const SizedBox(height: 20),
            const _ProfileImagesSection(),
            const SizedBox(height: 16),
            AccountInfoSection(user: user),
          ],

          if (profile != null) ...[
            const SizedBox(height: 16),
            AboutSection(profile: profile),
          ],
          if (profile != null && profile.interests.isNotEmpty) ...[
            const SizedBox(height: 16),
            InterestsSection(interests: profile.interests),
          ],
          const SizedBox(height: 16),
          QrSection(userId: user.id),
        ],
      ),
    );
  }
}

class _ProfileImagesSection extends StatelessWidget {
  const _ProfileImagesSection();

  // Temporary data matching the shape of the upcoming profile-images response.
  static const _images = [
    {
      'id': '3',
      'url':
          'https://plus.unsplash.com/premium_photo-1677343210638-5d3ce6ddbf85?q=80&w=688&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'description': 'This is Me visiting places.',
    },
    {
      'id': '4',
      'url': 'https://images.unsplash.com/photo-1500534623283-312aade485b7?w=800',
      'description': 'A quiet day outdoors.',
    },
    {
      'id': '5',
      'url': 'https://images.unsplash.com/photo-150752	task?auto=format&fit=crop&w=800',
      'description': 'Making memories.',
    },
    {
      'id': '6',
      'url': 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
      'description': 'Somewhere beautiful.',
    },
    {
      'id': '7',
      'url': 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800',
      'description': 'Exploring new places.',
    },
  ];

  static const _tileColors = [
    AppColors.brandBackgroundLight,
    AppColors.memoryAmber,
    AppColors.statusLightRed,
    AppColors.chipPurpleBg,
    AppColors.chipGreenBg,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Memories',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            final image = _images[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: _tileColors[index],
                child: Image.network(
                  image['url']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 32,
                      color: AppColors.textLightDark.withValues(alpha: 0.55),
                    ),
                  ),
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary.withValues(alpha: 0.65),
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
