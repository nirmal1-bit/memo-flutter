import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/section_card.dart';

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key, required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Interests',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: interests
            .map(
              (interest) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.brandBackground,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.dividerColor),
                ),
                child: Text(
                  _capitalize(interest),
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.softPrimary,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
