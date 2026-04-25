// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:memo/core/di/register_modules.dart' as _i850;
import 'package:memo/core/network/auth_interceptor.dart' as _i174;
import 'package:memo/core/network/network_info.dart' as _i509;
import 'package:memo/core/session/session_service.dart' as _i73;
import 'package:memo/core/session/shared_prefrences_init.dart' as _i876;
import 'package:memo/features/auth/domain/repository/auth_repository.dart'
    as _i1052;
import 'package:memo/features/auth/presentation/cubits/login_cubit.dart'
    as _i560;
import 'package:memo/features/auth/presentation/cubits/make_new_password_cubit.dart'
    as _i496;
import 'package:memo/features/auth/presentation/cubits/new_password_cubit.dart'
    as _i995;
import 'package:memo/features/auth/presentation/cubits/resend_token_cubit.dart'
    as _i314;
import 'package:memo/features/auth/presentation/cubits/signup_cubit.dart'
    as _i495;
import 'package:memo/features/auth/presentation/cubits/verify_token_cubit.dart'
    as _i783;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModules = _$RegisterModules();
    gh.singleton<_i876.SharedPreferencesInit>(
      () => registerModules.sharedPreferences,
    );
    gh.singleton<_i73.SessionService>(() => _i73.SessionService());
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => registerModules.connectionChecker,
    );
    gh.lazySingleton<_i174.AuthInterceptor>(
      () => _i174.AuthInterceptor(gh<_i73.SessionService>()),
    );
    gh.lazySingleton<_i509.NetworkInfo>(
      () => _i509.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModules.dio(gh<_i174.AuthInterceptor>()),
    );
    gh.lazySingleton<_i1052.AuthRepository>(
      () => _i1052.AuthRepositoryImpl(gh<_i361.Dio>(), gh<_i509.NetworkInfo>()),
    );
    gh.factory<_i560.LoginCubit>(
      () => _i560.LoginCubit(gh<_i1052.AuthRepository>()),
    );
    gh.factory<_i496.MakeNewPasswordCubit>(
      () => _i496.MakeNewPasswordCubit(gh<_i1052.AuthRepository>()),
    );
    gh.factory<_i995.NewPasswordCubit>(
      () => _i995.NewPasswordCubit(gh<_i1052.AuthRepository>()),
    );
    gh.factory<_i314.ResendTokenCubit>(
      () => _i314.ResendTokenCubit(gh<_i1052.AuthRepository>()),
    );
    gh.factory<_i495.SignupCubit>(
      () => _i495.SignupCubit(gh<_i1052.AuthRepository>()),
    );
    gh.factory<_i783.VerifyTokenCubit>(
      () => _i783.VerifyTokenCubit(gh<_i1052.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModules extends _i850.RegisterModules {}
