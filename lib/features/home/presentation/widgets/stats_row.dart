import 'package:flutter/material.dart';
import '../../../../app/responsive/adaptive_grid.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';
import '../../domain/entities/home_overview.dart';

class StatsRow extends StatelessWidget {
  final HomeOverview data;
  const StatsRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final cols = AdaptiveGrid.columns(c.maxWidth, min: 1, max: 4);
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: cols,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: cols == 1 ? 3.0 : 2.6,
        children: [
          _stat(
            title: 'Current Focus',
            value: data.currentFocus,
            badge: data.focusStatus,
            icon: Icons.code,
            iconColor: AppColors.primary,
          ),
          _stat(
            title: 'Active Projects',
            value: '${data.activeProjects}',
            sub: data.activeDelta,
            icon: Icons.folder_outlined,
            iconColor: AppColors.purple,
          ),
          _stat(
            title: 'Availability',
            value: data.availability,
            sub: data.availabilityNote,
            icon: Icons.bolt,
            iconColor: AppColors.orange,
          ),
          _taskStat(),
        ],
      );
    });
  }

  Widget _stat({
    required String title,
    required String value,
    String? sub,
    String? badge,
    required IconData icon,
    required Color iconColor,
  }) {
    return UiCard(
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 6),
              Text(value, style: AppText.h3),
              if (badge != null) ...[
                const SizedBox(height: 8),
                UiChip(badge, selected: true, color: AppColors.primary),
              ],
              if (sub != null) ...[
                const SizedBox(height: 8),
                Text(sub, style: AppText.caption.copyWith(color: AppColors.primary)),
              ],
            ]),
          ),
          const SizedBox(width: 12),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Icon(icon, color: iconColor),
          ),
        ],
      ),
    );
  }

  Widget _taskStat() {
    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Tasks Done', style: AppText.caption.copyWith(color: AppColors.text3)),
        const SizedBox(height: 6),
        const Text('24/32', style: AppText.h3),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: 6,
            color: AppColors.accent.withOpacity(0.7),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 24 / 32,
              child: Container(color: AppColors.primary),
            ),
          ),
        ),
      ]),
    );
  }
}