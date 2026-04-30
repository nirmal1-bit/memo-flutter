import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/widgets/avatar_badge.dart';

class NetworkConnectionCard extends StatelessWidget {
  const NetworkConnectionCard({
    super.key,
    required this.connection,
    this.onTap,
    this.onChatTap,
    this.onCallTap,
  });

  final ConnectionResponse connection;
  final VoidCallback? onTap;
  final VoidCallback? onChatTap;
  final VoidCallback? onCallTap;

  @override
  Widget build(BuildContext context) {
    final details = connection.otherUserDetails;
    final profile = details.profile;
    final isActive = details.activated;

    return Material(
      color: AppColors.white,
      elevation: 6,
      shadowColor: AppColors.softBlack.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.brandBackground, AppColors.white],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarBadge(
                      profileLink: profile?.avatarUrl ?? '',
                      label: _initials(details.name),
                      size: 56,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  details.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.rubik.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.softBlack,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.primary.withOpacity(0.12)
                                      : AppColors.brandBackground,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  isActive ? 'Active' : 'Pending',
                                  style: AppTextStyles.rubik.copyWith(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            details.role,
                            style: AppTextStyles.rubik.copyWith(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ironGrey,
                            ),
                          ),
                          if ((profile?.headline ?? '').isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              profile!.headline,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 12.5,
                                color: AppColors.softTextGrey,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'Chat',
                      icon: Icons.chat_bubble_outline_rounded,
                      backgroundColor: AppColors.brandBackground,
                      foregroundColor: AppColors.primary,
                      borderColor: AppColors.brandBackground,
                      onPressed: onChatTap ?? onTap ?? () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ActionButton(
                      label: 'Call',
                      icon: Icons.videocam_rounded,
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      borderColor: AppColors.primary,
                      onPressed: onCallTap ?? onTap ?? () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: foregroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return 'N';
  final first = parts.first.isNotEmpty ? parts.first[0] : 'N';
  final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
  return (first + second).toUpperCase();
}
