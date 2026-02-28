import 'package:flutter/material.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';

class WorkStatusPage extends StatelessWidget {
  const WorkStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.pagePadding(context),
      child: ListView(
        children: [
          UiCard(
            padding: const EdgeInsets.all(22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _heroLeft()),
                const SizedBox(width: 16),
                _heroIcon(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          LayoutBuilder(builder: (context, c) {
            final twoCol = c.maxWidth >= 1100;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _contract()),
                if (twoCol) const SizedBox(width: 16),
                if (twoCol) Expanded(child: _preferences()),
              ],
            );
          }),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, c) {
            final showPrefsBelow = c.maxWidth < 1100;
            return showPrefsBelow ? _preferences() : const SizedBox.shrink();
          }),
          const SizedBox(height: 16),
          _history(),
        ],
      ),
    );
  }

  Widget _heroLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiChip('Current Status', selected: true, color: AppColors.orange),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('Busy', style: AppText.h2.copyWith(color: AppColors.red)),
            const Text(' — Working in Farg‘ona', style: AppText.h2),
          ],
        ),
        const SizedBox(height: 6),
        Text('Available from March 2026', style: AppText.body.copyWith(color: AppColors.text3)),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _miniTile('Next Available', 'Not Clear', Icons.calendar_month_outlined, AppColors.primary)),
            const SizedBox(width: 12),
            Expanded(child: _miniTile('Current Project', 'Working in Farg‘ona', Icons.folder_outlined, AppColors.primary)),
          ],
        ),
      ],
    );
  }

  Widget _heroIcon() {
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(colors: [AppColors.orange, Color(0xFFB6D5FF)]),
        boxShadow: const [BoxShadow(blurRadius: 18, color: Color(0x33000000), offset: Offset(0, 10))],
      ),
      child: const Icon(Icons.work_outline, color: Colors.white, size: 32),
    );
  }

  Widget _miniTile(String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 4),
              Text(value, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _contract() {
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.attach_money, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Contract & Compensation', style: AppText.h3),
          ]),
          const SizedBox(height: 14),
          Text('Preferred Contract Type', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: const [
            UiChip('Full-time', selected: true, color: AppColors.primary),
            UiChip('Freelance', selected: true, color: AppColors.primary),
            UiChip('Part-time'),
          ]),

          Text('Expected Salary (Full-time)', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 16),
          Text('Expected Salary (Full-time)', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 8),
          Text('\$1,000 - \$2,000', style: AppText.h3.copyWith(color: AppColors.primary)),
          Text('/ month', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 14),
          Text('Freelance Rate', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 8),
          Text('\$20 - \$40', style: AppText.h3.copyWith(color: AppColors.primary)),
          Text('/ hour', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 14),
          Text('Project-based', style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 8),
          Text('Starting at \$500', style: AppText.h3.copyWith(color: AppColors.primary)),
          Text('/ project', style: AppText.caption.copyWith(color: AppColors.text3)),
        ],
      ),
    );
  }

  Widget _preferences() {
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.tune, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text('Work Preferences', style: AppText.h3),
        ]),
        const SizedBox(height: 14),
        _pref('Work Hours', '40 hours / week', 'Flexible schedule, UTC+5 timezone'),
        const SizedBox(height: 12),
        Text('Work Location', style: AppText.caption.copyWith(color: AppColors.text3)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: const [
          UiChip('Remote Preferred', selected: true, color: AppColors.green),
          UiChip('Hybrid OK'),
        ]),
        const SizedBox(height: 14),
        _pref('Willing to Travel', 'Yes, occasionally', 'For important meetings or events'),
        const SizedBox(height: 14),
        _pref('Communication', 'English & Russian', 'Professional working proficiency'),
        const SizedBox(height: 14),
        _pref('Notice Period', '2 weeks', 'For new opportunities'),
      ]),
    );
  }

  Widget _pref(String title, String value, String sub) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: AppText.caption.copyWith(color: AppColors.text3)),
      const SizedBox(height: 6),
      Text(value, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(sub, style: AppText.caption.copyWith(color: AppColors.text3)),
    ]);
  }

  Widget _history() {
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.history, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Status History', style: AppText.h3),
          ]),
          const SizedBox(height: 16),

          _historyItem(
            title: 'Busy — Working in Fergana',
            badge: 'Full-time',
            badgeColor: AppColors.primary,
            sub: 'Fergana  •  Jan 2026 - Present',
            desc: 'Currently working as a Flutter developer on production-level applications.',
          ),
          const SizedBox(height: 14),

          _historyItem(
            title: 'Available for Freelance',
            badge: 'Freelance',
            badgeColor: AppColors.green,
            sub: 'Multiple Clients  •  Jul 2025 - Dec 2025',
            desc: 'Completed 3 successful freelance projects for international and local clients.',
          ),
          const SizedBox(height: 14),

          _historyItem(
            title: 'Full-time Flutter Developer',
            badge: 'Full-time',
            badgeColor: AppColors.primary,
            sub: 'Tech Solutions Inc.  •  Jan 2024 - Jun 2025',
            desc: 'Built and maintained scalable production Flutter applications.',
          ),
          const SizedBox(height: 14),

          _historyItem(
            title: 'Learning & Upskilling',
            badge: 'Learning',
            badgeColor: AppColors.orange,
            sub: 'Self-Study  •  Jan 2023 - Dec 2023',
            desc: 'Focused on mastering Flutter, Dart, Clean Architecture, and state management patterns.',
          ),
        ],
      ),
    );
  }

  Widget _historyItem({
    required String title,
    required String badge,
    required Color badgeColor,
    required String sub,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
          Container(width: 2, height: 64, color: AppColors.stroke),
        ]),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card2,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(child: Text(title, style: AppText.body.copyWith(fontWeight: FontWeight.w900))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: badgeColor.withOpacity(0.14),
                      border: Border.all(color: badgeColor.withOpacity(0.45)),
                    ),
                    child: Text(badge, style: AppText.caption.copyWith(color: badgeColor, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(sub, style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 8),
              Text(desc, style: AppText.body2.copyWith(color: AppColors.text3)),
            ]),
          ),
        ),
      ],
    );
  }
}