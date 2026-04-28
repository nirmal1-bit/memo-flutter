// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_response.dart';

mixin _$UserSearchResponse {
  SearchUser get user;
  SearchProfile? get profile;
  Map<String, dynamic> toJson();
}

class _UserSearchResponse implements UserSearchResponse {
  const _UserSearchResponse({required this.user, this.profile});

  @override
  final SearchUser user;

  @override
  final SearchProfile? profile;

  @override
  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);
}

mixin _$SearchUser {
  int get id;
  DateTime get createdAt;
  String get name;
  String get email;
  bool get activated;
  String get role;
  int get trialLeft;
  bool get isPremium;
  String get revenueId;
  Map<String, dynamic> toJson();
}

class _SearchUser implements SearchUser {
  const _SearchUser({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.email,
    required this.activated,
    required this.role,
    required this.trialLeft,
    required this.isPremium,
    required this.revenueId,
  });

  @override
  final int id;

  @override
  final DateTime createdAt;

  @override
  final String name;

  @override
  final String email;

  @override
  final bool activated;

  @override
  final String role;

  @override
  final int trialLeft;

  @override
  final bool isPremium;

  @override
  final String revenueId;

  @override
  Map<String, dynamic> toJson() => _$SearchUserToJson(this);
}

mixin _$SearchProfile {
  int get id;
  int get userId;
  String get headline;
  String get bio;
  String get profileUrl;
  String get avatarUrl;
  String get website;
  String get location;
  String get companyName;
  DateTime get createdAt;
  DateTime get updatedAt;
  Map<String, dynamic> toJson();
}

class _SearchProfile implements SearchProfile {
  const _SearchProfile({
    required this.id,
    required this.userId,
    required this.headline,
    required this.bio,
    required this.profileUrl,
    required this.avatarUrl,
    required this.website,
    required this.location,
    required this.companyName,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final int id;

  @override
  final int userId;

  @override
  final String headline;

  @override
  final String bio;

  @override
  final String profileUrl;

  @override
  final String avatarUrl;

  @override
  final String website;

  @override
  final String location;

  @override
  final String companyName;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() => _$SearchProfileToJson(this);
}
