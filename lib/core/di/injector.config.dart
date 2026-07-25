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
import 'package:memo/core/services/cloudinary_service.dart' as _i1009;
import 'package:memo/core/services/device_info_helper.dart' as _i812;
import 'package:memo/core/services/fcm_service.dart' as _i714;
import 'package:memo/core/session/session_service.dart' as _i73;
import 'package:memo/core/session/shared_prefrences_init.dart' as _i876;
import 'package:memo/features/ai_chat/cubits/ai_chat_cubit.dart' as _i20;
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
import 'package:memo/features/face_verification/repository/face_repository.dart'
    as _i611;
import 'package:memo/features/matches/cubits/get_matches_cubit.dart' as _i927;
import 'package:memo/features/matches/repository/matches_repository.dart'
    as _i953;
import 'package:memo/features/network/domian/repository/network_respotory.dart'
    as _i420;
import 'package:memo/features/network/presentation/cubits/chat_cubit.dart'
    as _i228;
import 'package:memo/features/network/presentation/cubits/connection_action_cubit.dart'
    as _i575;
import 'package:memo/features/network/presentation/cubits/connections_cubit.dart'
    as _i762;
import 'package:memo/features/network/presentation/cubits/get_user_profile_cubit.dart'
    as _i680;
import 'package:memo/features/network/presentation/cubits/received_connections_cubit.dart'
    as _i382;
import 'package:memo/features/network/presentation/cubits/search_users_cubit.dart'
    as _i294;
import 'package:memo/features/network/presentation/cubits/sent_connections_cubit.dart'
    as _i636;
import 'package:memo/features/notification/cubit/get_notification_cubit.dart'
    as _i84;
import 'package:memo/features/notification/cubit/get_unread_count_cubit.dart'
    as _i11;
import 'package:memo/features/notification/cubit/mark_as_read_cubit.dart'
    as _i105;
import 'package:memo/features/notification/repository/notification_repository.dart'
    as _i915;
import 'package:memo/features/profile/presentation/cubits/edit_profile_cubit.dart'
    as _i1023;
import 'package:memo/features/profile/presentation/cubits/set_profile_cubit.dart'
    as _i1051;
import 'package:memo/features/profile/repository/profile_repository.dart'
    as _i533;
import 'package:memo/features/timeline/cubits/create_memories_cubit.dart'
    as _i910;
import 'package:memo/features/timeline/cubits/get_memories_cubit.dart' as _i426;
import 'package:memo/features/timeline/cubits/get_timeline_cubit.dart'
    as _i1049;
import 'package:memo/features/timeline/repository/timeline_repository.dart'
    as _i1029;
import 'package:memo/features/video_call/cubit/end_video_call.dart' as _i1019;
import 'package:memo/features/video_call/cubit/join_video_call_cubit.dart'
    as _i246;
import 'package:memo/features/video_call/cubit/make_transcript_cubit.dart'
    as _i937;
import 'package:memo/features/video_call/cubit/start_video_call_cubit.dart'
    as _i256;
