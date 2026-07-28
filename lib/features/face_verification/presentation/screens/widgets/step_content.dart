import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/face_verification/cubit/verify_face_cubit.dart';
import 'package:memo/features/face_verification/data/face_verify_response.dart';

class StepContent extends StatelessWidget {
  final int stepIndex;
  const StepContent({super.key, required this.stepIndex});

  bool checkError(FaceVerifyResponse? data, int stepIndex) {
    if (stepIndex == 4 && data != null && !data.verified) {
      return true;
    }
    return false;
  }

  static const _content = [
    ContentMeta(
      icon: Icons.privacy_tip_outlined,
      title: 'Your privacy, protected',
      body:
          'We don\'t store your photo.\n'
          'Instead, we convert it into an embedding, a\n'
          'mathematical representation, and compare it\n'
          'with your profile embedding.\n'
          'The image itself is never saved.',
      color: AppColors.brandBackground,
      iconColor: AppColors.primary,
      filePath: 'assets/animations/safe.json',
    ),
    ContentMeta(
      icon: Icons.shield_outlined,
      title: 'Verify your identity',
      body:
          'We\'ll use your camera to confirm it\'s really you.\n'
          'This keeps your account safe and secure,\n'
          'and keeps bad actors out.',
      color: AppColors.brandBackground,
      iconColor: AppColors.primary,
      filePath: 'assets/animations/face_verification.json',
    ),

    //this is extra to  out the  face verification screen
    ContentMeta(
      icon: Icons.camera_alt_outlined,
      title: 'Position your face',
      body:
          'Look straight at the camera in a well-lit space.\n'
          'Hold still while we capture your photo.',
      color: AppColors.chipGreenBg,
      iconColor: AppColors.chipGreenText,
      filePath: 'assets/animations/position.json',
    ),

    ContentMeta(
      icon: Icons.camera_alt_outlined,
      title: 'Position your face',
      body:
          'Look straight at the camera in a well-lit space.\n'
          'Hold still while we capture your photo.',
      color: AppColors.chipGreenBg,
      iconColor: AppColors.chipGreenText,
      filePath: '',
    ),
    ContentMeta(
      icon: Icons.image_search_rounded,
      title: 'Reviewing photo',
      body:
          'We\'re checking your photo against your profile.\n'
          'This usually takes just a few seconds.',
      color: AppColors.chipPurpleBg,
      iconColor: AppColors.chipPurpleText,
      filePath: 'assets/animations/loading.json',
    ),
    ContentMeta(
      icon: Icons.verified_rounded,
      title: 'You are verified!',
      body:
          'Your identity has been confirmed.\n'
          'You can now access all features.',
      color: AppColors.chipGreenBg,
      iconColor: AppColors.statusGreen,
      filePath: 'assets/animations/check.json',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final meta = _content[stepIndex];
    return BlocBuilder<VerifyFaceCubit, BaseApiState<FaceVerifyResponse>>(
      builder: (context, state) {
        var data = state.maybeWhen(orElse: () => null, success: (data) => data);

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 228,
                height: 228,
                child: !checkError(data, stepIndex)
                    ? Lottie.asset(meta.filePath)
                    : Lottie.asset("assets/animations/failed.json"),
              ),
              const SizedBox(height: 26),
              Text(
                !checkError(data, stepIndex)
                    ? meta.title
                    : "Verification failed",
                textAlign: TextAlign.center,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                !checkError(data, stepIndex)
                    ? meta.body
                    : "We couldn't verify your identity. \n Please try again. Make sure you're in a well-lit area and your \n face is clearly visible.",
                textAlign: TextAlign.center,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 15,
                  height: 1.6,
                  color: AppColors.textLightDark,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Data classes ─────────────────────────────────────────────────
class StepMeta {
  final IconData icon;
  final String label;
  const StepMeta({required this.icon, required this.label});
}

class ContentMeta {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  final Color iconColor;
  final String filePath;
  const ContentMeta({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    required this.iconColor,
    required this.filePath,
  });
}
