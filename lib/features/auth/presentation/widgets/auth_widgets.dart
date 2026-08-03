import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.showBackButton = false,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5F7F7), Color(0xFFEAF2F2), Color(0xFFFDF7F1)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -70,
            right: -40,
            child: _GlowCircle(color: AppColors.primary.withOpacity(0.16)),
          ),
          Positioned(
            bottom: 120,
            left: -60,
            child: _GlowCircle(
              color: AppColors.buttonPrimary.withOpacity(0.14),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (showBackButton)
                        IconButton(
                          onPressed:
                              onBack ?? () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          color: AppColors.textHeading,
                        )
                      else
                        const SizedBox(width: 48, height: 48),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.dividerColor.withOpacity(0.7),
                          ),
                        ),
                        child: Text(
                          'MEMO',
                          style: AppTextStyles.libre.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.8,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    title,
                    style: AppTextStyles.libre.copyWith(
                      fontSize: 40,
                      height: 1.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textHeading,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 15,
                      height: 1.45,
                      color: AppColors.textBody,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.94),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: AppColors.dividerColor.withOpacity(0.55),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.softBlack.withOpacity(0.08),
                          blurRadius: 32,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          disabledBackgroundColor: AppColors.primary.withOpacity(0.55),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  letterSpacing: 0.25,
                ),
              ),
      ),
    );
  }
}

class AuthTextLink extends StatelessWidget {
  const AuthTextLink({
    super.key,
    required this.label,
    required this.onPressed,
    this.alignment = Alignment.center,
    this.color,
    this.fontWeight = FontWeight.w600,
  });

  final String label;
  final VoidCallback onPressed;
  final Alignment alignment;
  final Color? color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTextStyles.rubik.copyWith(
            fontSize: 14,
            fontWeight: fontWeight,
            color: color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
