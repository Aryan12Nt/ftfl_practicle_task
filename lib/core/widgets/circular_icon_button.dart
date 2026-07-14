import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final List<BoxShadow>? boxShadow;
  final bool hasBorder;
  final Color borderColor;

  const CircularIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 44,
    this.backgroundColor = AppColors.cardBackground,
    this.iconColor = AppColors.textSecondary,
    this.iconSize = 20,
    this.boxShadow,
    this.hasBorder = true,
    this.borderColor = AppColors.divider,
  });

  const CircularIconButton.primary({
    Key? key,
    required IconData icon,
    VoidCallback? onTap,
    double size = 52,
    double iconSize = 24,
  }) : this(
          key: key,
          icon: icon,
          onTap: onTap,
          size: size,
          backgroundColor: AppColors.primary,
          iconColor: Colors.white,
          iconSize: iconSize,
          hasBorder: false,
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryGlow,
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: hasBorder ? Border.all(color: borderColor, width: 0.8) : null,
          boxShadow: boxShadow,
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}
