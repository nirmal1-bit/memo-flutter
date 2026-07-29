import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/shared_album/data/album_category.dart';
import 'package:memo/features/shared_album/data/request/shared_image_request.dart';
import 'package:memo/features/shared_album/data/response/shared_image_response.dart';
import 'package:memo/features/shared_album/cubits/create_shared_image_cubit.dart';
import 'package:memo/features/shared_album/cubits/delete_shared_image_cubit.dart';
import 'package:memo/features/shared_album/cubits/favorite_shared_image_cubit.dart';
import 'package:memo/features/shared_album/cubits/get_shared_images_cubit.dart';
import 'package:memo/features/shared_album/presentation/widgets/shared_album_category_strip.dart';
import 'package:memo/features/shared_album/presentation/widgets/shared_album_empty_state.dart';
import 'package:memo/features/shared_album/presentation/widgets/shared_album_photo_card.dart';

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
    final imageUrl = await AppUtils.pickAndUploadImage(
      context: context,
      folder: 'shared-album',
    );
    if (imageUrl == null || !context.mounted) return;

    final request = await showModalBottomSheet<SharedImageRequest>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _CreateSharedImageSheet(imageUrl: imageUrl),
    );
    if (request != null && context.mounted) {
      context.read<CreateSharedImageCubit>().createSharedImage(
        widget.connectionId,
        request,
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

class _CreateSharedImageSheet extends StatefulWidget {
  const _CreateSharedImageSheet({required this.imageUrl});
  final String imageUrl;

  @override
  State<_CreateSharedImageSheet> createState() =>
      _CreateSharedImageSheetState();
}

class _CreateSharedImageSheetState extends State<_CreateSharedImageSheet> {
  final _descriptionController = TextEditingController();
  AlbumCategory _category = AlbumCategory.other;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        20,
        16,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add shared photo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<AlbumCategory>(
            initialValue: _category,
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            items: AlbumCategory.values
                .where((item) => item != AlbumCategory.all)
                .map(
                  (item) =>
                      DropdownMenuItem(value: item, child: Text(item.label)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _category = value);
            },
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(
              SharedImageRequest(
                imageUrl: widget.imageUrl,
                description: _descriptionController.text.trim(),
                category: _category.apiValue,
              ),
            ),
            icon: const Icon(Icons.cloud_upload_rounded),
            label: const Text('Add to album'),
          ),
        ],
      ),
    );
  }
}
