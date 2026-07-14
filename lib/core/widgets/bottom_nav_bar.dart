import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

enum NavTab { home, dateNow, admirers, chat, events }

class AppBottomNavBar extends StatelessWidget {
  final NavTab currentTab;
  final void Function(NavTab) onTabSelected;

  const AppBottomNavBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: NavTab.values
                .map((tab) => _NavItem(
                      tab: tab,
                      isActive: tab == currentTab,
                      onTap: () => onTabSelected(tab),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final NavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  IconData get _icon {
    switch (tab) {
      case NavTab.home:
        return isActive ? Icons.home_rounded : Icons.home_outlined;
      case NavTab.dateNow:
        return isActive ? Icons.play_circle_filled : Icons.play_circle_outline;
      case NavTab.admirers:
        return isActive ? Icons.favorite_rounded : Icons.favorite_border;
      case NavTab.chat:
        return isActive ? Icons.chat_bubble_rounded : Icons.chat_bubble_outline;
      case NavTab.events:
        return isActive ? Icons.event : Icons.event_outlined;
    }
  }

  String get _label {
    switch (tab) {
      case NavTab.home:
        return 'Home';
      case NavTab.dateNow:
        return 'Date Now';
      case NavTab.admirers:
        return 'Admirers';
      case NavTab.chat:
        return 'Chat';
      case NavTab.events:
        return 'Events';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icon,
              color: isActive ? AppColors.navActive : AppColors.navInactive,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              _label,
              style: isActive
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabel,
            ),
          ],
        ),
      ),
    );
  }
}
