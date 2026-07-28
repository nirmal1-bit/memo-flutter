import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/services/fcm_service.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/data/models/request/login_request_model.dart';
import 'package:memo/features/auth/data/models/response/authentication_token.dart';
import 'package:memo/features/auth/presentation/cubits/login_cubit.dart';
import 'package:memo/features/auth/presentation/models/auth_flow_args.dart';
import 'package:memo/features/face_verification/cubit/image_capture_cubit.dart';
import 'package:memo/features/face_verification/presentation/screens/face_verification_screen.dart';

/// Captures the second factor, then sends it with the original credentials to
/// `/login` as multipart form data. The backend performs the face comparison.
class LoginFaceVerificationScreen extends StatefulWidget {
  const LoginFaceVerificationScreen({super.key, required this.arguments});
  final AuthFlowArgs arguments;

  @override
  State<LoginFaceVerificationScreen> createState() =>
      _LoginFaceVerificationScreenState();
}

class _LoginFaceVerificationScreenState
    extends State<LoginFaceVerificationScreen> {
  // Bumping this forces FaceVerificationScreen (and its cubit) to remount,
  // effectively giving the user a fresh capture attempt.
  int _attempt = 0;

  void _retake() {
    setState(() => _attempt++);
  }

  @override
  Widget build(BuildContext context) {
    final request = LoginRequestModel(
      email: widget.arguments.email,
      password: widget.arguments.password,
    );

    return MultiBlocProvider(
      key: ValueKey(_attempt),
      providers: [
        BlocProvider(create: (_) => getIt<ImageCaptureCubit>()),
        BlocProvider(create: (_) => getIt<LoginCubit>()),
      ],
      child: Builder(
        builder: (providerContext) =>
            BlocListener<LoginCubit, BaseApiState<AuthenticationToken>>(
              listener: (context, state) async {
                await state.maybeWhen(
                  success: (token) async {
                    await SessionService().saveToken(token.token);
                    getIt<FCMService>().init();
                    if (context.mounted) context.go(AppRoutes.main);
                  },
                  error: (message) async => AppUtils.showErrorSnackbar(
                    context: context,
                    message: message,
                  ),
                  validationError: (error) async => AppUtils.showErrorSnackbar(
                    context: context,
                    message: error.message,
                  ),
                  noInternet: () async => AppUtils.showErrorSnackbar(
                    context: context,
                    message: 'No internet connection',
                  ),
                  orElse: () async {},
                );
              },
              child: Scaffold(
                backgroundColor: AppColors.scaffoldBackground,
                body: SafeArea(
                  child: Column(
                    children: [
                      _SecurityExplanationBanner(),
                      BlocBuilder<
                        LoginCubit,
                        BaseApiState<AuthenticationToken>
                      >(
                        builder: (context, state) {
                          final status = _statusFromState(state);
                          if (status == null) return const SizedBox.shrink();
                          return _VerificationStatusBanner(status: status);
                        },
                      ),
                      Expanded(
                        child: FaceVerificationScreen(
                          key: ValueKey('face_verification_$_attempt'),
                          onImageCaptured: (File image) => providerContext
                              .read<LoginCubit>()
                              .login(request, image: image),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _retake,
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.primary,
                            ),
                            label: Text(
                              'Retake photo',
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

  /// Maps the cubit's API state to a simple status the banner can render.
  /// Adjust the `maybeWhen` branches here if `BaseApiState` has different
  /// named states in your project (e.g. `loading`, `initial`).
  _VerificationStatus? _statusFromState(
    BaseApiState<AuthenticationToken> state,
  ) {
    return state.maybeWhen(
      loading: () => _VerificationStatus.verifying,
      success: (_) => _VerificationStatus.success,
      error: (message) => _VerificationStatus.failed(message),
      validationError: (error) => _VerificationStatus.failed(error.message),
      noInternet: () => _VerificationStatus.failed('No internet connection'),
      orElse: () => null,
    );
  }
}

/// Explains to the user why a face scan is required at login, so the
/// extra step doesn't feel like friction but like a safeguard.
class _SecurityExplanationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.brandBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.brandBackgroundLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Two-factor verification',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'We ask for a quick face scan in addition to your password '
                  'to confirm it\'s really you. This extra step keeps your '
                  'account safe even if someone else has your password.',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13,
                    color: AppColors.textLightDark,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple status model driving the status banner's look and message.
enum _VerificationStatusType { verifying, success, failed }

class _VerificationStatus {
  final _VerificationStatusType type;
  final String? message;

  const _VerificationStatus._(this.type, this.message);

  static const verifying = _VerificationStatus._(
    _VerificationStatusType.verifying,
    null,
  );
  static const success = _VerificationStatus._(
    _VerificationStatusType.success,
    null,
  );

  factory _VerificationStatus.failed(String message) =>
      _VerificationStatus._(_VerificationStatusType.failed, message);
}

/// Shows the live status of the verification attempt: checking, verified,
/// or failed with a reason.
class _VerificationStatusBanner extends StatelessWidget {
  const _VerificationStatusBanner({required this.status});
  final _VerificationStatus status;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color border;
    late final Color fg;
    late final IconData icon;
    late final String label;

    switch (status.type) {
      case _VerificationStatusType.verifying:
        bg = AppColors.brandBackground;
        border = AppColors.brandBackgroundLight;
        fg = AppColors.primary;
        icon = Icons.hourglass_top_rounded;
        label = 'Verifying your face...';
        break;
      case _VerificationStatusType.success:
        bg = AppColors.chipGreenBg;
        border = AppColors.statusGreen;
        fg = AppColors.chipGreenText;
        icon = Icons.check_circle_rounded;
        label = 'Verified! Logging you in...';
        break;
      case _VerificationStatusType.failed:
        bg = AppColors.statusLightRed;
        border = AppColors.statusRed;
        fg = AppColors.statusRed;
        icon = Icons.error_rounded;
        label = status.message ?? 'Verification failed. Please try again.';
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Container(
        key: ValueKey(status.type),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            if (status.type == _VerificationStatusType.verifying)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: fg),
              )
            else
              Icon(icon, color: fg, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
