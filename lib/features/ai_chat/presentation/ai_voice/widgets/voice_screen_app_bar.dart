import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class VoiceScreenAppBar extends StatelessWidget {
  const VoiceScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.darkElevatedSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.white,
                size: 16,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'AI Voice',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              letterSpacing: 0.4,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40), // visual balance
        ],
      ),
    );
  }
}
