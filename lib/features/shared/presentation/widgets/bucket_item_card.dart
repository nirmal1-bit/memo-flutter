import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/shared/data/bucket_category.dart';
import 'package:memo/features/shared/data/response/bucket_item_response.dart';

class BucketItemCard extends StatelessWidget {
  const BucketItemCard({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  final BucketItemResponse item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final category = BucketCategory.fromApi(item.category);

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.statusRed,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_rounded, color: AppColors.white),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.completed
                ? category.color.withValues(alpha: 0.3)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Completion checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: item.completed
                          ? category.color
                          : AppColors.transparent,
                      border: Border.all(
                        color: item.completed
                            ? category.color
                            : AppColors.textGrey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: item.completed
                        ? const Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 14),
                  // Title & category
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: item.completed
                                ? AppColors.textGrey
                                : AppColors.textDark,
                            decoration: item.completed
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: AppColors.textGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: category.bgColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    category.icon,
                                    size: 11,
                                    color: category.color,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    category.label,
                                    style: AppTextStyles.rubik.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: category.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (item.completed && item.completedAt != null) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check_circle_outline_rounded,
                                size: 12,
                                color: AppColors.statusGreen.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                _formatDate(item.completedAt!),
                                style: AppTextStyles.rubik.copyWith(
                                  fontSize: 11,
                                  color: AppColors.textCaption,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Category color indicator
                  Container(
                    width: 4,
                    height: 36,
                    decoration: BoxDecoration(
                      color: item.completed
                          ? category.color.withValues(alpha: 0.3)
                          : category.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete item?',
          style: AppTextStyles.libre.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'This will permanently remove "${item.title}" from your bucket list.',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 14,
            color: AppColors.textBody,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Delete',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.statusRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
