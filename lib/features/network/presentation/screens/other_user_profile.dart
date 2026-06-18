import 'package:flutter/material.dart';
import 'package:memo/features/common/custom_app_bar.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/profile_body.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({super.key, required this.user});
  final Profile user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SafeArea(
        child: ProfileBody(
          isOther: true,
          user: UserProfileResponse(
            id: user.id,
            createdAt: user.createdAt,
            name: user.name ?? "",
            email: '',
            activated: false,
            trialLeft: 0,
            isPremium: false,
            revenueId: '',
            profile: user,
          ),
        ),
      ),
    );
  }
}
