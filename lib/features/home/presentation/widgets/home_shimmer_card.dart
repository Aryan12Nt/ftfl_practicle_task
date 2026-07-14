import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/shimmer_loader.dart';

class HomeShimmerCard extends StatelessWidget {
  const HomeShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ShimmerCardLoader(),
          const SizedBox(height: 20),
          _SkeletonActions(),
        ],
      ),
    );
  }
}

class _SkeletonActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SkeletonCircle(size: 40),
          const SizedBox(width: 20),
          _SkeletonCircle(size: 52),
          const SizedBox(width: 20),
          _SkeletonCircle(size: 40),
        ],
      ),
    );
  }
}

class _SkeletonCircle extends StatelessWidget {
  final double size;
  const _SkeletonCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      width: size,
      height: size,
      borderRadius: size / 2,
    );
  }
}
