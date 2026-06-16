import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';

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
    final details = connection.userProfile;
    final profile = connection.userProfile;
    final isActive = true;

    return Material(
      color: AppColors.primary.withAlpha(40),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDDE3ED), width: 0.5),
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
                                  color: const Color(0xFF1A2233),
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
                              color: const Color(0xFF8A98B8),
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
                color: Color(0xFFDDE3ED),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'Chat',
                      icon: Icons.chat_bubble_outline_rounded,
                      filled: false,
                      onPressed: onChatTap ?? onTap ?? () {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      label: 'Call',
                      icon: Icons.videocam_outlined,
                      filled: true,
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
        color: Color(0xFFE2E8F4),
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
                color: const Color(0xFF3A517A),
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
        color: isActive ? const Color(0xFFE2E8F4) : const Color(0xFFF0F2F7),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        isActive ? 'Active' : 'Pending',
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isActive ? const Color(0xFF3A517A) : const Color(0xFF8A98B8),
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
          backgroundColor: filled
              ? const Color(0xFF1A2233)
              : const Color(0xFFE2E8F4),
          foregroundColor: filled
              ? const Color(0xFFF5F7FA)
              : const Color(0xFF3A517A),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
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
