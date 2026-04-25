import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/presentation/widgets/action_button.dart';
import 'package:memo/features/network/presentation/widgets/avatar_badge.dart';

class PendingRequestCard extends StatelessWidget {
  const PendingRequestCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatarSeed,
  });

  final String name;
  final String role;
  final String avatarSeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarBadge(label: avatarSeed),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.softBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.ironGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  label: 'Accept',
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  borderColor: AppColors.primary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ActionButton(
                  label: 'Decline',
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
