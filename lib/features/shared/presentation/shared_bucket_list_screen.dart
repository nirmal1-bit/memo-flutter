import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/shared/data/request/bucket_item_request.dart';
import 'package:memo/features/shared/cubits/create_bucket_item_cubit.dart';
import 'package:memo/features/shared/cubits/delete_bucket_item_cubit.dart';
import 'package:memo/features/shared/cubits/get_bucket_items_cubit.dart';
import 'package:memo/features/shared/cubits/toggle_bucket_item_cubit.dart';
import 'package:memo/features/shared/data/bucket_category.dart';
import 'package:memo/features/shared/data/response/bucket_item_response.dart';
import 'package:memo/features/shared/presentation/widgets/bucket_category_strip.dart';
import 'package:memo/features/shared/presentation/widgets/bucket_item_card.dart';
import 'package:memo/features/shared/presentation/widgets/bucket_list_empty_state.dart';

class SharedBucketListScreen extends StatefulWidget {
  const SharedBucketListScreen({super.key, required this.connectionId});
  final int connectionId;

  @override
  State<SharedBucketListScreen> createState() => _SharedBucketListScreenState();
}

class _SharedBucketListScreenState extends State<SharedBucketListScreen> {
  BucketCategory _selectedCategory = BucketCategory.all;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<GetBucketItemsCubit>()..getBucketItems(widget.connectionId),
        ),
        BlocProvider(create: (_) => getIt<CreateBucketItemCubit>()),
        BlocProvider(create: (_) => getIt<ToggleBucketItemCubit>()),
        BlocProvider(create: (_) => getIt<DeleteBucketItemCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ToggleBucketItemCubit, BaseApiState<String>>(
            listener: (listenerContext, state) {
              state.maybeWhen(
                success: (_) => listenerContext
                    .read<GetBucketItemsCubit>()
                    .getBucketItems(widget.connectionId),
                orElse: () {},
              );
            },
          ),
          BlocListener<DeleteBucketItemCubit, BaseApiState<String>>(
            listener: (listenerContext, state) {
              state.maybeWhen(
                success: (_) => listenerContext
                    .read<GetBucketItemsCubit>()
                    .getBucketItems(widget.connectionId),
                orElse: () {},
              );
            },
          ),
          BlocListener<CreateBucketItemCubit, BaseApiState<BucketItemResponse>>(
            listener: (listenerContext, state) {
              state.maybeWhen(
                success: (_) => listenerContext
                    .read<GetBucketItemsCubit>()
                    .getBucketItems(widget.connectionId),
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
                onPressed: () => _showCreateItemSheet(context),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add_rounded),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 16),
                  BucketCategoryStrip(
                    selected: _selectedCategory,
                    onChanged: (value) =>
                        setState(() => _selectedCategory = value),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child:
                        BlocBuilder<
                          GetBucketItemsCubit,
                          BaseApiState<List<BucketItemResponse>>
                        >(
                          builder: (context, state) => state.when(
                            initial: () => const Center(child: ListShimmer()),
                            loading: () => ListShimmer(),
                            error: (message) => Center(child: Text(message)),
                            noInternet: () => const Center(
                              child: Text('No internet connection'),
                            ),
                            validationError: (error) =>
                                Center(child: Text(error.message)),
                            success: (items) => _buildList(items, context),
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

  Widget _buildList(List<BucketItemResponse> items, BuildContext context) {
    final filtered = _selectedCategory == BucketCategory.all
        ? items
        : items.where((i) => i.category == _selectedCategory.apiValue).toList();

    if (filtered.isEmpty) {
      return const BucketListEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
      itemCount: filtered.length,
      itemBuilder: (_, index) {
        final item = filtered[index];
        return BucketItemCard(
          item: item,
          onToggle: () => context
              .read<ToggleBucketItemCubit>()
              .toggleBucketItem(widget.connectionId, item.id),
          onDelete: () => context
              .read<DeleteBucketItemCubit>()
              .deleteBucketItem(widget.connectionId, item.id),
        );
      },
    );
  }

  Future<void> _showCreateItemSheet(BuildContext outerContext) async {
    final createCubit = outerContext.read<CreateBucketItemCubit>();
    final titleController = TextEditingController();
    BucketCategory selectedCategory = BucketCategory.other;

    final result =
        await AppUtils.showBottomSheet<({String title, String category})>(
          context: context,
          builder: (sheetContext) {
            return StatefulBuilder(
              builder: (context, setSheetState) {
                return Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Handle bar
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Add to bucket list',
                          style: AppTextStyles.libre.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Title field
                        TextField(
                          controller: titleController,
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 15,
                            color: AppColors.textDark,
                          ),
                          decoration: InputDecoration(
                            hintText: 'What do you want to do together?',
                            hintStyle: AppTextStyles.rubik.copyWith(
                              fontSize: 15,
                              color: AppColors.textGrey,
                            ),
                            filled: true,
                            fillColor: AppColors.scaffoldBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Category selector
                        Text(
                          'Category',
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBody,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: BucketCategory.values
                              .where((c) => c != BucketCategory.all)
                              .map((category) {
                                final isSelected = selectedCategory == category;
                                return GestureDetector(
                                  onTap: () => setSheetState(
                                    () => selectedCategory = category,
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? category.color
                                          : category.bgColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isSelected
                                            ? category.color
                                            : AppColors.transparent,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          category.icon,
                                          size: 14,
                                          color: isSelected
                                              ? AppColors.white
                                              : category.color,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          category.label,
                                          style: AppTextStyles.rubik.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected
                                                ? AppColors.white
                                                : category.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              final title = titleController.text.trim();
                              if (title.isEmpty) return;
                              Navigator.pop(context, (
                                title: title,
                                category: selectedCategory.apiValue,
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Add Item',
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );

    if (result != null && mounted) {
      createCubit.createBucketItem(
        widget.connectionId,
        BucketItemRequest(title: result.title, category: result.category),
      );
    }
  }
}
