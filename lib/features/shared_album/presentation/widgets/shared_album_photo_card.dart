import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/shared_album/data/album_category.dart';
import 'package:memo/features/shared_album/data/response/shared_image_response.dart';

class SharedAlbumPhotoCard extends StatelessWidget {
  const SharedAlbumPhotoCard({
    super.key,
    required this.image,
    required this.onTap,
    this.onFavorite,
    this.onDelete,
  });

  final SharedImageResponse image;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final category = AlbumCategory.fromApi(image.category);

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.softGrey,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with category badge & favorite indicator
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Photo
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        image.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) =>
                            progress == null
                                ? child
                                : Container(
                                    color: AppColors.lightGrey,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.lightGrey,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: AppColors.textGrey,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Gradient overlay at bottom for readability
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.transparent,
                              AppColors.black.withValues(alpha: 0.45),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Category badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: category.bgColor,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: category.color.withValues(alpha: 0.25),
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category.icon,
                              size: 12,
                              color: category.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              category.label,
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: category.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Favorite indicator
                    if (onFavorite != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          onPressed: onFavorite,
                          icon: Icon(image.isFavorite ? Icons.favorite : Icons.favorite_border),
                          color: AppColors.buttonPrimary,
                          style: IconButton.styleFrom(backgroundColor: AppColors.white.withValues(alpha: .9)),
                        ),
                      ),

                    // Date at bottom-right
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Text(
                        DateFormat('MMM d').format(image.createdAt),
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Description footer
              if (image.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Text(
                    image.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 12,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textDark,
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

// ──────────────────────────────────────────────────────────────────────
//  Full-screen photo viewer (shown on card tap)
// ──────────────────────────────────────────────────────────────────────

class SharedAlbumPhotoViewer extends StatelessWidget {
  const SharedAlbumPhotoViewer({super.key, required this.image});

  final SharedImageResponse image;

  @override
  Widget build(BuildContext context) {
    final category = AlbumCategory.fromApi(image.category);
    final description = image.description.trim();

    return Material(
      color: AppColors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred backdrop
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: ColoredBox(
              color: AppColors.black.withValues(alpha: 0.24),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                children: [
                  // Top row: category badge + close button
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: category.bgColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category.icon,
                              size: 14,
                              color: category.color,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              category.label,
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: category.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (image.isFavorite)
                        Icon(
                          Icons.favorite_rounded,
                          size: 18,
                          color: AppColors.buttonPrimary,
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              AppColors.black.withValues(alpha: 0.42),
                          foregroundColor: AppColors.white,
                        ),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Zoomable image
                  Expanded(
                    child: Center(
                      child: InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image.imageUrl,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, progress) =>
                                progress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.white,
                                        ),
                                      ),
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                size: 48,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Description + date footer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.48),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (description.isNotEmpty) ...[
                          Text(
                            description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.rubik.copyWith(
                              fontSize: 14,
                              height: 1.35,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Text(
                          DateFormat('MMMM d, yyyy • h:mm a')
                              .format(image.createdAt.toLocal()),
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 11,
                            color: AppColors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
