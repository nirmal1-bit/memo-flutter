import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class PermissionBanner extends StatelessWidget {
  const PermissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.statusLightRed.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.statusRed.withOpacity(0.4)),
      ),
      child: const Row(
        children: [
          Icon(Icons.mic_off_rounded, color: AppColors.statusRed, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Microphone permission is required. Please enable it in settings.',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                color: AppColors.statusRed,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
