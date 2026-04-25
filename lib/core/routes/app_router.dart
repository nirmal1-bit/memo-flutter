import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:memo/features/auth/presentation/screens/login_screen.dart';
import 'package:memo/features/auth/presentation/screens/new_password_screen.dart';
import 'package:memo/features/auth/presentation/screens/signup_screen.dart';
import 'package:memo/features/auth/presentation/screens/verify_token_screen.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/features/main/auth_main_screen.dart';
import 'package:memo/features/main/main_screen.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/cubits/chat_cubit.dart';
import 'package:memo/features/network/presentation/screens/chat_screen.dart';
import 'package:memo/features/network/presentation/screens/others_user_profile.dart';
import 'package:memo/features/network/presentation/screens/user_profile_screen.dart';
import 'package:memo/core/session/session_service.dart';

// extension cannot be defined inside a class it has to be outside the class must
//be top level function
// here the method or extension being defined is called routes so we
// now can we any sting.route and call this func and it returns the things
// and the GoRoutes is a label defined for readability

extension GoRoutes on String {
  GoRoute route(Widget Function(BuildContext, GoRouterState) builder) {
    return GoRoute(path: this, name: substring(1), builder: builder);
  }
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.main,
    routes: [
      AppRoutes.authMain.route((context, state) => const AuthMainScreen()),
      AppRoutes.login.route((context, state) => const LoginScreen()),
      AppRoutes.signUp.route((context, state) => const SignupScreen()),
      AppRoutes.verifyToken.route(
        (context, state) => VerifyTokenScreen(
          arguments: state.extra is AuthFlowArgs
              ? state.extra as AuthFlowArgs
              : null,
        ),
      ),
      AppRoutes.forgetPassword.route(
        (context, state) => const ForgetPasswordScreen(),
      ),
      AppRoutes.newPassword.route(
        (context, state) => NewPasswordScreen(
          arguments: state.extra is AuthFlowArgs
              ? state.extra as AuthFlowArgs
              : null,
        ),
      ),
      AppRoutes.userProfile.route(
        (context, state) => const UserProfileScreen(),
      ),
      AppRoutes.otherUserProfile.route(
        (context, state) => OthersUserProfileScreen(
          details: state.extra is OtherUserProfileArguments
              ? (state.extra as OtherUserProfileArguments).details
              : state.extra is OtherUserDetails
              ? state.extra as OtherUserDetails
              : null,
          isFromReceived: state.extra is OtherUserProfileArguments
              ? (state.extra as OtherUserProfileArguments).isFromReceived
              : false,
          isFromSent: state.extra is OtherUserProfileArguments
              ? (state.extra as OtherUserProfileArguments).isFromSent
              : false,
        ),
      ),
      AppRoutes.chat.route((context, state) {
        final connection = state.extra is ConnectionResponse
            ? state.extra as ConnectionResponse
            : throw ArgumentError('Chat screen requires connection details.');

        return BlocProvider(
          create: (_) => ChatCubit(
            connection: connection,
            sessionService: getIt<SessionService>(),
          )..connect(),
          child: ChatScreen(connection: connection),
        );
      }),
      AppRoutes.main.route((context, state) => const MainScreen(title: 'Main')),
      AppRoutes.onboarding.route(
        (context, state) =>
            const Scaffold(body: Center(child: Text('Onboarding screen'))),
      ),
    ],
  );
}
