import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class ConnectionAddButton extends StatelessWidget {
  const ConnectionAddButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.buttonPrimary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.add_rounded, color: AppColors.white, size: 22),
      ),
    );
  }
}
