import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/build_initials.dart';
import 'package:memo/features/network/data/models/response/user_search_response.dart';
import 'package:memo/features/network/presentation/widgets/network/avatar_badge.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.result,
    required this.onSendRequest,
  });

  final UserSearchResponse result;
  final VoidCallback onSendRequest;

  @override
  Widget build(BuildContext context) {
    final user = result.user;
    final profile = result.profile;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            AvatarBadge(
              profileLink: profile?.avatarUrl ?? '',
              label: buildInitials(user.name),
              size: 54,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.softBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 12.5,
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
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onSendRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Request',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
