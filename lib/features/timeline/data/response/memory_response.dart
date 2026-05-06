import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_response.freezed.dart';
part 'memory_response.g.dart';

@freezed
abstract class MemoryResponse with _$MemoryResponse {
  const factory MemoryResponse({
    required int id,

    @JsonKey(name: 'connection_id') required int connectionId,

    @JsonKey(name: 'person_id') required int personId,

    required String content,
    required String type,

    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _MemoryResponse;

  factory MemoryResponse.fromJson(Map<String, dynamic> json) =>
      _$MemoryResponseFromJson(json);
}
