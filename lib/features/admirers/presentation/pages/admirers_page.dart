import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../routes/app_routes.dart';

final _mockAdmirers = [
  {'name': 'Priya', 'age': 24, 'emoji': '🌸', 'blur': false, 'time': '2m ago'},
  {
    'name': 'Anjali',
    'age': 27,
    'emoji': '🌺',
    'blur': false,
    'time': '15m ago'
  },
  {'name': 'Sneha', 'age': 23, 'emoji': '🌻', 'blur': true, 'time': '1h ago'},
  {'name': 'Kavya', 'age': 26, 'emoji': '🌹', 'blur': true, 'time': '2h ago'},
  {'name': 'Riya', 'age': 25, 'emoji': '🌷', 'blur': true, 'time': '5h ago'},
  {'name': 'Meera', 'age': 28, 'emoji': '🪷', 'blur': true, 'time': '1d ago'},
];

final _admColorPalette = [
  const Color(0xFF6C63FF),
  const Color(0xFFE8385A),
  const Color(0xFF2DD87F),
  const Color(0xFFFF8C42),
  const Color(0xFF4A9EFF),
  const Color(0xFFBF2A46),
];

class AdmirersPage extends StatelessWidget {
  const AdmirersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PremiumBanner(),
                    const SizedBox(height: 8),
                    const SectionHeader(
                      title: 'People who liked you',
                      actionLabel: null,
                    ),
                    _AdmirerGrid(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: NavTab.admirers,
        onTabSelected: (tab) => _navigateToTab(context, tab),
      ),
    );
  }

  void _navigateToTab(BuildContext context, NavTab tab) {
    switch (tab) {
      case NavTab.home:
        context.go(AppRoutes.home);
        break;
      case NavTab.dateNow:
        context.go(AppRoutes.dateNow);
        break;
      case NavTab.admirers:
        break;
      case NavTab.chat:
        context.go(AppRoutes.chatList);
        break;
      case NavTab.events:
        context.go(AppRoutes.events);
        break;
    }
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Text('Admirers', style: AppTextStyles.headlineLarge),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_mockAdmirers.length}',
              style: AppTextStyles.badgeLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C1FC8), AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium, color: Colors.amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upgrade to Premium', style: AppTextStyles.titleMedium),
                Text(
                  'See everyone who liked you without limits',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Upgrade',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdmirerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.78,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _mockAdmirers.length,
      itemBuilder: (ctx, i) {
        final u = _mockAdmirers[i];
        return _AdmirerCard(
          name: u['name'] as String,
          age: u['age'] as int,
          emoji: u['emoji'] as String,
          isBlurred: u['blur'] as bool,
          time: u['time'] as String,
          color: _admColorPalette[i % _admColorPalette.length],
        );
      },
    );
  }
}

class _AdmirerCard extends StatelessWidget {
  final String name;
  final int age;
  final String emoji;
  final bool isBlurred;
  final String time;
  final Color color;

  const _AdmirerCard({
    required this.name,
    required this.age,
    required this.emoji,
    required this.isBlurred,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Photo area
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: TextStyle(
                            fontSize: 48,
                            color: isBlurred ? Colors.transparent : null,
                          ),
                        ),
                      ),
                    ),
                    // Blur overlay
                    if (isBlurred)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black54,
                          child: const Center(
                            child: Icon(
                              Icons.lock_outline,
                              color: Colors.white70,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBlurred ? '??? , ??' : '$name, $age',
                      style: AppTextStyles.chatName,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          isBlurred ? 'Hidden' : time,
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
