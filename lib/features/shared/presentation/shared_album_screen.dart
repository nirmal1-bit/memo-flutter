import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/shared/data/album_category.dart';
import 'package:memo/features/shared/data/request/shared_image_request.dart';
import 'package:memo/features/shared/data/response/shared_image_response.dart';
import 'package:memo/features/shared/cubits/create_shared_image_cubit.dart';
import 'package:memo/features/shared/cubits/delete_shared_image_cubit.dart';
import 'package:memo/features/shared/cubits/favorite_shared_image_cubit.dart';
import 'package:memo/features/shared/cubits/get_shared_images_cubit.dart';
import 'package:memo/features/shared/presentation/widgets/shared_album_category_strip.dart';
import 'package:memo/features/shared/presentation/widgets/shared_album_empty_state.dart';
import 'package:memo/features/shared/presentation/widgets/shared_album_photo_card.dart';

class SharedAlbumScreen extends StatefulWidget {
  const SharedAlbumScreen({super.key, required this.connectionId});
  final int connectionId;

  @override
  State<SharedAlbumScreen> createState() => _SharedAlbumScreenState();
}

class _SharedAlbumScreenState extends State<SharedAlbumScreen> {
  AlbumCategory _selectedCategory = AlbumCategory.all;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<GetSharedImagesCubit>()
                ..getSharedImages(widget.connectionId),
        ),
        BlocProvider(create: (_) => getIt<CreateSharedImageCubit>()),
        BlocProvider(create: (_) => getIt<FavoriteSharedImageCubit>()),
        BlocProvider(create: (_) => getIt<DeleteSharedImageCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FavoriteSharedImageCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (message) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: message,
                  );
                  context.read<GetSharedImagesCubit>().getSharedImages(
                    widget.connectionId,
                  );
                },
                error: (message) => AppUtils.showErrorSnackbar(
                  context: context,
                  message: message,
                ),
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
          ),
          BlocListener<DeleteSharedImageCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (message) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: message,
                  );
                  context.read<GetSharedImagesCubit>().getSharedImages(
                    widget.connectionId,
                  );
                },
                error: (message) => AppUtils.showErrorSnackbar(
                  context: context,
                  message: message,
                ),
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
          ),
          BlocListener<
            CreateSharedImageCubit,
            BaseApiState<SharedImageResponse>
          >(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Image added',
                  );
                  context.read<GetSharedImagesCubit>().getSharedImages(
                    widget.connectionId,
                  );
                },
                error: (message) => AppUtils.showErrorSnackbar(
                  context: context,
                  message: message,
                ),
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
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.scaffoldBackground,
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showCreateImageSheet(context),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add_photo_alternate_rounded),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 16),
                  SharedAlbumCategoryStrip(
                    selected: _selectedCategory,
                    onChanged: (value) =>
                        setState(() => _selectedCategory = value),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child:
                        BlocBuilder<
                          GetSharedImagesCubit,
                          BaseApiState<List<SharedImageResponse>>
                        >(
                          builder: (context, state) => state.when(
                            initial: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (message) => Center(child: Text(message)),
                            noInternet: () => const Center(
                              child: Text('No internet connection'),
                            ),
                            validationError: (error) =>
                                Center(child: Text(error.message)),
                            success: (images) {
                              final filtered =
                                  _selectedCategory == AlbumCategory.all
                                  ? images
                                  : images
                                        .where(
                                          (i) =>
                                              i.category ==
                                              _selectedCategory.apiValue,
                                        )
                                        .toList();
                              if (filtered.isEmpty) {
                                return const SharedAlbumEmptyState(
                                  icon: Icons.photo_library_outlined,
                                  title: 'No shared photos',
                                  message: 'Add a photo to your shared album.',
                                );
                              }
                              return GridView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  4,
                                  16,
                                  24,
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 14,
                                      crossAxisSpacing: 14,
                                      childAspectRatio: .72,
                                    ),
                                itemCount: filtered.length,
                                itemBuilder: (_, index) {
                                  final image = filtered[index];
                                  return SharedAlbumPhotoCard(
                                    image: image,
                                    onTap: () => _showPhotoViewer(image),
                                    onFavorite: () => context
                                        .read<FavoriteSharedImageCubit>()
                                        .favoriteSharedImage(
                                          widget.connectionId,
                                          image.id,
                                        ),
                                    onDelete: () => context
                                        .read<DeleteSharedImageCubit>()
                                        .deleteSharedImage(
                                          widget.connectionId,
                                          image.id,
                                        ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showCreateImageSheet(BuildContext context) async {
    final picture = await AppUtils.pickImageAndDescription(
      context: context,
      folder: 'shared-album',
    );
    if (picture != null && context.mounted) {
      context.read<CreateSharedImageCubit>().createSharedImage(
        widget.connectionId,
        SharedImageRequest(
          imageUrl: picture.imageUrl,
          description: picture.description,
          category: AlbumCategory.other.apiValue,
        ),
      );
    }
  }

  void _showPhotoViewer(SharedImageResponse image) {
    showGeneralDialog<void>(
      context: context,
      barrierLabel: 'Close photo',
      barrierDismissible: true,
      barrierColor: AppColors.black.withValues(alpha: .72),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, _, _) => SharedAlbumPhotoViewer(image: image),
      transitionBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
