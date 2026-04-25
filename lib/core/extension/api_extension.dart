import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:memo/core/errors/app_error.dart';

extension ApiExceptionDioX on DioException {
  AppError get toException {
    if (kDebugMode) {
      print(error);
    }
    switch (type) {
      case DioExceptionType.badResponse:
        final code = response?.statusCode!;
        if (code == 403) {
          return AppError.serverError(
            error: (response?.data['message'] as String?) ?? message!,
          );
        }
        if (code == 418) {
          return AppError.serverError(
            error: (response?.data['message'] as String?) ?? message!,
          );
        }
        if (code == 404) {
          return AppError.serverError(
            error: (response?.data['message'] as String?) ?? message!,
          );
        } else if (code == 400) {
          return AppError.serverError(
            error: response?.data['message'] as String,
          );
        } else {
          return AppError.serverError(
            error: response?.data['message'] as String,
          );
        }
      case DioExceptionType.connectionTimeout:
        if (error is SocketException) {
          return const AppError.noInternet(error: NoInternetError());
        } else {
          return AppError.serverError(
            error: response?.data['message'] as String,
          );
        }
      default:
        if (kDebugMode) {
          print(type);
        }
        return AppError.serverError(error: response?.data['message'] as String);
    }
  }
}
