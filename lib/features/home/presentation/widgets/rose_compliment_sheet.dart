import 'package:aryan_task/features/chat/presentation/pages/chat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../pages/compliment_ideas_page.dart';

// ─── Public entry-point ───────────────────────────────────────────────────────

Future<void> showRoseComplimentSheet(BuildContext context, {String title = 'About'}) async {
  final result = await showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => RoseComplimentSheet(title: title),
  );

  if (result != null && context.mounted) {
    final type = result['type']!;
    final text = result['text']!;
    final isRose = type == 'Rose';
    final emoji = isRose ? '🌹' : '🎁';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$emoji $type + 💬 Comment sent! ', style: const TextStyle(color: Colors.white)),
              const TextSpan(text: '✨ Opening chat...', style: TextStyle(color: Color(0xFFFFD700))),
            ]
          ),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF1E1E1E).withValues(alpha: 0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 90, left: 30, right: 30),
        duration: const Duration(seconds: 3),
      ),
    );

    // Wait 2 seconds then navigate to chat
    await Future.delayed(const Duration(seconds: 2));
    
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatDetailPage(chatData: {
            'name': 'Aanya',
            'online': true,
            'sent_type': type,
            'sent_text': text,
          }),
        ),
      );
    }
  }
}

// ─── Sheet Widget ─────────────────────────────────────────────────────────────

class RoseComplimentSheet extends StatefulWidget {
  final String title;
  const RoseComplimentSheet({super.key, this.title = 'About'});

  @override
  State<RoseComplimentSheet> createState() => _RoseComplimentSheetState();
}

class _RoseComplimentSheetState extends State<RoseComplimentSheet> {
  final _controller = TextEditingController();
  bool? _roseSelected;
  bool _liked = true;

  static const int _maxChars = 140;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _trySuggestion() async {
    final selectedIdea = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ComplimentIdeasPage(),
      ),
    );
    if (selectedIdea != null && selectedIdea is String) {
      setState(() {
        _controller.text = selectedIdea;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      });
      if (mounted) {
        // Snackbar is now handled by ComplimentIdeasPage before popping.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 18),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // COMPLIMENTING label
                Text(
                  'COMPLIMENTING',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 4),

                // Prompt title
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Stats row
                Row(
                  children: [
                    _StatChip(
                        icon: Icons.chat_bubble_outline,
                        label: '3 comments',
                        color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    const _StatChip(
                        icon: null,
                        emoji: '🌹',
                        label: '2 roses',
                        color: AppColors.primary),
                    const SizedBox(width: 8),
                    const _StatChip(
                        icon: null,
                        emoji: '🪙',
                        label: '5,258 balance',
                        color: Color(0xFFE6A817)),
                  ],
                ),
                const SizedBox(height: 16),

                // Text input area
                Container(
                  height: 124,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F5F0),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEAE7E0)),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          minLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Write a sweet compliment...',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 46),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),

                      // Try button
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: _trySuggestion,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.divider),
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
                                const Text('💡',
                                    style: TextStyle(fontSize: 12)),
                                const SizedBox(width: 4),
                                Text(
                                  'Try',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Char counter
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${_controller.text.length}/$_maxChars',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Rose + Select Gift row
                Row(
                  children: [
                    Expanded(
                      child: _SelectionButton(
                        emoji: '🌹',
                        label: 'Rose',
                        selected: _roseSelected == true,
                        onTap: () => setState(() => _roseSelected = true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SelectionButton(
                        emoji: '🎁',
                        label: 'Select Gift',
                        selected: _roseSelected == false,
                        onTap: () => setState(() => _roseSelected = false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Like + Send row
                Row(
                  children: [
                    // Like button
                    GestureDetector(
                      onTap: () => setState(() => _liked = !_liked),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _liked ? AppColors.primaryLight : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                _liked ? AppColors.primary : AppColors.divider,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _liked ? Icons.favorite : Icons.favorite_border,
                              color: _liked
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                              size: 20,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Like',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: _liked
                                    ? AppColors.primary
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                     Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed:
                              _controller.text.trim().isNotEmpty
                                  ? () => Navigator.pop(context, {
                                        'type': _roseSelected == true 
                                            ? 'Rose' 
                                            : (_roseSelected == false ? 'Gift' : 'Compliment'),
                                        'text': _controller.text.trim(),
                                      })
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor:
                                AppColors.primary.withValues(alpha: 0.45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _roseSelected == true 
                                ? 'Send 🌹 + 💬' 
                                : (_roseSelected == false ? 'Send 🎁 + 💬' : 'Send 💬'),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;
  final Color color;

  const _StatChip({
    this.icon,
    this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F4F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emoji != null)
            Text(emoji!, style: const TextStyle(fontSize: 13))
          else
            Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionButton extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectionButton({
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
