import 'package:flutter/material.dart';
import 'package:memo/features/ai_chat/presentation/ai_voice/ai_voice_screen.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:memo/features/auth/presentation/screens/login_screen.dart';
import 'package:memo/features/auth/presentation/screens/login_face_verification_screen.dart';
import 'package:memo/features/auth/presentation/screens/new_password_screen.dart';
import 'package:memo/features/auth/presentation/screens/signup_screen.dart';
import 'package:memo/features/auth/presentation/screens/verify_token_screen.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/features/face_verification/presentation/screens/face_verification_screen.dart';
import 'package:memo/features/face_verification/presentation/screens/face_verification_steps.dart';
import 'package:memo/features/main/onboarding_screen.dart';
import 'package:memo/features/main/main_screen.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/screens/chat_screen.dart';
import 'package:memo/features/network/presentation/screens/add_connection_screen.dart';
import 'package:memo/features/network/presentation/screens/other_user_profile.dart';
import 'package:memo/features/network/presentation/screens/qr_scanner.dart';
import 'package:memo/features/network/presentation/screens/user_profile_screen.dart';
import 'package:memo/features/notification/presentation/notification_screen.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:memo/features/profile/presentation/set_profile_screen.dart';
import 'package:memo/features/splash/splash_screen.dart';
import 'package:memo/features/timeline/presentation/time_line_screen.dart';
import 'package:memo/features/video_call/pages/video_call_screen.dart';

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
    initialLocation: AppRoutes.splash,
    routes: [
      AppRoutes.splash.route((context, state) => const SplashScreen()),
      AppRoutes.faceVerificationSteps.route(
        (context, state) => VerificationSteps(
          screens: [OnboardingScreen(), OnboardingScreen(), OnboardingScreen()],
        ),
      ),
      AppRoutes.onboarding.route((context, state) => const OnboardingScreen()),
      AppRoutes.login.route((context, state) => const LoginScreen()),
      AppRoutes.loginFaceVerification.route(
        (context, state) =>
            LoginFaceVerificationScreen(arguments: state.extra as AuthFlowArgs),
      ),
      AppRoutes.signUp.route((context, state) => const SignupScreen()),
      AppRoutes.setProfile.route(
        (context, state) => SetProfileScreen(
          initialProfile: state.extra is ProfileRequestModel
              ? state.extra as ProfileRequestModel
              : null,
        ),
      ),
      AppRoutes.addConnection.route(
        (context, state) => const AddConnectionScreen(),
      ),
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
        (context, state) => OtherUserProfile(user: state.extra as Profile),
      ),
      AppRoutes.timeLine.route((context, state) {
        return TimeLineScreen(params: state.extra as TimeLineScreenParams);
      }),

      AppRoutes.videoScreen.route(
        (context, state) =>
            VideoCallPage(params: state.extra as VideoCallPageParams),
      ),

      AppRoutes.chat.route((context, state) {
        final connection = state.extra is ConnectionResponse
            ? state.extra as ConnectionResponse
            : throw ArgumentError('Chat screen requires connection details.');
        return ChatScreen(connection: connection);
      }),

      AppRoutes.main.route((context, state) => const MainScreen()),

      AppRoutes.qrScanner.route((context, state) => const QrScannerPage()),
      AppRoutes.voice.route((context, state) {
        return AiVoiceScreen(connectionId: state.extra as int);
      }),

      AppRoutes.notifications.route(
        (context, state) => const NotificationScreen(),
      ),

      AppRoutes.verification.route(
        (context, state) => FaceVerificationScreen(),
      ),
    ],
  );
}
