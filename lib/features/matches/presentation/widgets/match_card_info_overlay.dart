import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/constants/app_text_styles.dart';
import 'match_card_data.dart';

class MatchCardInfoOverlay extends StatelessWidget {
  final MatchCardData data;

  const MatchCardInfoOverlay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 170),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name + activated badge
          Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      data.name,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (data.activated) ...[
                    const SizedBox(width: 8),
                    _ActivatedBadge(),
                  ],
                ],
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 300.ms)
              .slideX(begin: -0.05, end: 0),

          const SizedBox(height: 4),

          // Headline
          Text(
                data.headline,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.9),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
              .animate()
              .fadeIn(delay: 280.ms, duration: 300.ms)
              .slideX(begin: -0.05, end: 0),

          const SizedBox(height: 12),

          // Chips row
          Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  if (data.companyName.isNotEmpty)
                    _InfoChip(
                      icon: Icons.business_outlined,
                      label: data.companyName,
                      bgColor: AppColors.chipPurpleBg.withOpacity(0.9),
                      textColor: AppColors.chipPurpleText,
                    ),
                  if (data.location.isNotEmpty)
                    _InfoChip(
                      icon: Icons.location_on_outlined,
                      label: data.location,
                      bgColor: AppColors.chipGreenBg.withOpacity(0.9),
                      textColor: AppColors.chipGreenText,
                    ),
                  if (data.role.isNotEmpty)
                    _InfoChip(
                      icon: Icons.work_outline,
                      label: data.role,
                      bgColor: AppColors.chipOrangeBg.withOpacity(0.9),
                      textColor: AppColors.chipOrangeText,
                    ),
                ],
              )
              .animate()
              .fadeIn(delay: 360.ms, duration: 300.ms)
              .slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }
}

class _ActivatedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.statusGreen.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified, color: AppColors.white, size: 13),
          const SizedBox(width: 3),
          Text(
            'Active',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
