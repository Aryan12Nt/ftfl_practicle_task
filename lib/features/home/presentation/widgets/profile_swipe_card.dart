import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/info_badge_pill.dart';
import '../../domain/entities/user_entity.dart';
import 'rose_compliment_sheet.dart';

class ProfileSwipeCard extends StatefulWidget {
  final UserEntity user;
  final bool isVerified;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onUndo;
  final VoidCallback? onMore;
  final VoidCallback? onLike;
  final VoidCallback? onTap;

  const ProfileSwipeCard({
    super.key,
    required this.user,
    this.isVerified = false,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onUndo,
    this.onMore,
    this.onLike,
    this.onTap,
  });

  @override
  State<ProfileSwipeCard> createState() => _ProfileSwipeCardState();
}

class _ProfileSwipeCardState extends State<ProfileSwipeCard>
    with TickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;

  static const double _swipeThreshold = 0.25;
  static const double _maxRotationDeg = 15.0;

  void onHorizontalDragStart(DragStartDetails details) {
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = Offset(_dragOffset.dx + details.delta.dx, 0);
    });
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * _swipeThreshold;

    if (_dragOffset.dx.abs() > threshold) {
      flyOff(_dragOffset.dx > 0);
    } else {
      snapBack();
    }
  }

  void flyOff(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final target = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;

    final flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    final flyX = Tween<double>(begin: _dragOffset.dx, end: target)
        .animate(CurvedAnimation(parent: flyController, curve: Curves.easeOut));
    final flyY = Tween<double>(begin: _dragOffset.dy, end: _dragOffset.dy + 60)
        .animate(CurvedAnimation(parent: flyController, curve: Curves.easeOut));

    flyController.addListener(() {
      if (mounted) {
        setState(() {
          _dragOffset = Offset(flyX.value, flyY.value);
        });
      }
    });

    flyController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        flyController.dispose();
        if (isRight) {
          widget.onSwipeRight?.call();
        } else {
          widget.onSwipeLeft?.call();
        }
      }
    });

    flyController.forward();
  }

  void snapBack() {
    final snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    final snapX = Tween<double>(begin: _dragOffset.dx, end: 0.0).animate(
        CurvedAnimation(parent: snapController, curve: Curves.elasticOut));
    final snapY = Tween<double>(begin: _dragOffset.dy, end: 0.0).animate(
        CurvedAnimation(parent: snapController, curve: Curves.elasticOut));

    snapController.addListener(() {
      if (mounted) {
        setState(() {
          _dragOffset = Offset(snapX.value, snapY.value);
        });
      }
    });

    snapController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        snapController.dispose();
      }
    });

    snapController.forward();
  }

  double get _currentRotation {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final normalized = (_dragOffset.dx / screenWidth).clamp(-1.0, 1.0);
    return normalized * _maxRotationDeg * (3.14159 / 180);
  }

  double get _dragOpacity {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final absX = _dragOffset.dx.abs();
    return (1.0 - (absX / (screenWidth * 0.9))).clamp(0.3, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final cardH = screenH * 0.77;

    return GestureDetector(
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onTap: widget.onTap,
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(
          angle: _currentRotation,
          child: Opacity(
            opacity: _dragOpacity,
            child: CardContent(
              user: widget.user,
              isVerified: widget.isVerified,
              cardHeight: cardH,
              onUndo: widget.onUndo,
              onMore: widget.onMore,
              onLike: widget.onLike,
              dragOffsetX: _dragOffset.dx,
            ),
          ),
        ),
      ),
    );
  }
}


class CardContent extends StatelessWidget {
  final UserEntity user;
  final bool isVerified;
  final double cardHeight;
  final VoidCallback? onUndo;
  final VoidCallback? onMore;
  final VoidCallback? onLike;
  final double dragOffsetX;

