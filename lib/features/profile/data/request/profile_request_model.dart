import 'package:memo/features/network/data/models/response/user_profile_response.dart';

class ProfileRequestModel {
  ProfileRequestModel({
    required this.headline,
    required this.bio,
    required this.profileUrl,
    required this.avatarUrl,
    required this.website,
    required this.location,
    required this.companyName,
  });

  final String headline;
  final String bio;
  final String profileUrl;
  final String avatarUrl;
  final String website;
  final String location;
  final String companyName;

  factory ProfileRequestModel.fromProfile(Profile profile) {
    return ProfileRequestModel(
      headline: profile.headline,
      bio: profile.bio,
      profileUrl: profile.profileUrl,
      avatarUrl: profile.avatarUrl,
      website: profile.website,
      location: profile.location,
      companyName: profile.companyName,
    );
  }

  Map<String, dynamic> toJson() => {
    'headline': headline,
    'bio': bio,
    'profile_url': profileUrl,
    'avatar_url': avatarUrl,
    'website': website,
    'location': location,
    'company_name': companyName,
  };
}
