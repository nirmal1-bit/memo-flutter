import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

/// A label + value row with a leading icon.
class IconRow extends StatelessWidget {
  const IconRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brandBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ironGrey,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.softBlack,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
