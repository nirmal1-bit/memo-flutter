import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memo/core/errors/app_error.dart';

part 'base_api_state.freezed.dart';

@freezed
class BaseApiState<T> with _$BaseApiState<T> {
  const factory BaseApiState.success(T data) = _Success;
  const factory BaseApiState.initial() = _Initial;
  const factory BaseApiState.loading() = _Loading;
  const factory BaseApiState.error(String message) = _Error;
  const factory BaseApiState.noInternet() = _NoInternet;
  const factory BaseApiState.validationError(ValidationError message) =
      _ValidationError;
}
