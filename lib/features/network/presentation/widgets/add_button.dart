import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: Text(
          'Add New',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
