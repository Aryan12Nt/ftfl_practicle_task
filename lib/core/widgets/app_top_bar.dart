import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLightningTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onBellTap;
  final int dailyCount;
  final bool hasUnread;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onLightningTap,
    this.onFilterTap,
    this.onBellTap,
    this.dailyCount = 25,
    this.hasUnread = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffold,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              // Hamburger
              _IconBtn(icon: Icons.menu, onTap: onMenuTap),
              const Spacer(),
              // Daily pill badge
              _DailyBadge(count: dailyCount),
              const SizedBox(width: 12),
              // Right side icons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lightning
                  _IconBtn(icon: Icons.bolt_outlined, onTap: onLightningTap),
                  const SizedBox(width: AppSpacing.xs),
                  // Filter / sliders
                  _IconBtn(icon: Icons.tune, onTap: onFilterTap),
                  const SizedBox(width: AppSpacing.xs),
                  // Bell with unread dot
                  _BellBtn(hasUnread: hasUnread, onTap: onBellTap),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyBadge extends StatelessWidget {
  final int count;
  const _DailyBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text('Daily $count', style: AppTextStyles.topBarBadge),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 22),
      ),
    );
  }
}

class _BellBtn extends StatelessWidget {
  final bool hasUnread;
  final VoidCallback? onTap;

  const _BellBtn({required this.hasUnread, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                Icons.notifications_outlined,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ),
            if (hasUnread)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.unreadDot,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.scaffold, width: 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
