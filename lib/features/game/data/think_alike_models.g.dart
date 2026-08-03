// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'think_alike_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThinkAlikeQuestion _$ThinkAlikeQuestionFromJson(Map<String, dynamic> json) =>
    _ThinkAlikeQuestion(
      id: (json['id'] as num).toInt(),
      question: json['question'] as String,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ThinkAlikeQuestionToJson(_ThinkAlikeQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'category': instance.category,
    };

_ThinkAlikeSession _$ThinkAlikeSessionFromJson(Map<String, dynamic> json) =>
    _ThinkAlikeSession(
      id: (json['id'] as num).toInt(),
      questionId: (json['question_id'] as num).toInt(),
      startedByUserId: (json['started_by_user_id'] as num).toInt(),
      initiatorId: (json['initiator_id'] as num).toInt(),
      partnerId: (json['partner_id'] as num).toInt(),
      question: json['question'] == null
          ? null
          : ThinkAlikeQuestion.fromJson(
              json['question'] as Map<String, dynamic>,
            ),
      initiatorAnswer: json['initiator_answer'] as String?,
      partnerAnswer: json['partner_answer'] as String?,
      status: json['status'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ThinkAlikeSessionToJson(_ThinkAlikeSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'started_by_user_id': instance.startedByUserId,
      'initiator_id': instance.initiatorId,
      'partner_id': instance.partnerId,
      'question': instance.question,
      'initiator_answer': instance.initiatorAnswer,
      'partner_answer': instance.partnerAnswer,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
