// [BaseRemoteSource] for handling network requests for dio client
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:memo/core/errors/api_exception.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/extension/api_extension.dart';
import 'package:memo/core/network/network_info.dart';
import 'package:memo/core/typedef/typedef.dart';

class BaseRemoteSource {
  BaseRemoteSource(this._dio, this._networkInfo);
  final Dio _dio;
  // final context = getIt<AppRouter>().navigatorKey.currentContext;
  final NetworkInfo _networkInfo;

  /// [T] is return type from network request
  ///
  /// [request] callback returns [Response] and accepts [Dio] instance
  ///
  /// [onResponse] callback returns [T] and accepts [dynamic] data from [Response]
  ///
  /// throws [ApiException]
  EitherResponse<T> networkRequest<T>({
    required Future<T> Function(Dio dio) request,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await request(_dio);
        return right(response);
      } on ApiException catch (e) {
        return left(
          e.when(
            serverException: (message) => AppError.serverError(error: message),
            unprocessableEntity: (message, errors) => AppError.validationError(
              validationError: ValidationError(
                message: message,
                errors: errors,
              ),
            ),
            unAuthorized: () =>
                const AppError.serverError(error: 'UnAuthorized'),
            network: () => const AppError.noInternet(error: NoInternetError()),
            formatException: () =>
                const AppError.serverError(error: 'Something went wrong'),
          ),
        );
      } on DioException catch (e) {
        return left(e.toException);
      }
    } else {
      return left(const AppError.noInternet(error: NoInternetError()));
    }
  }
}
