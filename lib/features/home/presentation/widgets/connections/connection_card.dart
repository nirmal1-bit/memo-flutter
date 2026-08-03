import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';

class ConnectionCard extends StatelessWidget {
  const ConnectionCard({
    super.key,
    required this.connection,
    this.onTap,
    this.onChatTap,
    this.onQuestTap,
    this.onLongPress,
  });

  final ConnectionResponse connection;
  final VoidCallback? onTap;
  final VoidCallback? onChatTap;
  final VoidCallback? onQuestTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final details = connection.userProfile;
    final profile = connection.userProfile;
    final isActive = true;

    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.brandBackgroundLight),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Avatar(
                    avatarUrl: profile.profileUrl,
                    initials: _initials(details.name),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                details.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.rubik.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textHeading,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _StatusBadge(isActive: isActive),
                          ],
                        ),
                        const SizedBox(height: 3),

                        if ((profile.headline).isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            profile.headline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.rubik.copyWith(
                              fontSize: 14,
                              color: AppColors.textCaption,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              const Divider(
                height: 1,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'Chat / Call',
                      icon: Icons.chat_bubble_outline_rounded,
                      filled: false,
                      onPressed: onChatTap ?? onTap ?? () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      label: 'Quest',
                      icon: Icons.question_answer,
                      filled: false,
                      onPressed: onQuestTap ?? () {},
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl, required this.initials});

  final String avatarUrl;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.brandBackground,
      ),
      alignment: Alignment.center,
      child: avatarUrl.isNotEmpty
          ? ClipOval(
              child: Image.network(
                avatarUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            )
          : Text(
              initials,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textBody,
              ),
            ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? AppColors.brandBackground : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        isActive ? 'Active' : 'Pending',
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isActive ? AppColors.textBody : AppColors.textCaption,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: AppColors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
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
