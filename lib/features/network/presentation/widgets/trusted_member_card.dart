import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/presentation/widgets/avatar_badge.dart';

class TrustedMemberCard extends StatelessWidget {
  const TrustedMemberCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatarSeed,
    required this.metaLabel,
  });

  final String name;
  final String role;
  final String avatarSeed;
  final String metaLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarBadge(label: avatarSeed, size: 54),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Active',
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        metaLabel,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.ironGrey,
            ),
          ),
        ],
      ),
    );
  }
}
