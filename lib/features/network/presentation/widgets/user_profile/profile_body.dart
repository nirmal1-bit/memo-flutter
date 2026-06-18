import 'package:flutter/material.dart';
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
          ProfileHeaderCard(user: user),
          const SizedBox(height: 16),
          if (!isOther) EditProfileButton(user: user),
          if (!isOther) ...[
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