import 'package:memo/features/video_call/repository/video_call_repository.dart'
    as _i818;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModules = _$RegisterModules();
    gh.factory<_i812.DeviceInfoHelper>(() => _i812.DeviceInfoHelper());
    gh.singleton<_i876.SharedPreferencesInit>(
      () => registerModules.sharedPreferences,
    );
    gh.singleton<_i73.SessionService>(() => _i73.SessionService());
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => registerModules.connectionChecker,
    );
    gh.lazySingleton<_i1009.CloudinaryService>(
      () => _i1009.CloudinaryService(),
    );
    gh.lazySingleton<_i174.AuthInterceptor>(
      () => _i174.AuthInterceptor(gh<_i73.SessionService>()),
    );
    gh.factory<_i714.FCMService>(
      () => _i714.FCMService(gh<_i812.DeviceInfoHelper>()),
    );
    gh.lazySingleton<_i509.NetworkInfo>(
      () => _i509.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.factory<_i20.AiChatCubit>(
      () => _i20.AiChatCubit(sessionService: gh<_i73.SessionService>()),
    );
    gh.factory<_i228.ChatCubit>(
      () => _i228.ChatCubit(sessionService: gh<_i73.SessionService>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModules.dio(gh<_i174.AuthInterceptor>()),
    );
    gh.lazySingleton<_i420.NetworkRepository>(
      () =>
          _i420.NetworkRepositoryImpl(gh<_i361.Dio>(), gh<_i509.NetworkInfo>()),
    );
    gh.lazySingleton<_i1052.AuthRepository>(
      () => _i1052.AuthRepositoryImpl(gh<_i361.Dio>(), gh<_i509.NetworkInfo>()),
    );
    gh.lazySingleton<_i1029.TimelineRepository>(
      () => _i1029.TimelineRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i509.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i611.FaceRepository>(
      () => _i611.FaceRepositoryImpl(gh<_i361.Dio>(), gh<_i509.NetworkInfo>()),
    );
    gh.lazySingleton<_i818.VideoCallRepository>(
      () => _i818.VideoCallRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i509.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i953.MatchesRepository>(
      () =>
          _i953.MatchesRepositoryImpl(gh<_i361.Dio>(), gh<_i509.NetworkInfo>()),
    );
    gh.factory<_i927.GetMatchesCubit>(
      () => _i927.GetMatchesCubit(gh<_i953.MatchesRepository>()),
    );
    gh.lazySingleton<_i533.ProfileRepository>(
      () =>
          _i533.ProfileRepositoryImpl(gh<_i361.Dio>(), gh<_i509.NetworkInfo>()),
    );
    gh.factory<_i910.CreateMemoriesCubit>(
      () => _i910.CreateMemoriesCubit(gh<_i1029.TimelineRepository>()),
    );
    gh.factory<_i426.GetMemoriesCubit>(
      () => _i426.GetMemoriesCubit(gh<_i1029.TimelineRepository>()),
    );
    gh.factory<_i1049.GetTimelineCubit>(
      () => _i1049.GetTimelineCubit(gh<_i1029.TimelineRepository>()),
    );
    gh.lazySingleton<_i915.NotificationRepository>(
      () => _i915.NotificationRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i509.NetworkInfo>(),
      ),
    );
    gh.factory<_i1023.EditProfileCubit>(
      () => _i1023.EditProfileCubit(gh<_i533.ProfileRepository>()),
    );
    gh.factory<_i1051.SetProfileCubit>(
      () => _i1051.SetProfileCubit(gh<_i533.ProfileRepository>()),
    );
    gh.factory<_i575.ConnectionActionCubit>(
      () => _i575.ConnectionActionCubit(gh<_i420.NetworkRepository>()),
    );
    gh.factory<_i762.ConnectionsCubit>(
      () => _i762.ConnectionsCubit(gh<_i420.NetworkRepository>()),
    );
    gh.factory<_i680.GetUserProfileCubit>(
      () => _i680.GetUserProfileCubit(gh<_i420.NetworkRepository>()),
    );
    gh.factory<_i382.ReceivedConnectionsCubit>(
      () => _i382.ReceivedConnectionsCubit(gh<_i420.NetworkRepository>()),
    );
    gh.factory<_i294.SearchUsersCubit>(
      () => _i294.SearchUsersCubit(gh<_i420.NetworkRepository>()),
    );
    gh.factory<_i636.SentConnectionsCubit>(
      () => _i636.SentConnectionsCubit(gh<_i420.NetworkRepository>()),
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
    gh.factory<_i1019.EndVideoCall>(
      () => _i1019.EndVideoCall(
        videoCallRemoteSource: gh<_i818.VideoCallRepository>(),
      ),
    );
    gh.factory<_i246.JoinVideoCallCubit>(
      () => _i246.JoinVideoCallCubit(
        videoCallRemoteSource: gh<_i818.VideoCallRepository>(),
      ),
    );
    gh.factory<_i937.MakeTranscriptCubit>(
      () => _i937.MakeTranscriptCubit(
        videoCallRemoteSource: gh<_i818.VideoCallRepository>(),
      ),
    );
    gh.factory<_i256.StartVideoCallCubit>(
      () => _i256.StartVideoCallCubit(
        videoCallRemoteSource: gh<_i818.VideoCallRepository>(),
      ),
    );
    gh.factory<_i84.GetNotificationCubit>(
      () => _i84.GetNotificationCubit(gh<_i915.NotificationRepository>()),
    );
    gh.factory<_i11.GetUnreadCountCubit>(
      () => _i11.GetUnreadCountCubit(gh<_i915.NotificationRepository>()),
    );
    gh.factory<_i105.MarkAsReadCubit>(
      () => _i105.MarkAsReadCubit(gh<_i915.NotificationRepository>()),
    );
    return this;
  }
}

class _$RegisterModules extends _i850.RegisterModules {}
