import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

enum NotificationType { rose, compliment, match, message, date }

class NotificationItem {
  final NotificationType type;
  final String name;
  final String age;
  final String? imageUrl;
  final String actionText;
  final String subtitle;
  final String time;
  final bool isUnread;
  final String? buttonText;

  NotificationItem({
    required this.type,
    required this.name,
    required this.age,
    this.imageUrl,
    required this.actionText,
    required this.subtitle,
    required this.time,
    this.isUnread = false,
    this.buttonText,
  });
}

// ─── Mock Data ──────────────────────────────────────────────────────────────

final List<NotificationItem> _mockNotifications = [
  NotificationItem(
    type: NotificationType.rose,
    name: 'Dev',
    age: '27',
    imageUrl: 'https://randomuser.me/api/portraits/men/46.jpg',
    actionText: ' sent you a Rose',
    subtitle: '"Your trekking photos sold me — let\'s swap trail stories."',
    time: '12 min ago',
    isUnread: true,
    buttonText: 'View profile',
  ),
  NotificationItem(
    type: NotificationType.compliment,
    name: 'Arjun',
    age: '28',
    imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
    actionText: ' complimented your About',
    subtitle: '"Equally driven and equally curious — that line got me."',
    time: '3 h ago',
    isUnread: false,
  ),
  NotificationItem(
    type: NotificationType.match,
    name: 'Aanya',
    age: '25',
    imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    actionText: '',
    subtitle: 'You both liked each other. Say hello before the spark fades.',
    time: '40 min ago',
    isUnread: true,
    buttonText: 'Send a message',
  ),
  NotificationItem(
    type: NotificationType.message,
    name: 'Elena',
    age: '23',
    imageUrl: 'https://randomuser.me/api/portraits/women/12.jpg',
    actionText: ' sent you a message',
    subtitle: '"Haha okay that café pick was elite. When are you free?"',
    time: '1 h ago',
    isUnread: true,
  ),
  NotificationItem(
    type: NotificationType.date,
    name: 'Kabir',
    age: '',
    actionText: ' approved your date request',
    subtitle: 'Coffee at Blue Tokai • Today, 7:00 PM • Koregaon Park',
    time: '2 h ago',
    isUnread: true,
    buttonText: 'Open chat',
  ),
];

// ─── Main Page ──────────────────────────────────────────────────────────────

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFEBE6DF)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF8BA3C7)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        Text(
                          '9 new updates',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Mark all read',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE35D7A),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: const [
                  _FilterChipActive(label: 'All', count: '56'),
                  _FilterChip(label: 'Likes & roses'),
                  _FilterChip(label: 'Matches'),
                  _FilterChip(label: 'Gifts'),
                  _FilterChip(label: 'Dates'),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // 3. Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'TODAY',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            const SizedBox(height: 8),

            // 4. Notifications List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: _mockNotifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return _NotificationCard(item: _mockNotifications[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sub Widgets ────────────────────────────────────────────────────────────

class _FilterChipActive extends StatelessWidget {
  final String label;
  final String count;

  const _FilterChipActive({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEBE6DF)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE35D7A).withValues(alpha: 0.04),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: const Color(0xFFFDEEF2), width: 1.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              _buildAvatar(),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    _buildTitle(),
                    const SizedBox(height: 4),
                    // Subtitle
                    Text(
                      item.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                        fontStyle: item.type != NotificationType.match && item.type != NotificationType.date 
                            ? FontStyle.italic 
                            : FontStyle.normal,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Time
                    Text(
                      item.time,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                    ),
                    // Button
                    if (item.buttonText != null) ...[
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE35D7A),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            item.buttonText!,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          // Unread Dot
          if (item.isUnread)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFE35D7A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    Widget avatarWidget;
    if (item.imageUrl != null) {
      avatarWidget = CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(item.imageUrl!),
      );
    } else {
      avatarWidget = Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF2E6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.event_available_outlined, color: Color(0xFFE39B66), size: 22),
      );
    }

    Widget badgeWidget;
    switch (item.type) {
      case NotificationType.rose:
        badgeWidget = Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE35D7A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Text('🌹', style: TextStyle(fontSize: 8)),
        );
        break;
      case NotificationType.compliment:
        badgeWidget = Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF0AD45),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.chat_bubble, color: Colors.white, size: 9),
        );
        break;
      case NotificationType.match:
        badgeWidget = Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF2EBD59),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 10, weight: 800),
        );
        break;
      case NotificationType.message:
        badgeWidget = Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFA13554),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.chat_bubble, color: Colors.white, size: 9),
        );
        break;
      case NotificationType.date:
        badgeWidget = const SizedBox.shrink();
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatarWidget,
        if (item.type != NotificationType.date)
          Positioned(
            right: -4,
            bottom: -4,
            child: badgeWidget,
          ),
      ],
    );
  }

  Widget _buildTitle() {
    if (item.type == NotificationType.match) {
      return RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
          children: [
            const TextSpan(text: "It's a match with "),
            TextSpan(
              text: "${item.name}, ${item.age}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
        children: [
          TextSpan(
            text: item.age.isNotEmpty ? "${item.name}, ${item.age}" : item.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: item.actionText),
        ],
      ),
    );
  }
}
