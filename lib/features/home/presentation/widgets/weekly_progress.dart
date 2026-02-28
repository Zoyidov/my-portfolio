import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';

class WeeklyProgress extends StatelessWidget {
  const WeeklyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const Icon(Icons.trending_up, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Weekly Progress', style: AppText.h3),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
        _row('Code commits', 18, 0.90),
        const SizedBox(height: 12),
        _row('Tasks completed', 12, 0.75),
        const SizedBox(height: 12),
        _row('Learning hours', 8, 0.55),
        const SizedBox(height: 12),
        _row('Code reviews', 5, 0.35),
        const SizedBox(height: 18),
        Row(
          children: [
            Text('Overall Progress', style: AppText.body.copyWith(color: AppColors.text2)),
            const Spacer(),
            Text('82%', style: AppText.h3.copyWith(color: AppColors.primary)),
          ],
        ),
      ]),
    );
  }

  Widget _row(String label, int value, double progress) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(label, style: AppText.body2.copyWith(color: AppColors.text3)),
          const Spacer(),
          Text('$value', style: AppText.body2.copyWith(color: AppColors.text2)),
        ],
      ),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 6,
          color: AppColors.accent.withOpacity(0.7),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(color: AppColors.primary),
          ),
        ),
      ),
    ]);
  }
}