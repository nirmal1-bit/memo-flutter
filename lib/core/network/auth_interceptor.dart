import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../session/session_service.dart';

@lazySingleton
class AuthInterceptor extends QueuedInterceptorsWrapper {
  AuthInterceptor(this._service);

  final SessionService _service;
  // final _router = AppRouter().current.router.curren

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
    //   final options = err.requestOptions;
    //   final accessToken = await _tokenService.refreshToken();
    //   if (accessToken == null || accessToken.isEmpty) {
    //     return handler.reject(err);
    //   } else {
    //     options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    //     try {
    //       final _res = await _tokenService.fetch(options);
    //       return handler.resolve(_res);
    //     } on DioException catch (e) {
    //       handler.next(e);
    //       return;
    //     }
    //   }
    // }
    if (err.response?.statusCode == 401) {}
    handler.reject(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hasSession = await _service.hasSession;
    if (hasSession) {
      final token = await _service.token;
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
