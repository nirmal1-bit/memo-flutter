import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_request_model.g.dart';
part 'call_request_model.freezed.dart';

@freezed
abstract class CallRequestModel with _$CallRequestModel {
  const factory CallRequestModel({
    required String token,
    required String channel,

    @JsonKey(name: 'app_id') required String appId,

    @JsonKey(name: 'video_call_session_id') required int videoCallSessionId,
  }) = _CallRequestModel;
  factory CallRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CallRequestModelFromJson(json);
}
