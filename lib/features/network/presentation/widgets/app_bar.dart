import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/widgets/network_search_bar.dart';

class NetworkAppBar extends StatefulWidget {
  const NetworkAppBar({
    super.key,
    required this.user,
    required this.controller,
    this.onTap,
    this.onActionTap,
  });

  final UserProfileResponse user;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  @override
  State<NetworkAppBar> createState() => _NetworkAppBarState();
}

class _NetworkAppBarState extends State<NetworkAppBar> {
  @override
  void initState() {
    super.initState();

    SessionService().saveUserId(widget.user.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.user.profile;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.brandBackground, width: 1.2),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 54,
              height: 54,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.72),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.softBlack.withValues(alpha: 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: profile?.avatarUrl.isNotEmpty ?? false
                    ? Image.network(
                        profile!.avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _AvatarFallback(
                          initials: _initials(widget.user.name),
                        ),
                      )
                    : _AvatarFallback(initials: _initials(widget.user.name)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: NetworkSearchBar(controller: widget.controller)),
          const SizedBox(width: 10),
          InkWell(
            onTap: widget.onActionTap,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.textDark,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.softBlack.withValues(alpha: 0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.more_horiz_rounded,
                color: AppColors.white,
                size: 26,
              ),
            ),
          ),
        ],
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

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) {
    return 'U';
  }

  final first = parts.first.isNotEmpty ? parts.first[0] : 'U';
  final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
  return (first + second).toUpperCase();
}
