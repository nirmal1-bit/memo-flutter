import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/home/data/models/response/recent_image_response.dart';

class RecentPictureCard extends StatelessWidget {
  const RecentPictureCard({
    super.key,
    this.picture,
    required this.color,
    this.onDelete,
    this.onAdd,
  });

  final RecentImageResponse? picture;
  final Color color;
  final VoidCallback? onDelete;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: picture == null ? onAdd : () => _showPreview(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: picture == null
                    ? const _EmptyPicture()
                    : _PictureImage(picture: picture!),
              ),
              if (picture != null && onDelete != null)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: AppColors.black.withValues(alpha: 0.45),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onDelete,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.delete_outline,
                          size: 16,
                          color: AppColors.white,
                        ),
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

  void _showPreview(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierLabel: 'Close picture',
      barrierDismissible: true,
      barrierColor: AppColors.black.withValues(alpha: 0.72),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) =>
          _PictureViewer(picture: picture!),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}

class _PictureViewer extends StatelessWidget {
  const _PictureViewer({required this.picture});

  final RecentImageResponse picture;

  @override
  Widget build(BuildContext context) {
    final description = picture.description?.trim() ?? '';

    return Material(
      color: AppColors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: ColoredBox(color: AppColors.black.withValues(alpha: 0.24)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.black.withValues(
                          alpha: 0.42,
                        ),
                        foregroundColor: AppColors.white,
                      ),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(picture.url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (description.isNotEmpty)
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
                      child: Text(
                        description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 14,
                          height: 1.35,
                          color: AppColors.white,
                        ),
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

class _PictureImage extends StatelessWidget {
  const _PictureImage({required this.picture});

  final RecentImageResponse picture;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      picture.url,
      height: 240,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const _EmptyPicture(icon: Icons.broken_image_outlined),
      loadingBuilder: (context, child, progress) => progress == null
          ? child
          : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _EmptyPicture extends StatelessWidget {
  const _EmptyPicture({this.icon = Icons.add});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Center(
        child: Icon(
          icon,
          size: 34,
          color: AppColors.primary.withValues(alpha: 0.75),
        ),
      ),
    );
  }
}
