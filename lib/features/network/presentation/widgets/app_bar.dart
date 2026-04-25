import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';

class NetworkAppBar extends StatelessWidget {
  const NetworkAppBar({super.key, required this.user, this.onTap});

  final UserProfileResponse user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final initials = _initials(user.name);
    final hasHeadline = (profile?.headline ?? '').trim().isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary.withOpacity(0.12), AppColors.white],
            ),
            border: Border.all(color: AppColors.brandBackground),
            boxShadow: [
              BoxShadow(
                color: AppColors.softBlack.withOpacity(0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.72),
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: profile?.avatarUrl.isNotEmpty ?? false
                      ? Image.network(
                          profile!.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              _AvatarFallback(initials: initials),
                        )
                      : _AvatarFallback(initials: initials),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is you',
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.libre.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppColors.softPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.softTextGrey,
                      ),
                    ),
                    if (hasHeadline) ...[
                      const SizedBox(height: 6),
                      Text(
                        profile!.headline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 11.5,
                          color: AppColors.ironGrey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _HeaderChip(
                    label: user.activated ? 'Active' : 'Inactive',
                    icon: user.activated
                        ? Icons.check_circle_rounded
                        : Icons.pause_circle_filled_rounded,
                  ),
                  const SizedBox(height: 8),
                  _HeaderChip(
                    label: user.isPremium ? 'Premium' : 'Standard',
                    icon: user.isPremium
                        ? Icons.star_rounded
                        : Icons.badge_outlined,
                    toned: user.isPremium,
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.softTextGrey.withOpacity(0.7),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({
    required this.label,
    required this.icon,
    this.toned = false,
  });

  final String label;
  final IconData icon;
  final bool toned;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: toned ? AppColors.primary : AppColors.brandBackground,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: toned ? AppColors.white : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: toned ? AppColors.white : AppColors.primary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) {
    return 'U';
  }

  final first = parts.first.isNotEmpty ? parts.first[0] : 'U';
  final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
  return (first + second).toUpperCase();
}
