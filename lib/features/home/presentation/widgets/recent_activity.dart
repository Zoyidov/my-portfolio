import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Recent Activity', style: AppText.h3),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Text('Last 7 days', style: AppText.caption.copyWith(color: AppColors.text2)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _tile(
            iconBg: AppColors.primary.withOpacity(0.14),
            icon: Icons.cloud_upload_outlined,
            title: 'Pushed 3 commits to ChortoqGo',
            sub: 'Added authentication flow & user profile screen',
            time: '2 hours ago',
          ),
          const SizedBox(height: 12),
          _tile(
            iconBg: AppColors.green.withOpacity(0.14),
            icon: Icons.check_circle_outline,
            title: 'Completed: Implement BLoC state management',
            sub: 'ChortoqGo project',
            time: '5 hours ago',
          ),
          const SizedBox(height: 12),
          _tile(
            iconBg: AppColors.purple.withOpacity(0.14),
            icon: Icons.note_alt_outlined,
            title: 'New note: Flutter performance optimization',
            sub: 'Best practices for widget rebuilds',
            time: '1 day ago',
          ),
          const SizedBox(height: 12),
          _tile(
            iconBg: AppColors.primary.withOpacity(0.10),
            icon: Icons.merge_type,
            title: 'Merged PR: Dark theme support',
            sub: 'Praga Cafe App',
            time: '2 days ago',
          ),
        ],
      ),
    );
  }

  Widget _tile({
    required Color iconBg,
    required IconData icon,
    required String title,
    required String sub,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppText.body.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(sub, style: AppText.body2.copyWith(color: AppColors.text3)),
              const SizedBox(height: 6),
              Text(time, style: AppText.caption.copyWith(color: AppColors.text3)),
            ]),
          ),
        ],
      ),
    );
  }
}