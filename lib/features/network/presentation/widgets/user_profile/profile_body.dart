import 'package:flutter/material.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/screens/user_profile_screen.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/joined_section.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/profile_hero_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});
  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeroCard(user: user),
          const SizedBox(height: 16),
          EditProfileButton(user: user),
          const SizedBox(height: 24),
          if (profile != null) ...[
            AboutSection(profile: profile),
            const SizedBox(height: 16),
          ],
          JoinedSection(joinedAt: user.createdAt),
          const SizedBox(height: 16),
          QrSection(userId: user.id),
        ],
      ),
    );
  }
}
