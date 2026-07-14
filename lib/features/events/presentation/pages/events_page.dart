import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';

final List<Map<String, dynamic>> _mockEvents = [
  {
    'title': 'Speed Dating Night',
    'venue': 'The Social Hub, Koramangala',
    'date': 'Sat, Jul 19',
    'time': '7:00 PM',
    'attendees': 48,
    'emoji': '💘',
    'color': Color(0xFFE8385A),
    'going': true,
  },
  {
    'title': 'Singles Mixer Party',
    'venue': 'Indiranagar Social',
    'date': 'Sun, Jul 20',
    'time': '6:30 PM',
    'attendees': 120,
    'emoji': '🎉',
    'color': Color(0xFF6C63FF),
    'going': false,
  },
  {
    'title': 'Coffee & Connect',
    'venue': 'Blue Tokai, HSR Layout',
    'date': 'Wed, Jul 23',
    'time': '11:00 AM',
    'attendees': 22,
    'emoji': '☕',
    'color': Color(0xFFFF8C42),
    'going': false,
  },
  {
    'title': 'Rooftop Sundowner',
    'venue': 'Lahe Lahe, Indiranagar',
    'date': 'Fri, Jul 25',
    'time': '5:00 PM',
    'attendees': 65,
    'emoji': '🌅',
    'color': Color(0xFF4A9EFF),
    'going': false,
  },
  {
    'title': 'Book Club for Singles',
    'venue': 'Blossom Books, MG Road',
    'date': 'Sat, Jul 26',
    'time': '3:00 PM',
    'attendees': 18,
    'emoji': '📚',
    'color': Color(0xFF2DD87F),
    'going': false,
  },
];

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                itemCount: _mockEvents.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, i) => _EventCard(event: _mockEvents[i]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: NavTab.events,
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
        context.go(AppRoutes.admirers);
        break;
      case NavTab.chat:
        context.go(AppRoutes.chatList);
        break;
      case NavTab.events:
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
          Text('Events', style: AppTextStyles.headlineLarge),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on,
                    size: 14, color: AppColors.primary),
                const SizedBox(width: 4),
                Text('Bangalore',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatefulWidget {
  final Map<String, dynamic> event;
  const _EventCard({required this.event});

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  late bool _going;

  @override
  void initState() {
    super.initState();
    _going = widget.event['going'] as bool;
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.event['color'] as Color;
    final emoji = widget.event['emoji'] as String;
    final attendees = widget.event['attendees'] as int;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.4)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 52)),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event['title'] as String,
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.event['venue'] as String,
                        style: AppTextStyles.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.event['date']} · ${widget.event['time']}',
                      style: AppTextStyles.bodySmall,
                    ),
                    const Spacer(),
                    Icon(Icons.people_outline,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text('$attendees going', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _going = !_going),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _going ? AppColors.surfaceMedium : AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(_going ? 'Cancel RSVP' : "I'm Going!"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
