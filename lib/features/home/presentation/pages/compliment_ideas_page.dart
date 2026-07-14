import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class ComplimentIdeasPage extends StatefulWidget {
  const ComplimentIdeasPage({super.key});

  @override
  State<ComplimentIdeasPage> createState() => _ComplimentIdeasPageState();
}

class _ComplimentIdeasPageState extends State<ComplimentIdeasPage> {
  final Map<String, List<String>> _compliments = {
    'Sweet': [
      'Your smile is absolutely contagious 🌞',
      'You have the kind of warmth that makes people feel at home.',
      'There\'s something genuinely lovely about your energy.',
      'I could probably talk to you for hours and never get bored.',
      'You seem like the kind of person who makes ordinary days better.',
      'Your kindness really comes through in your profile.',
    ],
    'Playful': [
      'Are you always this stylish or is today a special occasion?',
      'I have a feeling you\'re the funny one in your friend group.',
      'You look like you know all the best spots in town.',
      'I bet you can\'t beat me at Mario Kart 🏎️',
      'Is it just me, or do we have exactly the same taste in movies?',
    ],
    'Admiring': [
      'I really admire how driven you seem about your work.',
      'Your ambition is honestly inspiring.',
      'It\'s rare to see someone so genuine in how they present themselves.',
      'You clearly have a great eye for the things you love.',
      'The way you talk about your passions is really attractive.',
      'I respect someone who knows exactly what they want.',
    ],
    'Flirty': [
      'Not gonna lie, your smile stopped my scroll 😍',
      'You\'re trouble, I can already tell — the good kind.',
      'If you\'re as fun in person as your profile, I\'m in.',
      'I think we\'d make a dangerously good team ☕➡️🍷',
      'You\'ve got a vibe I can\'t quite look away from.',
      'Coffee, you, and good conversation — when\'s good for you?',
    ],
    'First Date': [
      'I\'d love to take you out for a coffee sometime.',
      'Let\'s skip the small talk, drinks this weekend?',
      'I know a great place with the best tacos, you in?',
      'Would love to get to know you better over dinner.',
    ],
  };

  String _selectedCategory = 'Sweet';
  String? _selectedCompliment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFF0F5), // Light pinkish
                        Color(0xFFF3E8FF), // Light purplish
                        Color(0xFFF9F7F4), // Blend into background
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back_ios_new,
                                  size: 20, color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 74,
                        height: 74,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 36,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Compliment Ideas',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'pick one to make a great first impression',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Sliver Bar (Tabs)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 64.0,
                  maxHeight: 64.0,
                  child: Container(
                    color: const Color(0xFFF9F7F4),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: _compliments.keys.map((category) {
                          final isSelected = category == _selectedCategory;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                  _selectedCompliment = null; // Reset selection on tab change
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : const Color(0xFFF0EBE1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  category,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // Compliments List
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final currentList = _compliments[_selectedCategory]!;
                      final compliment = currentList[index];
                      final isSelected = compliment == _selectedCompliment;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCompliment = compliment;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFDF0F3) // Light pink
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                              boxShadow: [
                                if (!isSelected)
                                  const BoxShadow(
                                    color: Color(0x0A000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  )
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    compliment,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _compliments[_selectedCategory]!.length,
                  ),
                ),
              ),
            ],
          ),

          // Bottom Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F7F4),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF9F7F4).withOpacity(0),
                    const Color(0xFFF9F7F4),
                    const Color(0xFFF9F7F4),
                  ],
                  stops: const [0, 0.2, 1],
                ),
              ),
              child: ElevatedButton(
                onPressed: _selectedCompliment != null
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Compliment added ✨',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: const Color(0xFF222222),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            behavior: SnackBarBehavior.floating,
                            elevation: 4,
                            margin: const EdgeInsets.only(
                                bottom: 120, left: 85, right: 85),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            Navigator.pop(context, _selectedCompliment);
                          }
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: const Color(0xFFEBE6DF),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: const Color(0xFFAFAFAF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Use this compliment',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
