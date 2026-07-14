import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../home/domain/entities/user_entity.dart';
import 'rose_compliment_sheet.dart';

class HomeProfileDetails extends StatelessWidget {
  final UserEntity user;
  const HomeProfileDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final id = user.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _LightBadgesRow(user: user),
        ),
        const SizedBox(height: 20),

        // ── ABOUT ──
        const _SectionLabel(text: 'ABOUT'),
        const SizedBox(height: 10),
        _SectionWithRose(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Building products by day, planning my next trek by night. Looking for someone equally driven and equally curious.',
              style: AppTextStyles.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── THE BASICS ──
        const _SectionLabel(text: 'THE BASICS'),
        const SizedBox(height: 10),
        _SectionWithRose(
          child: _InfoCard(rows: [
            const _InfoRow(icon: Icons.cake_outlined, label: 'Age', value: '21 years old', subtitle: '19 feb 1999'),
            const _InfoRow(icon: Icons.straighten, label: 'Height', value: '5\'5" (165 cm)'),
            const _InfoRow(icon: Icons.location_on_outlined, label: 'Lives in', value: 'Koregaon park', subtitle: 'Pune, Maharashtra'),
            const _InfoRow(icon: Icons.favorite_border, label: 'Love language', value: 'Compliment', subtitle: 'Words of affirmation'),
            const _InfoRow(icon: Icons.mosque_outlined, label: 'Religion', value: 'Hindu-Marathi'),
            const _InfoRow(icon: Icons.format_list_bulleted, label: 'Interested in', value: 'Women - Dating'),
            const _InfoRow(icon: Icons.wb_sunny_outlined, label: 'Zodiac', value: 'Scorpio', subtitle: 'Loyal - Passionate - Intuitive'),
            const _InfoRow(icon: Icons.translate, label: 'Mother tongue', value: 'Marathi'),
            const _InfoRow(icon: Icons.phone_outlined, label: 'Communication style', value: 'Phone calls over texts'),
          ]),
        ),
        const SizedBox(height: 16),

        // ── Video ──
        _SectionWithRose(
          child: _VideoCard(caption: 'Video intro · 0:28', userId: id),
        ),
        const SizedBox(height: 16),

        // ── Prompt: Win me over ──
        const _SectionWithRose(
          child: _PromptCard(
            prompt: 'The way to win me over is...',
            answer: 'A good book rec and a strong chai opinion.',
          ),
        ),
        const SizedBox(height: 16),

        // ── CAREER & AMBITION ──
        const _SectionLabel(text: 'CAREER & AMBITION'),
        const SizedBox(height: 10),
        _SectionWithRose(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _InfoRow(icon: Icons.school_outlined, label: 'Education', value: 'NIFT Pune', subtitle: 'B. Des Fashion Design · 3rd year'),
                const Divider(height: 1, color: AppColors.divider, indent: 48, endIndent: 0),
                const _InfoRow(icon: Icons.work_outline, label: 'Work as', value: 'Fashion Design', subtitle: 'Freelance · 2 yrs exp'),
                const Divider(height: 1, color: AppColors.divider, indent: 48, endIndent: 0),
                const _InfoRow(icon: Icons.auto_awesome_outlined, label: 'Work style', value: 'Creative · Hybrid'),
                const Divider(height: 1, color: AppColors.divider, indent: 48, endIndent: 0),
                const _InfoRow(icon: Icons.trending_up, label: 'Ambition level', value: 'HIGHLY DRIVEN', bold: true),
                const Divider(height: 1, color: AppColors.divider, indent: 16, endIndent: 16),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('HER BIG DREAM', style: AppTextStyles.sectionLabel),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
                  child: Text(
                    'Launch her own sustainable Indian fashion label — handcrafted, slow fashion made with heart. Also wants to travel every fashion capital before 30.',
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Detail Photo ──
        _SectionWithRose(
          child: _DetailPhoto(photoUrl: user.photoUrl, index: 1, userId: id),
        ),
        const SizedBox(height: 16),

        // ── Prompt: My simple pleasures ──
        const _SectionWithRose(
          child: _PromptCard(
            prompt: 'My simple pleasures...',
            answer: 'Roadside chai after a long trek, no signal, good company.',
          ),
        ),
        const SizedBox(height: 16),

        // ── INTERESTS & HOBBIES ──
        const _SectionLabel(text: 'INTERESTS & HOBBIES'),
        const SizedBox(height: 12),
        _SectionWithRose(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _HobbyChip(label: 'Travel', icon: Icons.flight_outlined),
                _HobbyChip(label: 'Coffee', icon: Icons.coffee_outlined),
                _HobbyChip(label: 'Trekking', icon: Icons.terrain_outlined),
                _HobbyChip(label: 'Books', icon: Icons.menu_book_outlined),
                _HobbyChip(label: 'Yoga', icon: Icons.self_improvement),
                _HobbyChip(label: 'Indie music', icon: Icons.music_note_outlined),
                _HobbyChip(label: 'Cooking', icon: Icons.favorite_border),
                _HobbyChip(label: 'Photography', icon: Icons.camera_alt_outlined),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── LIFESTYLE ──
        const _SectionLabel(text: 'LIFESTYLE'),
        const SizedBox(height: 10),
        const _SectionWithRose(
          child: _InfoCard(rows: [
            _InfoRow(icon: Icons.restaurant_outlined, label: 'Diet', value: 'Vegetarian'),
            _InfoRow(icon: Icons.wine_bar_outlined, label: 'Drinking', value: 'Socially'),
            _InfoRow(icon: Icons.smoke_free, label: 'Smoking', value: 'Non-smoker'),
            _InfoRow(icon: Icons.fitness_center, label: 'Fitness', value: 'Gym 4x/week', subtitle: 'Yoga · Trekking'),
            _InfoRow(icon: Icons.explore_outlined, label: 'Travel', value: '4-5 trips/year'),
            _InfoRow(icon: Icons.pets_outlined, label: 'Pets', value: 'Cat parent'),
            _InfoRow(icon: Icons.bedtime_outlined, label: 'Sleep', value: 'Night Owl'),
          ]),
        ),
        const SizedBox(height: 16),

        // ── DATING GOAL ──
        const _GoalCard(
          goal: 'Long-term, marriage-open',
          desc: 'No pressure, no timelines — just looking for the right person to build something real with.',
        ),
        const SizedBox(height: 20),

        // ── Bottom Detail Photo ──
        _SectionWithRose(
          child: _DetailPhoto(photoUrl: user.photoUrl, index: 2, userId: id),
        ),
        const SizedBox(height: 16),

        // ── Prompt: We'll get along if ──
        const _SectionWithRose(
          child: _PromptCard(
            prompt: "We'll get along if...",
            answer: 'You can debate me for an hour and still want dessert after.',
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

/// Wraps a child widget and positions a rose pin at the bottom-right,
/// overlapping the child's bottom edge.
class _SectionWithRose extends StatelessWidget {
  final Widget child;
  const _SectionWithRose({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 24),
            child: _RosePin(),
          ),
        ),
      ],
    );
  }
}

class _ColorPhoto extends StatelessWidget {
  final int index;
  final String userId;
  const _ColorPhoto({required this.index, required this.userId});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFF4A9EFF),
      const Color(0xFF2DD87F),
    ];
    return Container(
      color: colors[index % colors.length].withValues(alpha: 0.7),
      child: const Center(
          child: Icon(Icons.person_outline, size: 80, color: Colors.white38)),
    );
  }
}

