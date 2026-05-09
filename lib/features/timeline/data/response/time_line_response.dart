import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_line_response.freezed.dart';
part 'time_line_response.g.dart';

@freezed
abstract class TimeLineResponse with _$TimeLineResponse {
  const factory TimeLineResponse({
    @JsonKey(name: 'id') required int id,

    @JsonKey(name: 'connection_id') required int connectionId,

    @JsonKey(name: 'initiated_by_user_id') required int initiatedByUserId,

    @JsonKey(name: 'agora_channel_name') required String agoraChannelName,

    @JsonKey(name: 'status') required String status,

    @JsonKey(name: 'summary') String? summary,

    @JsonKey(name: 'created_at') required DateTime createdAt,

    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _TimeLineResponse;

  factory TimeLineResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeLineResponseFromJson(json);
}
