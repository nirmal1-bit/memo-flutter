import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/section_card.dart';

class JoinedSection extends StatelessWidget {
  const JoinedSection({super.key, required this.joinedAt});

  final DateTime joinedAt;

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
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Member since',
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.brandBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            _formatDate(joinedAt),
            style: AppTextStyles.rubik.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.softBlack,
            ),
          ),
        ],
      ),
    );
  }
}
