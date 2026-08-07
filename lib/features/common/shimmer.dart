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
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
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

class ChatLoading extends StatelessWidget {
  const ChatLoading({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bubble({required double width, required double height}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor(context),
      highlightColor: _shimmerHighlightColor(context),
      enabled: true,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: bubble(width: 180, height: 48),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: bubble(width: 220, height: 58),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: bubble(width: 240, height: 72),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: bubble(width: 155, height: 48),
          ),
        ],
      ),
    );
  }
}

class DatingProfileShimmer extends StatelessWidget {
  const DatingProfileShimmer({super.key});

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
            // Profile Image
            Container(
              height: 380,
              width: double.infinity,
              color: AppColors.white,
            ),
            16.verticalSpace,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Age
                  Row(
                    children: [
                      Container(
                        height: 24,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                      12.horizontalSpace,
                      Container(
                        height: 24,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,

                  // Location
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        height: 14,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,

                  // Job / Occupation
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        height: 14,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,

                  // Education
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        height: 14,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,

                  // About Me label
                  Container(
                    height: 16,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  10.verticalSpace,

                  // Bio lines
                  Container(
                    height: 13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  7.verticalSpace,
                  Container(
                    height: 13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  7.verticalSpace,
                  Container(
                    height: 13,
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  20.verticalSpace,

                  // Interests label
                  Container(
                    height: 16,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  10.verticalSpace,

                  // Interest tag pills
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [72.0, 58.0, 64.0, 80.0, 54.0, 70.0]
                        .map(
                          (w) => Container(
                            height: 32,
                            width: w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.white,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  20.verticalSpace,

                  // Looking for label
                  Container(
                    height: 16,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  10.verticalSpace,

                  // Looking for value
                  Container(
                    height: 14,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,
                    ),
                  ),
                  20.verticalSpace,

                  // Height / Lifestyle row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                      ),
                      20.horizontalSpace,
                      Container(
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                      ),
                      20.horizontalSpace,
                      Container(
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
