import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppSpacing.cardBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceLight,
      highlightColor: AppColors.surfaceMedium,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerCardLoader extends StatelessWidget {
  const ShimmerCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Guard against zero/negative constraints during first frame
        final availW = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final screenH = MediaQuery.sizeOf(context).height;
        final cardW =
            (availW - AppSpacing.cardMarginH * 2).clamp(0.0, double.infinity);
        final cardH = (screenH * 0.65).clamp(200.0, 700.0);

        if (cardW <= 0) return const SizedBox.shrink();

        return Shimmer.fromColors(
          baseColor: AppColors.surfaceLight,
          highlightColor: AppColors.surfaceMedium,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: AppSpacing.cardMarginH),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
            ),
            width: cardW,
            height: cardH,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Badge row
                  Row(
                    children: [
                      _shimmerPill(70),
                      const SizedBox(width: 8),
                      _shimmerPill(70),
                      const SizedBox(width: 8),
                      _shimmerPill(60),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Name
                  _shimmerBar(availW * 0.45, 22),
                  const SizedBox(height: 8),
                  // Meta rows
                  _shimmerBar(availW * 0.55, 14),
                  const SizedBox(height: 6),
                  _shimmerBar(availW * 0.50, 14),
                  const SizedBox(height: 6),
                  _shimmerBar(availW * 0.40, 14),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _shimmerPill(double width) {
    return Container(
      width: width,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _shimmerBar(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceLight,
      highlightColor: const Color(0xFF3A3A3A),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 12,
                    width: 160,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(6),
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
