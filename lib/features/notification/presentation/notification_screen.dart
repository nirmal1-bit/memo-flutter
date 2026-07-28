import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/common/feed_back_state_widget.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/notification/cubit/get_notification_cubit.dart';
import 'package:memo/features/notification/cubit/get_unread_count_cubit.dart';
import 'package:memo/features/notification/cubit/mark_as_read_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GetNotificationCubit>()..getNotifications(),
        ),
        BlocProvider(
          create: (_) => getIt<GetUnreadCountCubit>()..getUnreadCount(),
        ),
        BlocProvider(create: (_) => getIt<MarkAsReadCubit>()),
      ],
      child: BlocListener<MarkAsReadCubit, BaseApiState<String>>(
        listener: (context, state) {
          state.maybeWhen<void>(
            success: (_) {
              context.read<GetNotificationCubit>().getNotifications();
              context.read<GetUnreadCountCubit>().getUnreadCount();
            },
            error: (message) =>
                AppUtils.showErrorSnackbar(context: context, message: message),
            validationError: (error) => AppUtils.showErrorSnackbar(
              context: context,
              message: error.message,
            ),
            noInternet: () => AppUtils.showErrorSnackbar(
              context: context,
              message: 'No internet connection',
            ),
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Notifications',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.softPrimary,
              ),
            ),
            backgroundColor: AppColors.scaffoldBackground,
          ),
          backgroundColor: AppColors.scaffoldBackground,
          body:
              BlocBuilder<
                GetNotificationCubit,
                BaseApiState<List<NotificationsResponse>>
              >(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    loading: () => const ListShimmer(),

                    success: (data) => _NotificationContent(data: data),
                    error: (message) => _NotificationError(message: message),
                    validationError: (error) =>
                        _NotificationError(message: error.message),
                    noInternet: () => const _NotificationError(
                      message: 'Check your connection and try again.',
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent({required this.data});

  final List<NotificationsResponse> data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUnreadCountCubit, BaseApiState<int>>(
      builder: (context, unreadState) {
        final unreadCount = unreadState.maybeWhen(
          success: (count) => count,
          orElse: () => data.where((item) => !item.isRead).length,
        );
        final isMarkingRead = context.select<MarkAsReadCubit, bool>(
          (cubit) =>
              cubit.state.maybeWhen(loading: () => true, orElse: () => false),
        );
        final groupedNotifications = _groupNotifications(data);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              unreadCount: unreadCount,
              onMarkAllRead: unreadCount > 0 && !isMarkingRead
                  ? () => context.read<MarkAsReadCubit>().markAsRead()
                  : null,
            ),
            if (data.isEmpty)
              const Expanded(
                child: Center(
                  child: FeedbackState(
                    icon: Icons.notifications_none_rounded,
                    title: 'No notifications yet',
                    message:
                        'When you receive notifications, they will appear here.',
                  ),
                ),
              )
            else ...[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<GetNotificationCubit>().getNotifications();
                    context.read<GetUnreadCountCubit>().getUnreadCount();
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: groupedNotifications.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final entry = groupedNotifications[index];
                      if (entry is String) {
                        return _SectionLabel(label: entry);
                      }
                      return _NotificationTile(
                        item: (entry as NotificationsResponse),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

List<Object> _groupNotifications(List<NotificationsResponse> notifications) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final grouped = <String, List<NotificationsResponse>>{};

  for (final notification in notifications) {
    final date = notification.createdAt.toLocal();
    final dateOnly = DateTime(date.year, date.month, date.day);
    final label = dateOnly == today
        ? 'Today'
        : dateOnly == yesterday
        ? 'Yesterday'
        : _formatDate(dateOnly);
    grouped.putIfAbsent(label, () => []).add(notification);
  }

  final result = <Object>[];
  for (final entry in grouped.entries) {
    result.add(entry.key);
    result.addAll(entry.value);
  }
  return result;
}

String _formatDate(DateTime date) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

class _NotificationError extends StatelessWidget {
  const _NotificationError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: FeedbackState(
      icon: Icons.error_outline_rounded,
      title: 'Could not load notifications',
      message: message,
    ),
  );
}

class _Header extends StatelessWidget {
  final int unreadCount;
  final VoidCallback? onMarkAllRead;

  const _Header({required this.unreadCount, this.onMarkAllRead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 16, 6),
      child: Row(
        children: [
          Text(
            'Unread count',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(width: 8),
          _UnreadBadge(count: unreadCount),
          const Spacer(),
          TextButton(
            onPressed: onMarkAllRead,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: Text(
              'Mark all as read',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: onMarkAllRead == null
                    ? AppColors.black.withValues(alpha: 0.35)
                    : AppColors.primary,
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
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 6),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.black.withValues(alpha: 0.4),
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
                      color: AppColors.black.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(item.createdAt),
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 11,
                      color: AppColors.black.withValues(alpha: 0.35),
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
