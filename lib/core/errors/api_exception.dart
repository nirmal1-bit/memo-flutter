import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_exception.freezed.dart';

@freezed
class ApiException with _$ApiException implements Exception {
  // for status code 400,500
  const factory ApiException.serverException({required String message}) =
      _ServerException;
  const factory ApiException.formatException() = _FormatException;

  //if status code is 422
  const factory ApiException.unprocessableEntity({
    required String message,
    required Map<String, dynamic> errors,
  }) = _UnprocessableEntity;

  // for status code 401
  const factory ApiException.unAuthorized() = _UnAuthorized;

  // for socket exception from server
  const factory ApiException.network() = _Network;
}
