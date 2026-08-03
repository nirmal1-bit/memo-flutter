import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class ThinkAlikeActionButton extends StatelessWidget {
  const ThinkAlikeActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? const LinearGradient(
                    colors: [AppColors.primary, AppColors.buttonPrimary],
                  )
                : null,
            color: isPrimary ? null : AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: isPrimary
                ? null
                : Border.all(
                    color: AppColors.border.withOpacity(0.5),
                    width: 1.5,
                  ),
            boxShadow: [
              BoxShadow(
                color: (isPrimary ? AppColors.primary : AppColors.shadow)
                    .withOpacity(isPrimary ? 0.25 : 0.15),
                blurRadius: isPrimary ? 16 : 8,
                offset: Offset(0, isPrimary ? 6 : 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isPrimary ? AppColors.white : AppColors.textDark,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isPrimary ? AppColors.white : AppColors.textDark,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
