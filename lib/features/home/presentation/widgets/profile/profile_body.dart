import 'package:flutter/material.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';
import 'package:memo/features/home/presentation/widgets/profile/account_info_section.dart';
import 'package:memo/features/home/presentation/widgets/profile/edit_profile_button.dart';
import 'package:memo/features/home/presentation/widgets/profile/interest_section.dart';
import 'package:memo/features/home/presentation/widgets/profile/profile_header_card.dart';
import 'package:memo/features/home/presentation/widgets/profile/qr_section.dart';
import 'package:memo/features/home/presentation/widgets/profile/recent_pictures_section.dart';

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

          RecentPicturesSection(
            userId: user.id,
            showAddAlbumPlaceholder: !isOther,
            showDelete: !isOther,
          ),
          if (!isOther) ...[
            const SizedBox(height: 20),
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
