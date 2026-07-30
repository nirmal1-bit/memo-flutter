import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/home/data/models/response/recent_image_response.dart';
import 'package:memo/features/home/presentation/cubits/create_recent_image_cubit.dart';
import 'package:memo/features/home/presentation/cubits/delete_recent_image_cubit.dart';
import 'package:memo/features/home/presentation/cubits/get_recent_images_cubit.dart';
import 'package:memo/features/home/presentation/widgets/profile/recent_picture_card.dart';

class RecentPicturesSection extends StatelessWidget {
  const RecentPicturesSection({
    super.key,
    required this.userId,
    this.showAddAlbumPlaceholder = true,
  });

  final int userId;
  final bool showAddAlbumPlaceholder;

  static const _colors = [
    AppColors.brandBackgroundLight,
    AppColors.memoryAmber,
    AppColors.statusLightRed,
    AppColors.chipPurpleBg,
    AppColors.chipGreenBg,
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GetRecentImagesCubit>()..getRecentImages(userId),
        ),
        BlocProvider(create: (_) => getIt<CreateRecentImageCubit>()),
        BlocProvider(create: (_) => getIt<DeleteRecentImageCubit>()),
      ],
      child:
          BlocBuilder<
            GetRecentImagesCubit,
            BaseApiState<List<RecentImageResponse>>
          >(
            builder: (context, state) {
              final pictures = state.maybeWhen(
                success: (data) => data.take(5).toList(),
                orElse: () => <RecentImageResponse>[],
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Recent Pictures',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  state.maybeWhen(
                    loading: () => const SizedBox(
                      height: 40,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    error: (message) => Text(message),
                    validationError: (error) => Text(error.message),
                    orElse: () {
                      if (!showAddAlbumPlaceholder && pictures.isEmpty) {
                        return const _NoRecentPictures();
                      }

                      final itemCount = showAddAlbumPlaceholder
                          ? 5
                          : pictures.length;
                      return SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: itemCount,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          itemBuilder: (_, index) => RecentPictureCard(
                            picture: index < pictures.length
                                ? pictures[index]
                                : null,
                            color: _colors[index % _colors.length],
                            onDelete: index < pictures.length
                                ? () => _deletePicture(context, pictures[index])
                                : null,
                            onAdd:
                                showAddAlbumPlaceholder &&
                                    index >= pictures.length
                                ? () => _addPicture(context)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<void> _addPicture(BuildContext context) async {
    final picture = await AppUtils.pickImageAndDescription(
      context: context,
      folder: 'recent_images',
    );
    if (picture == null || !context.mounted) return;

    await context.read<CreateRecentImageCubit>().createRecentImage(
      url: picture.imageUrl,
      description: picture.description,
    );
    if (context.mounted) {
      await context.read<GetRecentImagesCubit>().getRecentImages(userId);
    }
  }

  Future<void> _deletePicture(
    BuildContext context,
    RecentImageResponse picture,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete picture?'),
        content: const Text('This picture will be removed from your profile.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete == true && context.mounted) {
      await context.read<DeleteRecentImageCubit>().deleteRecentImage(
        picture.id,
      );
      if (context.mounted) {
        await context.read<GetRecentImagesCubit>().getRecentImages(userId);
      }
    }
  }
}

class _NoRecentPictures extends StatelessWidget {
  const _NoRecentPictures();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.brandBackgroundLight.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.brandBackgroundLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.photo_library_outlined,
              color: AppColors.primary,
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No recent pictures provided by user',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Added Pictures will be displayed here.',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 12,
                    color: AppColors.textLightDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
