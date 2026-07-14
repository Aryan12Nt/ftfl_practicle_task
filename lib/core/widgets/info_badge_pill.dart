import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class InfoBadgePill extends StatelessWidget {
  final Color dotColor;
  final String label;

  const InfoBadgePill({
    super.key,
    required this.dotColor,
    required this.label,
  });

  const InfoBadgePill.match({Key? key, required String percent})
      : this(
          key: key,
          dotColor: AppColors.matchBlue,
          label: '$percent% Match',
        );

  const InfoBadgePill.trust({Key? key, required String percent})
      : this(
          key: key,
          dotColor: AppColors.trustGreen,
          label: '$percent% Trust',
        );

  const InfoBadgePill.reply({Key? key, required String time})
      : this(
          key: key,
          dotColor: AppColors.replyOrange,
          label: '~$time Reply',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pillPaddingH,
        vertical: AppSpacing.pillPaddingV,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.60),
        borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
          width: 0.6,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(label, style: AppTextStyles.badgeLabel),
        ],
      ),
    );
  }
}
