// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    _UserProfileResponse(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      activated: json['activated'] as bool,
      trialLeft: (json['trial_left'] as num).toInt(),
      isPremium: json['is_premium'] as bool,
      revenueId: json['revenue_id'] as String,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileResponseToJson(
  _UserProfileResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'name': instance.name,
  'email': instance.email,
  'activated': instance.activated,
  'trial_left': instance.trialLeft,
  'is_premium': instance.isPremium,
  'revenue_id': instance.revenueId,
  'profile': instance.profile,
};

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  headline: json['headline'] as String,
  bio: json['bio'] as String,
  profileUrl: json['profile_url'] as String,
  avatarUrl: json['avatar_url'] as String?,
  location: json['location'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  interests: (json['interests'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'headline': instance.headline,
  'bio': instance.bio,
  'profile_url': instance.profileUrl,
  'avatar_url': instance.avatarUrl,
  'location': instance.location,
  'age': instance.age,
  'gender': instance.gender,
  'interests': instance.interests,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
