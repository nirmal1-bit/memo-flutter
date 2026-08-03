import 'package:freezed_annotation/freezed_annotation.dart';

part 'think_alike_models.freezed.dart';
part 'think_alike_models.g.dart';

@freezed
abstract class ThinkAlikeQuestion with _$ThinkAlikeQuestion {
  const factory ThinkAlikeQuestion({
    required int id,
    required String question,
    String? category,
  }) = _ThinkAlikeQuestion;

  factory ThinkAlikeQuestion.fromJson(Map<String, dynamic> json) =>
      _$ThinkAlikeQuestionFromJson(json);
}

@freezed
abstract class ThinkAlikeSession with _$ThinkAlikeSession {
  const factory ThinkAlikeSession({
    required int id,
    @JsonKey(name: 'question_id') required int questionId,
    @JsonKey(name: 'started_by_user_id') required int startedByUserId,
    @JsonKey(name: 'initiator_id') required int initiatorId,
    @JsonKey(name: 'partner_id') required int partnerId,
    ThinkAlikeQuestion? question,
    @JsonKey(name: 'initiator_answer') String? initiatorAnswer,
    @JsonKey(name: 'partner_answer') String? partnerAnswer,
    required String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ThinkAlikeSession;

  factory ThinkAlikeSession.fromJson(Map<String, dynamic> json) =>
      _$ThinkAlikeSessionFromJson(json);
}