  const CardContent({
    required this.user,
    this.isVerified = false,
    required this.cardHeight,
    this.onUndo,
    this.onMore,
    this.onLike,
    this.dragOffsetX = 0,
  });

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: screenW,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppSpacing.cardBorderRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x28000000),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ProfilePhoto(photoUrl: user.photoUrl),

                  const GradientScrim(),

                  if (dragOffsetX > 20)
                    Positioned(
                      top: 48,
                      left: 20,
                      child: SwipeLabel(
                          label: 'LIKE', color: AppColors.trustGreen),
                    ),
                  if (dragOffsetX < -20)
                    Positioned(
                      top: 48,
                      right: 20,
                      child:
                          SwipeLabel(label: 'NOPE', color: AppColors.primary),
                    ),

                  Positioned(
                    top: 14,
                    left: 14,
                    child: WhiteCircleBtn(
                      icon: Icons.replay,
                      onTap: onUndo,
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: WhiteCircleBtn(
                      icon: Icons.more_horiz,
                      onTap: onMore,
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CardInfo(user: user, isVerified: isVerified),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 0,
            bottom: 60,
            child: RoseButton(onTap: onLike),
          ),
        ],
      ),
    );
  }
}


class ProfilePhoto extends StatelessWidget {
  final String photoUrl;
  const ProfilePhoto({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return photoUrl.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: photoUrl,
            fit: BoxFit.cover,
            placeholder: (ctx, url) => Container(
              color: AppColors.surfaceLight,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (ctx, url, error) => Container(
              color: const Color(0xFF2A2A2A),
              child: const Center(
                child: Icon(
                  Icons.person_outline,
                  size: 80,
                  color: Colors.white24,
                ),
              ),
            ),
          )
        : Container(
            color: const Color(0xFF2A2A2A),
            child: const Center(
              child: Icon(
                Icons.person_outline,
                size: 80,
                color: Colors.white24,
              ),
            ),
          );
  }
}


class GradientScrim extends StatelessWidget {
  const GradientScrim();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.45, 0.75, 1.0],
          colors: [
            Colors.transparent,
            Colors.transparent,
            Color(0x88000000),
            Color(0xEE000000),
          ],
        ),
      ),
    );
  }
}


class CardInfo extends StatelessWidget {
  final UserEntity user;
  final bool isVerified;
  const CardInfo({required this.user, this.isVerified = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 72, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InfoBadgePill.match(percent: user.matchPercent.toString()),
                const SizedBox(width: 6),
                InfoBadgePill.trust(percent: user.trustPercent.toString()),
                const SizedBox(width: 6),
                InfoBadgePill.reply(time: user.replyTime),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (user.isOnline)
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.onlineGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              Text(
                '${user.firstName} ',
                style: AppTextStyles.cardName,
              ),
              Text(
                '${user.age}',
                style: AppTextStyles.cardAge,
              ),
              if (isVerified)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE35D7A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 14),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 6),

          MetaRow(
            icon: Icons.location_on,
            text: user.displayLocation,
          ),
          const SizedBox(height: 3),
          MetaRow(
            icon: Icons.work_outline,
            text: '${user.occupation} · ${user.height}',
          ),
          const SizedBox(height: 3),
          MetaRow(
            icon: Icons.favorite,
            text: user.relationshipIntent,
          ),
        ],
      ),
    );
  }
}

class MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.cardMeta,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}


class WhiteCircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const WhiteCircleBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF444444), size: 18),
      ),
    );
  }
}


class RoseButton extends StatefulWidget {
  final VoidCallback? onTap;
  const RoseButton({this.onTap});

  @override
  State<RoseButton> createState() => _RoseButtonState();
}

class _RoseButtonState extends State<RoseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => showRoseComplimentSheet(context),
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(_glowAnim.value * 0.45),
                  blurRadius: 16 + (_glowAnim.value * 8),
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text('🌹', style: TextStyle(fontSize: 22)),
            ),
          ),
        );
      },
    );
  }
}


class SwipeLabel extends StatelessWidget {
  final String label;
  final Color color;

  const SwipeLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: label == 'LIKE' ? -0.2 : 0.2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}


class SwipeUpHint extends StatefulWidget {
  const SwipeUpHint();

  @override
  State<SwipeUpHint> createState() => _SwipeUpHintState();
}

class _SwipeUpHintState extends State<SwipeUpHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;
  late Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _bounceAnim = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnim,
      builder: (ctx, _) {
        return Transform.translate(
          offset: Offset(0, _bounceAnim.value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white.withOpacity(0.85),
                size: 28,
              ),
              const SizedBox(height: 2),
              Text(
                'swipe up',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
