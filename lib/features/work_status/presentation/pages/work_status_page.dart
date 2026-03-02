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
          _hero(context),
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

  // =========================
  // HERO (mobile-first)
  // =========================
  Widget _hero(BuildContext context) {
    return UiCard(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 640;

          final iconSize = isMobile ? 60.0 : 74.0;
          final titleStyle = isMobile ? AppText.h3 : AppText.h2;

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.stroke.withOpacity(0.8)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.card,
                  AppColors.card.withOpacity(0.65),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // chip + icon (safe on mobile)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: UiChip(
                          'Current Status',
                          selected: true,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                    _heroIconSized(iconSize),
                  ],
                ),
                const SizedBox(height: 14),

                // Title (wraps, no overflow)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Busy',
                        style: titleStyle.copyWith(color: AppColors.red),
                      ),
                      TextSpan(
                        text: ' — Working in Fergana',
                        style: titleStyle,
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 8),

                // Availability
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: AppColors.text3),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Available only for freelance projects or part-time roles',
                        style: AppText.body.copyWith(color: AppColors.text3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Mini tiles: responsive (mobile => full width)
                LayoutBuilder(
                  builder: (context, cc) {
                    final tw = cc.maxWidth;
                    final tileW = isMobile ? tw : (tw - 12) / 2;

                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: tileW,
                          child: _miniTileV2(
                            title: 'Next Available',
                            value: 'Not Clear',
                            icon: Icons.calendar_month_outlined,
                            iconColor: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          width: tileW,
                          child: _miniTileV2(
                            title: 'Current Work',
                            value: 'Working in Fergana',
                            icon: Icons.folder_outlined,
                            iconColor: AppColors.primary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _heroIconSized(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [AppColors.orange, Color(0xFFB6D5FF)],
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            color: Color(0x33000000),
            offset: Offset(0, 10),
          )
        ],
      ),
      child: const Icon(Icons.work_outline, color: Colors.white, size: 30),
    );
  }

  Widget _miniTileV2({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withOpacity(0.25)),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.caption.copyWith(color: AppColors.text3),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.body.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CONTRACT
  // =========================
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

          Text('Preferred Contract Type',
              style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: const [
            UiChip('Full-time', selected: true, color: AppColors.primary),
            UiChip('Freelance', selected: true, color: AppColors.primary),
            UiChip('Part-time'),
          ]),
          const SizedBox(height: 14),

          Text('Expected Salary (Full-time)',
              style: AppText.caption.copyWith(color: AppColors.text3)),
          const SizedBox(height: 8),
          Text('\$1,000 - \$2,000',
              style: AppText.h3.copyWith(color: AppColors.primary)),
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

  // =========================
  // PREFERENCES
  // =========================
  Widget _preferences() {
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }

  Widget _pref(String title, String value, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppText.caption.copyWith(color: AppColors.text3)),
        const SizedBox(height: 6),
        Text(value, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(sub, style: AppText.caption.copyWith(color: AppColors.text3)),
      ],
    );
  }

  // =========================
  // HISTORY
  // =========================
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
    return LayoutBuilder(
      builder: (context, c) {
        final isMobile = c.maxWidth < 520;

        // Mobile’da timeline chap tomondan kam joy olsin
        final dot = Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        );

        final line = Container(
          width: 2,
          height: isMobile ? 52 : 64,
          color: AppColors.stroke,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [dot, line]),
            SizedBox(width: isMobile ? 10 : 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppText.body.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: badgeColor.withOpacity(0.14),
                            border: Border.all(color: badgeColor.withOpacity(0.45)),
                          ),
                          child: Text(
                            badge,
                            style: AppText.caption.copyWith(
                              color: badgeColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(sub, style: AppText.caption.copyWith(color: AppColors.text3)),
                    const SizedBox(height: 8),
                    Text(desc, style: AppText.body2.copyWith(color: AppColors.text3)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}