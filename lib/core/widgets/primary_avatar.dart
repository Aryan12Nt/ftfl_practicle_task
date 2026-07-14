import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class PrimaryAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Widget? fallbackIcon;

  const PrimaryAvatar({
    super.key,
    this.imageUrl,
    this.radius = 24,
    this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceMedium,
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                placeholder: (context, url) => _Placeholder(radius: radius),
                errorWidget: (context, url, error) =>
                    _Fallback(radius: radius, icon: fallbackIcon),
              )
            : _Fallback(radius: radius, icon: fallbackIcon),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final double radius;
  const _Placeholder({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      color: AppColors.surfaceMedium,
    );
  }
}

class _Fallback extends StatelessWidget {
  final double radius;
  final Widget? icon;
  const _Fallback({required this.radius, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      color: AppColors.surfaceMedium,
      child: Center(
        child: icon ??
            Icon(
              Icons.person_outline,
              size: radius * 0.9,
              color: AppColors.textMuted,
            ),
      ),
    );
  }
}