class _LightBadgesRow extends StatelessWidget {
  final UserEntity user;
  const _LightBadgesRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _LightBadge(dot: AppColors.matchBlue, label: '${user.matchPercent}% Match'),
        _LightBadge(dot: AppColors.trustGreen, label: '${user.trustPercent}% Trust'),
        _LightBadge(dot: AppColors.replyOrange, label: '~${user.replyTime} Replies'),
      ],
    );
  }
}

class _LightBadge extends StatelessWidget {
  final Color dot;
  final String label;
  const _LightBadge({required this.dot, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
          const SizedBox(width: 5),
          Text(label, style: AppTextStyles.badgeLabelLight),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(text, style: AppTextStyles.sectionLabel),
    );
  }
}

class _RosePin extends StatelessWidget {
  const _RosePin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppColors.divider,
          width: 0.5,
        ),
      ),
      child: const Center(
        child: Text('🌹', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<_InfoRow> rows;
  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        children: rows.asMap().entries.map((e) {
          final isLast = e.key == rows.length - 1;
          return Column(
            children: [
              e.value,
              if (!isLast)
                const Divider(
                    height: 1,
                    color: AppColors.divider,
                    indent: 48,
                    endIndent: 0),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final bool bold;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle = '',
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: AppTextStyles.detailLabel),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                  style: bold
                      ? AppTextStyles.detailValue.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        )
                      : AppTextStyles.detailValue),
              if (subtitle.isNotEmpty)
                Text(subtitle, style: AppTextStyles.detailValueSub),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailPhoto extends StatelessWidget {
  final String photoUrl;
  final int index;
  final String userId;

  const _DetailPhoto({
    required this.photoUrl,
    required this.index,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.surfaceMedium,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (photoUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: photoUrl,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) =>
                  _ColorPhoto(index: index, userId: userId),
            )
          else
            _ColorPhoto(index: index, userId: userId),
        ],
      ),
    );
  }
}

class _HobbyChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _HobbyChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String goal;
  final String desc;
  const _GoalCard({required this.goal, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DATING GOAL', style: AppTextStyles.goalLabel),
          const SizedBox(height: 8),
          Text(goal, style: AppTextStyles.goalTitle),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.goalBody),
        ],
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  final String prompt;
  final String answer;
  const _PromptCard({required this.prompt, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 0.5),
        boxShadow: const [
          BoxShadow(
              color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prompt,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: AppColors.textPrimary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => showRoseComplimentSheet(context, title: prompt),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x18000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: AppColors.divider,
                  width: 0.5,
                ),
              ),
              child: const Center(
                child: Text('🌹', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatefulWidget {
  final String caption;
  final String userId;
  const _VideoCard({required this.caption, required this.userId});

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> {
  bool _playing = false;

  static const List<List<Color>> _gradients = [
    [Color(0xFF1A1A2E), Color(0xFF16213E)],
    [Color(0xFF0F3460), Color(0xFF1A1A2E)],
    [Color(0xFF2D1B69), Color(0xFF11998E)],
    [Color(0xFF373B44), Color(0xFF4286F4)],
  ];

  @override
  Widget build(BuildContext context) {
    final idx = widget.userId.hashCode.abs() % _gradients.length;
    final colors = _gradients[idx];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: const [
          BoxShadow(
              color: Color(0x18000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _playing ? '0:12 / 0:31' : '0:00 / 0:31',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: _playing ? 0.38 : 0.0,
                    backgroundColor: Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 3,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _playing = !_playing),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: _playing ? 0.0 : 0.25),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.7),
                    width: 2,
                  ),
                ),
                child: Icon(
                  _playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
