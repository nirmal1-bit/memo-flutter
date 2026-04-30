import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/widgets/avatar_badge.dart';
import 'package:memo/features/network/presentation/widgets/network_connection_card.dart';
import 'package:memo/features/network/presentation/widgets/network_widget_types.dart';

class NetworkStateView extends StatelessWidget {
  const NetworkStateView({
    super.key,
    required this.state,
    required this.emptyMessage,
    this.onConnectionTap,
    this.onChatTap,
    this.onCallTap,
    this.onSentTap,
    this.onReceivedTap,
    this.onAcceptTap,
    this.onRejectTap,
    this.onCancelTap,
    this.cardStyle = NetworkCardStyle.connections,
  });

  final BaseApiState<List<ConnectionResponse>> state;
  final String emptyMessage;
  final ValueChanged<ConnectionResponse>? onConnectionTap;
  final ValueChanged<ConnectionResponse>? onChatTap;
  final ValueChanged<ConnectionResponse>? onCallTap;
  final ValueChanged<ConnectionResponse>? onSentTap;
  final ValueChanged<ConnectionResponse>? onReceivedTap;
  final ValueChanged<ConnectionResponse>? onAcceptTap;
  final ValueChanged<ConnectionResponse>? onRejectTap;
  final ValueChanged<ConnectionResponse>? onCancelTap;
  final NetworkCardStyle cardStyle;

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => const _ListSkeleton(),
      loading: () => const _ListSkeleton(),
      success: (data) => data.isEmpty
          ? _EmptyState(message: emptyMessage)
          : Column(
              children: data.map((connection) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: switch (cardStyle) {
                    NetworkCardStyle.connections => NetworkConnectionCard(
                      connection: connection,
                      onTap: onConnectionTap == null
                          ? null
                          : () => onConnectionTap!(connection),
                      onChatTap: onChatTap == null
                          ? null
                          : () => onChatTap!(connection),
                      onCallTap: onCallTap == null
                          ? null
                          : () => onCallTap!(connection),
                    ),
                    NetworkCardStyle.sent => _SentCard(
                      connection: connection,
                      onTap: onSentTap == null
                          ? null
                          : () => onSentTap!(connection),
                      onCancelTap: onCancelTap == null
                          ? null
                          : () => onCancelTap!(connection),
                    ),
                    NetworkCardStyle.received => _ReceivedCard(
                      connection: connection,
                      onTap: onReceivedTap == null
                          ? null
                          : () => onReceivedTap!(connection),
                      onAcceptTap: onAcceptTap == null
                          ? null
                          : () => onAcceptTap!(connection),
                      onRejectTap: onRejectTap == null
                          ? null
                          : () => onRejectTap!(connection),
                    ),
                  },
                );
              }).toList(),
            ),
      error: (message) => _StatusState(
        icon: Icons.error_outline_rounded,
        title: 'Something went wrong',
        subtitle: message,
      ),
      noInternet: () => const _StatusState(
        icon: Icons.wifi_off_rounded,
        title: 'No internet',
        subtitle: 'Check your connection and try again.',
      ),
      validationError: (error) => _StatusState(
        icon: Icons.warning_amber_rounded,
        title: error.message,
        subtitle: error.errors.isNotEmpty
            ? error.errors.values.first.toString()
            : '',
      ),
    );
  }
}

class _SentCard extends StatelessWidget {
  const _SentCard({required this.connection, this.onTap, this.onCancelTap});

  final ConnectionResponse connection;
  final VoidCallback? onTap;
  final VoidCallback? onCancelTap;

  @override
  Widget build(BuildContext context) {
    final details = connection.otherUserDetails;

    return Material(
      color: AppColors.white,
      elevation: 6,
      shadowColor: AppColors.softBlack.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarBadge(
                    profileLink: details.profile?.avatarUrl ?? '',
                    label: _initials(details.name),
                    size: 52,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.name,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.softBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          details.role,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 12.5,
                            color: AppColors.ironGrey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Pending response',
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 11.5,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8C42),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'Cancel',
                      icon: Icons.cancel_outlined,
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primary,
                      borderColor: AppColors.brandBackgroundLight,
                      onPressed: onCancelTap ?? () {},
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

class _ReceivedCard extends StatelessWidget {
  const _ReceivedCard({
    required this.connection,
    this.onTap,
    this.onAcceptTap,
    this.onRejectTap,
  });

  final ConnectionResponse connection;
  final VoidCallback? onTap;
  final VoidCallback? onAcceptTap;
  final VoidCallback? onRejectTap;

  @override
  Widget build(BuildContext context) {
    final details = connection.otherUserDetails;

    return Material(
      color: AppColors.white,
      elevation: 6,
      shadowColor: AppColors.softBlack.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarBadge(
                    profileLink: details.profile?.avatarUrl ?? '',
                    label: _initials(details.name),
                    size: 52,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.name,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.softBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          details.role,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 12.5,
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
                    child: _ActionButton(
                      label: 'Accept',
                      icon: Icons.check_rounded,
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      borderColor: AppColors.primary,
                      onPressed: onAcceptTap ?? () {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      label: 'Decline',
                      icon: Icons.close_rounded,
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primary,
                      borderColor: AppColors.brandBackgroundLight,
                      onPressed: onRejectTap ?? () {},
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
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
                  fontSize: 13,
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

class _ListSkeleton extends StatefulWidget {
  const _ListSkeleton();

  @override
  State<_ListSkeleton> createState() => _ListSkeletonState();
}

class _ListSkeletonState extends State<_ListSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => _SkeletonCard(animation: _animation, index: index),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.animation, required this.index});

  final Animation<double> animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Opacity(
                opacity: animation.value - (index * 0.05),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.border.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) => Opacity(
                      opacity: animation.value,
                      child: Container(
                        width: 130,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.border.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) => Opacity(
                      opacity: animation.value * 0.7,
                      child: Container(
                        width: 90,
                        height: 11,
                        decoration: BoxDecoration(
                          color: AppColors.border.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) => Opacity(
                      opacity: animation.value * 0.5,
                      child: Container(
                        width: double.infinity,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.border.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.brandBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.people_outline_rounded,
              color: AppColors.primary,
              size: 26,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusState extends StatelessWidget {
  const _StatusState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.brandBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.softBlack,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 12,
                color: AppColors.textGrey,
                height: 1.5,
              ),
            ),
          ],
        ],
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
