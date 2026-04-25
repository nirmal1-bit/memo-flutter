import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class AvatarBadge extends StatelessWidget {
  const AvatarBadge({super.key, required this.label, this.size = 48});

  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.rubik.copyWith(
            fontSize: size * 0.28,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
