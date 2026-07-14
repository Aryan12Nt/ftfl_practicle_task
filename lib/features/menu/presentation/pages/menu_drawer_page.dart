import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_routes.dart';

final List<Map<String, dynamic>> _menuItems = [
  {'icon': Icons.person_outline, 'label': 'Edit Profile', 'route': null},
  {'icon': Icons.workspace_premium_outlined, 'label': 'Premium', 'route': null},
  {'icon': Icons.tune, 'label': 'Preferences', 'route': AppRoutes.filters},
  {
    'icon': Icons.notifications_outlined,
    'label': 'Notifications',
    'route': AppRoutes.notifications
  },
  {'icon': Icons.shield_outlined, 'label': 'Safety & Privacy', 'route': null},
  {'icon': Icons.help_outline, 'label': 'Help & Support', 'route': null},
  {'icon': Icons.settings_outlined, 'label': 'Settings', 'route': null},
  {'icon': Icons.logout, 'label': 'Sign Out', 'route': null},
];

class MenuDrawerPage extends StatelessWidget {
  const MenuDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  const SizedBox(width: AppSpacing.xs),
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // User profile section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, Color(0xFF6C63FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Text('🌟', style: TextStyle(fontSize: 32)),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.cardBackground, width: 2),
                          ),
                          child: const Icon(Icons.edit,
                              color: Colors.white, size: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text('Aryan Kumar',
                      style:
                          AppTextStyles.headlineLarge.copyWith(fontSize: 22)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.onlineGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('Online now', style: AppTextStyles.onlineTag),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Premium badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.workspace_premium,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Premium Member',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stats row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Row(
                children: [
                  _StatBadge(label: 'Matches', value: '34'),
                  const SizedBox(width: 16),
                  _StatBadge(label: 'Admirers', value: '127'),
                  const SizedBox(width: 16),
                  _StatBadge(label: 'Roses Sent', value: '12'),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 8),

            // Menu items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _menuItems.length,
                itemBuilder: (ctx, i) {
                  final item = _menuItems[i];
                  final isLast = i == _menuItems.length - 1;

                  return Column(
                    children: [
                      if (isLast) ...[
                        const Divider(color: AppColors.divider, height: 16),
                      ],
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                          vertical: 2,
                        ),
                        leading: Icon(
                          item['icon'] as IconData,
                          color: isLast
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 22,
                        ),
                        title: Text(
                          item['label'] as String,
                          style: AppTextStyles.drawerItem.copyWith(
                            color: isLast
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        trailing: item['route'] != null
                            ? const Icon(Icons.chevron_right,
                                color: AppColors.textMuted)
                            : null,
                        onTap: () {
                          Navigator.of(context).pop();
                          final route = item['route'] as String?;
                          if (route != null) {
                            context.push(route);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;

  const _StatBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: AppTextStyles.titleMedium
                    .copyWith(color: AppColors.primary)),
            const SizedBox(height: 2),
            Text(label, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
