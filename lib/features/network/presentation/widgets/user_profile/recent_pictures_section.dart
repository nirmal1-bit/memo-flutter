import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/network/data/models/response/recent_image_response.dart';
import 'package:memo/features/network/presentation/cubits/create_recent_image_cubit.dart';
import 'package:memo/features/network/presentation/cubits/delete_recent_image_cubit.dart';
import 'package:memo/features/network/presentation/cubits/get_recent_images_cubit.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/recent_picture_card.dart';

class RecentPicturesSection extends StatelessWidget {
  const RecentPicturesSection({super.key});

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
          create: (_) => getIt<GetRecentImagesCubit>()..getRecentImages(),
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
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: state.maybeWhen(
                      loading: () => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (message) => Text(message),
                      validationError: (error) => Text(error.message),
                      orElse: () => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (_, index) => RecentPictureCard(
                          picture: index < pictures.length
                              ? pictures[index]
                              : null,
                          color: _colors[index],
                          onDelete: index < pictures.length
                              ? () => _deletePicture(context, pictures[index])
                              : null,
                          onAdd: index >= pictures.length
                              ? () => _addPicture(context)
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<void> _addPicture(BuildContext context) async {
    final description = await _descriptionDialog(context);
    if (description == null || !context.mounted) return;

    final url = await AppUtils.pickAndUploadImage(
      context: context,
      folder: 'recent_images',
    );
    if (url == null || url.isEmpty || !context.mounted) return;

    await context.read<CreateRecentImageCubit>().createRecentImage(
      url: url,
      description: description,
    );
    if (context.mounted) {
      await context.read<GetRecentImagesCubit>().getRecentImages();
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
        await context.read<GetRecentImagesCubit>().getRecentImages();
      }
    }
  }

  Future<String?> _descriptionDialog(BuildContext context) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const _DescriptionSheet(),
    );
  }
}

class _DescriptionSheet extends StatefulWidget {
  const _DescriptionSheet();

  @override
  State<_DescriptionSheet> createState() => _DescriptionSheetState();
}

class _DescriptionSheetState extends State<_DescriptionSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add a picture',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Add a short description before uploading.',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13,
                color: AppColors.textLightDark,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              maxLines: 4,
              maxLength: 180,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'What makes this moment special?',
                filled: true,
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context, _controller.text.trim()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Choose picture'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
