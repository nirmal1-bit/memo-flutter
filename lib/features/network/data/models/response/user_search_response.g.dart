// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSearchResponse _$UserSearchResponseFromJson(Map<String, dynamic> json) =>
    _UserSearchResponse(
      user: SearchUser.fromJson(json['user'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : SearchProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSearchResponseToJson(_UserSearchResponse instance) =>
    <String, dynamic>{'user': instance.user, 'profile': instance.profile};

_SearchUser _$SearchUserFromJson(Map<String, dynamic> json) => _SearchUser(
  id: (json['id'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  name: json['name'] as String,
  email: json['email'] as String,
  activated: json['activated'] as bool,
  role: json['role'] as String,
  trialLeft: (json['trial_left'] as num).toInt(),
  isPremium: json['is_premium'] as bool,
  revenueId: json['revenue_id'] as String,
);

Map<String, dynamic> _$SearchUserToJson(_SearchUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'activated': instance.activated,
      'role': instance.role,
      'trial_left': instance.trialLeft,
      'is_premium': instance.isPremium,
      'revenue_id': instance.revenueId,
    };

_SearchProfile _$SearchProfileFromJson(Map<String, dynamic> json) =>
    _SearchProfile(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      headline: json['headline'] as String,
      bio: json['bio'] as String,
      profileUrl: json['profile_url'] as String,
      avatarUrl: json['avatar_url'] as String,
      website: json['website'] as String,
      location: json['location'] as String,
      companyName: json['company_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SearchProfileToJson(_SearchProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'headline': instance.headline,
      'bio': instance.bio,
      'profile_url': instance.profileUrl,
      'avatar_url': instance.avatarUrl,
      'website': instance.website,
      'location': instance.location,
      'company_name': instance.companyName,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
