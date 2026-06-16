class ProfileRequestModel {
  ProfileRequestModel({
    required this.headline,
    required this.bio,
    required this.profileUrl,
    required this.location,
    required this.gender,
    required this.interests,
    required this.age,
  });

  final String headline;
  final String bio;
  final String profileUrl;
  final String location;
  final String gender;
  final int age;
  final List<String> interests;

  Map<String, dynamic> toJson() => {
    'headline': headline,
    'bio': bio,
    'age': age,
    'profile_url': profileUrl,
    'location': location,
    'gender': gender,
    'interests': interests,
  };
}
