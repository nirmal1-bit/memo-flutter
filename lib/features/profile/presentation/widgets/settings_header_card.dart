import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class SettingsHeaderCard extends StatelessWidget {
  const SettingsHeaderCard({
    super.key,
    required this.title,
    required this.description,
    required this.onEditProfile,
    required this.onSetupProfile,
  });

  final String title;
  final String description;
  final VoidCallback onEditProfile;
  final VoidCallback onSetupProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: AppColors.appBarGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withValues(alpha: 0.18),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.26),
                  ),
                ),
                child: Center(
                  child: Text(
                    'M',
                    style: AppTextStyles.libre.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.libre.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 13.5,
                        color: AppColors.white.withValues(alpha: 0.92),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HeaderActionButton(
                  icon: Icons.edit_outlined,
                  label: 'Edit profile',
                  onTap: onEditProfile,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeaderActionButton(
                  icon: Icons.add_card_outlined,
                  label: 'Set up profile',
                  onTap: onSetupProfile,
                  filled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: filled
                ? AppColors.white.withValues(alpha: 0.0)
                : AppColors.white.withValues(alpha: 0.24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: filled ? AppColors.primary : AppColors.white,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: filled ? AppColors.primary : AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
