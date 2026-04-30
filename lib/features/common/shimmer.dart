import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

Color _shimmerBaseColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkSurface
      : AppColors.brandBackgroundLight;
}

Color _shimmerHighlightColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkElevatedSurface
      : AppColors.white;
}

double _screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor(context),
      highlightColor: _shimmerHighlightColor(context),
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              color: AppColors.white,
            ),
            16.verticalSpace,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Container(
                    height: 20,
                    width: _screenWidth(context) * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  8.verticalSpace,
                  Container(
                    height: 20,
                    width: _screenWidth(context) * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  16.verticalSpace,

                  // Rating
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                      12.horizontalSpace,
                      Container(
                        height: 16,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,

                  // Price
                  Container(
                    height: 24,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  24.verticalSpace,

                  // Description
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  8.verticalSpace,
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  8.verticalSpace,
                  Container(
                    height: 14,
                    width: _screenWidth(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  24.verticalSpace,

                  // Specifications
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductBannerShimmer extends StatelessWidget {
  const ProductBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor(context),
      highlightColor: _shimmerHighlightColor(context),
      enabled: true,
      child: Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
      ),
    );
  }
}

class ProductListingShimmer extends StatelessWidget {
  const ProductListingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor(context),
      highlightColor: _shimmerHighlightColor(context),
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (context, index) => 16.verticalSpace,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                ),
                12.horizontalSpace,
                // Product Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Title
                        Container(
                          height: 16,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.white,
                          ),
                        ),
                        8.verticalSpace,
                        Container(
                          height: 16,
                          width: _screenWidth(context) * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.white,
                          ),
                        ),
                        12.verticalSpace,
                        // Rating
                        Container(
                          height: 14,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.white,
                          ),
                        ),
                        12.verticalSpace,
                        // Price
                        Container(
                          height: 18,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                12.horizontalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

class ListShimmer extends StatelessWidget {
  final int itemCount;
  final double? itemHeight;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ListShimmer({
    super.key,
    this.itemCount = 6,
    this.itemHeight = 80,
    this.padding = const EdgeInsets.all(16),
    this.spacing = 12,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor(context),
      highlightColor: _shimmerHighlightColor(context),
      enabled: true,
      child: ListView.separated(
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        separatorBuilder: (context, index) => spacing.verticalSpace,
        itemBuilder: (context, index) {
          return Container(
            height: itemHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}
