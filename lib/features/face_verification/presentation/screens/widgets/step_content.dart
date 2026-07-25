import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class StepContent extends StatelessWidget {
  final int stepIndex;
  const StepContent({super.key, required this.stepIndex});

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
    ),

    ContentMeta(
      icon: Icons.camera_alt_outlined,
      title: 'Position your face',
      body:
          'Look straight at the camera in a well-lit space.\n'
          'Hold still while we capture your photo.',
      color: AppColors.chipGreenBg,
      iconColor: AppColors.chipGreenText,
    ),
    ContentMeta(
      icon: Icons.image_search_rounded,
      title: 'Reviewing photo',
      body:
          'We\'re checking your photo against your profile.\n'
          'This usually takes just a few seconds.',
      color: AppColors.chipPurpleBg,
      iconColor: AppColors.chipPurpleText,
    ),
    ContentMeta(
      icon: Icons.verified_rounded,
      title: 'You are verified!',
      body:
          'Your identity has been confirmed.\n'
          'You can now access all features.',
      color: AppColors.chipGreenBg,
      iconColor: AppColors.statusGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final meta = _content[stepIndex];
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: meta.color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(meta.icon, size: 58, color: meta.iconColor),
          ),
          const SizedBox(height: 26),
          Text(
            meta.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            meta.body,
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
  const ContentMeta({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    required this.iconColor,
  });
}
