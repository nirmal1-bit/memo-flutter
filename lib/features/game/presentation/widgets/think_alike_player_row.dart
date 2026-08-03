import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/game/presentation/widgets/game_player_avatar.dart';

class ThinkAlikePlayerRow extends StatelessWidget {
  const ThinkAlikePlayerRow({
    super.key,
    required this.initiatorName,
    required this.partnerName,
    required this.initiatorStatus,
    required this.partnerStatus,
    required this.showConnector,
    this.userProfileUrl,
    this.partnerProfileUrl,
  });

  final String initiatorName;
  final String partnerName;
  final String initiatorStatus;
  final String partnerStatus;
  final bool showConnector;
  final String? userProfileUrl;
  final String? partnerProfileUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PlayerCard(
            name: initiatorName,
            status: initiatorStatus,
            isInitiator: true,
            userProfileUrl: userProfileUrl,
            partnerProfileUrl: partnerProfileUrl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: showConnector
              ? Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.brandBackground,
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.5),
                    ),
                  ),
                  child: const Icon(
                    Icons.sync_alt_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                )
              : const Text(
                  'vs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textCaption,
                  ),
                ),
        ),
        Expanded(
          child: _PlayerCard(
            name: partnerName,
            status: partnerStatus,
            isInitiator: false,
            userProfileUrl: userProfileUrl,
            partnerProfileUrl: partnerProfileUrl,
          ),
        ),
      ],
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    required this.name,
    required this.status,
    required this.isInitiator,
    this.userProfileUrl,
    this.partnerProfileUrl,
  });

  final String name;
  final String status;
  final bool isInitiator;
  final String? userProfileUrl;
  final String? partnerProfileUrl;

  @override
  Widget build(BuildContext context) {
    final isReady = status.contains('✓') || status == 'Ready';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isReady
              ? AppColors.statusGreen.withOpacity(0.3)
              : AppColors.border.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          GamePlayerAvatar(
            name: name,
            imageUrl: isInitiator ? userProfileUrl : partnerProfileUrl,
            size: 44,
            showGlow: !isReady && !status.contains('Pending'),
            glowColor: isInitiator ? AppColors.primary : AppColors.accentRose,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isReady ? AppColors.chipGreenBg : AppColors.chipPurpleBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isReady
                    ? AppColors.chipGreenText
                    : AppColors.chipPurpleText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
