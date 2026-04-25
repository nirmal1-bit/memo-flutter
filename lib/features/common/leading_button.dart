import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class LeadingButton extends StatelessWidget {
  const LeadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.primary,
          size: 18,
        ),
      ),
    );
  }
}
