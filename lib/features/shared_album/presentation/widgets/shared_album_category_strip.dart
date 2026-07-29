import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/shared_album/data/album_category.dart';

class SharedAlbumCategoryStrip extends StatelessWidget {
  const SharedAlbumCategoryStrip({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final AlbumCategory selected;
  final ValueChanged<AlbumCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AlbumCategory.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = AlbumCategory.values[index];
          final isSelected = selected == category;

          return Material(
            color: isSelected ? category.color : category.bgColor,
            borderRadius: BorderRadius.circular(999),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onChanged(category),
              borderRadius: BorderRadius.circular(999),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: 14,
                      color: isSelected ? AppColors.white : category.color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.label,
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.white : category.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
