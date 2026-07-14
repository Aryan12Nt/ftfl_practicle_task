import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

class MatchUser {
  final String name;
  final String imageUrl;
  final String? badge; // e.g. "NEW", "🎁", "💌"

  MatchUser({required this.name, required this.imageUrl, this.badge});
}

class ChatPreview {
  final String name;
  final int age;
  final String imageUrl;
  final String matchPercent; // e.g. "92% Match"
  final String lastMessage; // e.g. "Can't wait to see you tonight at the..."
  final String time; // e.g. "2m"
  final int unreadCount;
  final bool isOnline;
  final bool isTyping;
  final double progress; // 0.0 to 1.0
  final Color progressColor;
  final String progressText;
  final Color progressTextColor;

  ChatPreview({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.matchPercent,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isTyping = false,
    required this.progress,
    required this.progressColor,
    required this.progressText,
    required this.progressTextColor,
  });
}

// ─── Mock Data ──────────────────────────────────────────────────────────────

final List<MatchUser> _newMatches = [
  MatchUser(name: 'Sarah', imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg', badge: 'NEW'),
  MatchUser(name: 'Ariya', imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg', badge: '🎁'),
  MatchUser(name: 'Liam', imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg'),
  MatchUser(name: 'Chloe', imageUrl: 'https://randomuser.me/api/portraits/women/24.jpg', badge: '💌'),
  MatchUser(name: 'Dev', imageUrl: 'https://randomuser.me/api/portraits/men/46.jpg'),
];

final List<ChatPreview> _chatList = [
  ChatPreview(
    name: 'Aanya',
    age: 25,
    imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    matchPercent: '92% Match',
    lastMessage: "Can't wait to see you tonight at the...",
    time: '2m',
    unreadCount: 2,
    isOnline: true,
    progress: 0.8,
    progressColor: const Color(0xFF2EBD59), // Green
    progressText: '🎁 Gift unlocked!',
    progressTextColor: const Color(0xFF2EBD59),
  ),
  ChatPreview(
    name: 'Jordan',
    age: 27,
    imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
    matchPercent: '88% Match',
    lastMessage: 'Typing...',
    time: 'Now',
    isTyping: true,
    isOnline: true,
    progress: 0.65,
    progressColor: const Color(0xFFE35D7A), // Reddish
    progressText: '18/25 for Premium Rose 🌹',
    progressTextColor: Colors.black54,
  ),
  ChatPreview(
    name: 'Marcus',
    age: 29,
    imageUrl: 'https://randomuser.me/api/portraits/men/71.jpg',
    matchPercent: '75% Match',
    lastMessage: 'That sounds like an amazing hobby! Ho...',
    time: '1h',
    progress: 0.2,
    progressColor: const Color(0xFFE35D7A),
    progressText: '5/25 - Deadline 14h ⏰',
    progressTextColor: const Color(0xFFE35D7A),
  ),
  ChatPreview(
    name: 'Elena',
    age: 23,
    imageUrl: 'https://randomuser.me/api/portraits/women/12.jpg',
    matchPercent: '95% Match',
    lastMessage: "You: Hey! I'm heading over now.",
    time: '3h',
    isOnline: true,
    progress: 0.9,
    progressColor: const Color(0xFFE35D7A),
    progressText: '22/25 for Silver Ring 💍',
    progressTextColor: Colors.black54,
  ),
  ChatPreview(
    name: 'Rohan',
    age: 26,
    imageUrl: 'https://randomuser.me/api/portraits/men/55.jpg',
    matchPercent: '81% Match',
    lastMessage: 'Yesterday',
    time: 'Yesterday',
    progress: 0.0,
    progressColor: Colors.transparent,
    progressText: '',
    progressTextColor: Colors.black54,
  ),
];

// ─── Main Page ──────────────────────────────────────────────────────────────

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

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
        break;
      case NavTab.events:
        context.go(AppRoutes.events);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4), // Beige background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Icon(Icons.settings_outlined, color: Colors.black87, size: 20),
                  ),
                ],
              ),
            ),

            // 2. Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEBE6DF)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black45, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Search matches or messages',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3. NEW MATCHES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NEW MATCHES',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE35D7A),
                      letterSpacing: 1.2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'See all ',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                      const Icon(Icons.arrow_forward_rounded, size: 12, color: Colors.black54),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _newMatches.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final match = _newMatches[index];
                  return Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE35D7A), width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(match.imageUrl),
                            ),
                          ),
                          if (match.badge != null)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: match.badge == 'NEW' 
                                    ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                                    : const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: match.badge == 'NEW' ? const Color(0xFFE35D7A) : const Color(0xFFFFD700),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                                child: Text(
                                  match.badge!,
                                  style: GoogleFonts.poppins(
                                    fontSize: match.badge == 'NEW' ? 8 : 10,
                                    fontWeight: FontWeight.bold,
                                    color: match.badge == 'NEW' ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.name,
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 4. Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: const [
                  _FilterChip(label: 'All', isSelected: true),
                  _FilterChip(label: 'Unread', isSelected: false),
                  _FilterChip(label: 'Online', isSelected: false),
                  _FilterChip(label: 'Nearby', isSelected: false),
                  _FilterChip(label: 'Date Invites', isSelected: false),
                ],
              ),
            ),
            
            const SizedBox(height: 4),

            // 5. Chat List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _chatList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final chat = _chatList[index];
                  return _ChatCard(chat: chat);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: NavTab.chat,
        onTabSelected: (tab) => _navigateToTab(context, tab),
      ),
    );
  }
}

// ─── Sub Widgets ────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE35D7A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? const Color(0xFFE35D7A) : const Color(0xFFEBE6DF)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final ChatPreview chat;

  const _ChatCard({required this.chat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutes.chatDetail,
          extra: {
            'name': chat.name,
            'online': chat.isOnline,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(chat.imageUrl),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2EBD59),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Match % and Time
                  Row(
                    children: [
                      Text(
                        '${chat.name}, ${chat.age}',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF0F3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          chat.matchPercent,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFE35D7A),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        chat.time,
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.black45),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Last Message and Unread Badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: chat.isTyping ? const Color(0xFFE35D7A) : Colors.black54,
                            fontWeight: chat.unreadCount > 0 ? FontWeight.w600 : FontWeight.w400,
                            fontStyle: chat.isTyping ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE35D7A),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${chat.unreadCount}',
                              style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar
                  if (chat.progress > 0 || chat.progressText.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0EBE1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: chat.progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: chat.progressColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          chat.progressText,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: chat.progressTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
