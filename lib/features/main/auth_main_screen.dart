import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';

class AuthMainScreen extends StatelessWidget {
  const AuthMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: AppColors.dividerColor.withOpacity(0.55),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.softBlack.withOpacity(0.08),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Memo',
                      style: AppTextStyles.libre.copyWith(
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        color: AppColors.softPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'A calm place to capture notes, revisit them, and keep your flow organized.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 15,
                        height: 1.5,
                        color: AppColors.softPrimary.withOpacity(0.72),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AuthPrimaryButton(
                label: 'Sign in',
                onPressed: () => context.go(AppRoutes.login),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.signUp),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.45),
                    width: 1.2,
                  ),
                  foregroundColor: AppColors.softPrimary,
                  backgroundColor: AppColors.white.withOpacity(0.62),
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Create account',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.softPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: Text(
                  'Continue to Memo',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.softPrimary.withOpacity(0.8),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
