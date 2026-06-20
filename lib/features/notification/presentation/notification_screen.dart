import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/notification/cubit/get_notification_cubit.dart';
import 'package:memo/features/notification/data/response/notifications_response.dart';

enum NotificationType { call, message, request }

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider(
          create: (_) => getIt<GetNotificationCubit>()..getNotifications(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child:
              BlocBuilder<
                GetNotificationCubit,
                BaseApiState<List<NotificationsResponse>>
              >(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => SizedBox.shrink(),
                    loading: () => ListShimmer(),

                    success: (data) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Header(unreadCount: 3, onMarkAllRead: null),
                        const SizedBox(height: 4),
                        _SectionLabel(label: 'Today'),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: data.length,
                            separatorBuilder: (_, _) => const Divider(
                              height: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            itemBuilder: (context, index) =>
                                _NotificationTile(item: data[index]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int unreadCount;
  final VoidCallback? onMarkAllRead;

  const _Header({required this.unreadCount, this.onMarkAllRead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 8),
      child: Row(
        children: [
          Text(
            'Notifications',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.softPrimary,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: 10),
            _UnreadBadge(count: unreadCount),
          ],
          const Spacer(),
          AnimatedOpacity(
            opacity: onMarkAllRead != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: TextButton(
              onPressed: onMarkAllRead,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: const Color(0xFF534AB7),
              ),
              child: Text(
                'Mark all read',
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  final int count;
  const _UnreadBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count',
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.black.withOpacity(0.4),
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationsResponse item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: item.isRead
              ? AppColors.white
              : AppColors.primary.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NotificationIcon(type: NotificationType.call),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.body,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 13,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(item.createdAt),
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 11,
                      color: AppColors.black.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: item.isRead
                  ? const SizedBox(width: 15, key: ValueKey('read'))
                  : Container(
                      key: const ValueKey('unread'),
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(top: 6, left: 8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF7F77DD),
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class _NotificationIcon extends StatelessWidget {
  final NotificationType type;
  const _NotificationIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final (bgColor, iconColor, icon) = switch (type) {
      NotificationType.call => (
        AppColors.primary.withAlpha(122),
        AppColors.primary,
        Icons.videocam_outlined,
      ),
      NotificationType.message => (
        AppColors.white,
        AppColors.softPrimary,
        Icons.chat_bubble_outline_rounded,
      ),
      NotificationType.request => (
        AppColors.chipPurpleText,
        AppColors.white,
        Icons.person_add_alt_1_outlined,
      ),
    };

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }
}
