import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/network/auth_interceptor.dart';
import 'package:memo/core/session/shared_prefrences_init.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class RegisterModules {
  @singleton
  SharedPreferencesInit get sharedPreferences => SharedPreferencesInit();
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.instance;
  // https://inkflow.creativeinkflow.tech/v1/
  // http://192.168.1.150:4000/v1/

  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) =>
      Dio(
          BaseOptions(
            baseUrl: "http://10.30.198.138:4000/v1/",
            receiveTimeout: const Duration(minutes: 2),
            connectTimeout: const Duration(milliseconds: 60000),
            responseType: ResponseType.json,
            headers: <String, dynamic>{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        )
        ..interceptors.addAll([
          if (kDebugMode) PrettyDioLogger(error: true),
          authInterceptor,
        ]);
}
