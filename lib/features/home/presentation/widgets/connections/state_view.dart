import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/build_initials.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/home/presentation/cubits/connections_cubit.dart';
import 'package:memo/features/home/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/home/presentation/cubits/received_connections_cubit.dart';
import 'package:memo/features/home/presentation/cubits/sent_connections_cubit.dart';
import 'package:memo/features/home/presentation/widgets/connections/avatar_badge.dart';
import 'package:memo/features/home/presentation/widgets/connections/connection_card.dart';
import 'package:memo/features/home/presentation/widgets/connections/widget_types.dart';

class ConnectionsStateView extends StatelessWidget {
  const ConnectionsStateView({
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
    this.cardStyle = ConnectionCardStyle.connections,
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
  final ConnectionCardStyle cardStyle;

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => const ListShimmer(),
      loading: () => const ListShimmer(),
      success: (data) => data.isEmpty
          ? _EmptyState(message: emptyMessage)
          : RefreshIndicator(
              onRefresh: () async {
                context.read<ConnectionsCubit>().listConnections();
                context.read<SentConnectionsCubit>().listSentConnections();
                context
                    .read<ReceivedConnectionsCubit>()
                    .listReceivedConnections();
                context.read<GetUserProfileCubit>().getUserProfile();
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final connection = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: switch (cardStyle) {
                      ConnectionCardStyle.connections => ConnectionCard(
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
                      ConnectionCardStyle.sent => _SentCard(
                        connection: connection,
                        onTap: onSentTap == null
                            ? null
                            : () => onSentTap!(connection),
                        onCancelTap: onCancelTap == null
                            ? null
                            : () => onCancelTap!(connection),
                      ),
                      ConnectionCardStyle.received => _ReceivedCard(
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
                },
              ),
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
    final details = connection.userProfile;
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerColor, width: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarBadge(
                    profileLink: details.profileUrl,
                    label: buildInitials(details.name),
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.name,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Pending response',
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.statusOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCancelTap,
                  icon: const Icon(Icons.close, size: 15),
                  label: const Text('Cancel request'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textLightDark,
                    side: const BorderSide(
                      color: AppColors.dividerColor,
                      width: 0.5,
                    ),

                    padding: const EdgeInsets.symmetric(vertical: 9),
                    textStyle: AppTextStyles.rubik.copyWith(fontSize: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
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
    final details = connection.userProfile;
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerColor, width: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarBadge(
                    profileLink: details.profileUrl,
                    label: buildInitials(details.name),
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      details.name,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onAcceptTap,
                      icon: const Icon(Icons.check_rounded, size: 15),
                      label: const Text('Accept'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        textStyle: AppTextStyles.rubik.copyWith(fontSize: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onRejectTap,
                      icon: const Icon(Icons.close_rounded, size: 15),
                      label: const Text('Decline'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textLightDark,
                        side: const BorderSide(
                          color: AppColors.dividerColor,
                          width: 0.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        textStyle: AppTextStyles.rubik.copyWith(fontSize: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
