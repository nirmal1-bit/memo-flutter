import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class DistanceBadge extends StatelessWidget {
  const DistanceBadge({super.key, required this.distance});

  final double distance;

  @override
  Widget build(BuildContext context) {
    final label = '${distance.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '')} km';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.softPrimary.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.near_me_outlined, size: 16, color: AppColors.white),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.rubik.copyWith(
            color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w700,
          )),
        ],
      ),
    );
  }
}
