import 'package:flutter/material.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';

enum InFrom { left, right, top, bottom }

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.pagePadding(context),
      child: ListView(
        children: [
          _StaggerIn(
            controller: _c,
            start: 0.00,
            end: 0.45,
            from: InFrom.top,
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tasks & Goals', style: AppText.h2),
                      SizedBox(height: 6),
                      Text(
                        'Manage your tasks and track weekly progress',
                        style: TextStyle(color: AppColors.text3),
                      ),
                    ],
                  ),
                ),
                // FilledButton.icon(
                //   onPressed: () {},
                //   icon: const Icon(Icons.add),
                //   label: const Text('New Task'),
                // ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _StaggerIn(
            controller: _c,
            start: 0.10,
            end: 0.95,
            from: InFrom.left,
            child: _weeklyGoals(controller: _c),
          ),

          const SizedBox(height: 16),

          _StaggerIn(
            controller: _c,
            start: 0.25,
            end: 1.00,
            from: InFrom.bottom,
            child: _kanban(context),
          ),
        ],
      ),
    );
  }

  // ---------------- Weekly Goals (progress 0 -> target) ----------------

  Widget _weeklyGoals({required AnimationController controller}) {
    int weekNumber(DateTime date) {
      final firstDayOfYear = DateTime(date.year, 1, 1);
      final daysOffset = firstDayOfYear.weekday - DateTime.monday;
      final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));
      final difference = date.difference(firstMonday).inDays;
      return (difference / 7).floor() + 1;
    }
    final now = DateTime.now();
    final week = weekNumber(now);
    final year = now.year;
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const Icon(Icons.track_changes, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Weekly Goals', style: AppText.h3),
            const Spacer(),
            UiChip(
              'Week $week, $year',
              selected: true,
              color: AppColors.primary,
            ),
          ],
        ),
        const SizedBox(height: 14),

        _goalAnimated('Complete ChortoqGo MVP features', 0.05,
            controller: controller, start: 0.18, end: 0.72, from: InFrom.left),
        const SizedBox(height: 12),

        _goalAnimated('Write technical documentation', 0.40,
            controller: controller, start: 0.24, end: 0.78, from: InFrom.right),
        const SizedBox(height: 12),

        _goalAnimated('Code review & refactoring', 0.80,
            controller: controller, start: 0.30, end: 0.84, from: InFrom.left),
        const SizedBox(height: 12),

        _goalAnimated('Learn advanced Flutter animations', 0.55,
            controller: controller, start: 0.36, end: 0.90, from: InFrom.right),
      ]),
    );
  }

  Widget _goalAnimated(
      String title,
      double target, {
        required AnimationController controller,
        required double start,
        required double end,
        required InFrom from,
      }) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    // ✅ sekinroq to‘lishi uchun end 1.0 gacha cho‘zib yuboramiz
    final progress = Tween<double>(begin: 0, end: target).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start + 0.06, 1.0, curve: Curves.easeOutExpo),
      ),
    );

    return _StaggerIn(
      controller: controller,
      start: start,
      end: end,
      from: from,
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
              Expanded(
                child: Text(
                  title,
                  style: AppText.body.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              AnimatedBuilder(
                animation: progress,
                builder: (_, __) {
                  final pct = (progress.value * 100).round();
                  return Text(
                    '$pct%',
                    style: AppText.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 6,
              color: AppColors.accent.withOpacity(0.7),
              child: AnimatedBuilder(
                animation: progress,
                builder: (_, __) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.value,
                    child: Container(color: AppColors.primary),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // ---------------- Kanban ----------------

  Widget _kanban(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final oneCol = c.maxWidth < 1100;

      // ✅ 1 column bo‘lganda pastga tushsin (stacked)
      if (oneCol) {
        return Column(
          children: [
            _column(
              'Backlog',
              3,
              AppColors.text2,
              [
                _task('High', AppColors.red, 'Implement push notifications',
                    'Add FCM integration for real-time notifications',
                    'ChortoqGo', 'Mar 5'),
                _task('Medium', AppColors.orange, 'Add unit tests',
                    'Write tests for authentication module',
                    'ChortoqGo', 'Mar 8'),
                _task('Low', AppColors.primary, 'Design user onboarding',
                    'Create onboarding screens wireframes',
                    'Praga Cafe', 'Mar 10'),
              ],
              controller: _c,
              colIndex: 0,
              from: InFrom.left,
            ),
            const SizedBox(height: 16),
            _column(
              'In Progress',
              2,
              AppColors.primary,
              [
                _task('High', AppColors.red, 'Build payment integration',
                    'Integrate payments for orders and bookings',
                    'ChortoqGo', 'Mar 2'),
                _task('Medium', AppColors.orange, 'Optimize app performance',
                    'Reduce app load time and memory usage',
                    'E-Hisob', 'Mar 4'),
                // _addTask(),
              ],
              controller: _c,
              colIndex: 1,
              from: InFrom.right,
            ),
            const SizedBox(height: 16),
            _column(
              'Done',
              3,
              AppColors.green,
              [
                _task('High', AppColors.red, 'Setup BLoC architecture',
                    'Configure BLoC pattern for state management',
                    'ChortoqGo', 'Feb 25'),
                _task('High', AppColors.red, 'Create dashboard UI',
                    'Design and implement main dashboard',
                    'E-Hisob', 'Feb 27'),
                _task('Low', AppColors.primary, 'Add dark theme',
                    'Implement dark mode support',
                    'Praga Cafe', 'Feb 28'),
              ],
              controller: _c,
              colIndex: 2,
              from: InFrom.bottom,
            ),
          ],
        );
      }

      // ✅ Desktop 3 column
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _column(
              'Backlog',
              3,
              AppColors.text2,
              [
                _task('High', AppColors.red, 'Implement push notifications',
                    'Add FCM integration for real-time notifications',
                    'ChortoqGo', 'Mar 5'),
                _task('Medium', AppColors.orange, 'Add unit tests',
                    'Write tests for authentication module',
                    'ChortoqGo', 'Mar 8'),
                _task('Low', AppColors.primary, 'Design user onboarding',
                    'Create onboarding screens wireframes',
                    'Praga Cafe', 'Mar 10'),
              ],
              controller: _c,
              colIndex: 0,
              from: InFrom.left,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _column(
              'In Progress',
              2,
              AppColors.primary,
              [
                _task('High', AppColors.red, 'Build payment integration',
                    'Integrate payments for orders and bookings',
                    'ChortoqGo', 'Mar 2'),
                _task('Medium', AppColors.orange, 'Optimize app performance',
                    'Reduce app load time and memory usage',
                    'E-Hisob', 'Mar 4'),
                // _addTask(),
              ],
              controller: _c,
              colIndex: 1,
              from: InFrom.top,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _column(
              'Done',
              3,
              AppColors.green,
              [
                _task('High', AppColors.red, 'Setup BLoC architecture',
                    'Configure BLoC pattern for state management',
                    'ChortoqGo', 'Feb 25'),
                _task('High', AppColors.red, 'Create dashboard UI',
                    'Design and implement main dashboard',
                    'E-Hisob', 'Feb 27'),
                _task('Low', AppColors.primary, 'Add dark theme',
                    'Implement dark mode support',
                    'Praga Cafe', 'Feb 28'),
              ],
              controller: _c,
              colIndex: 2,
              from: InFrom.right,
            ),
          ),
        ],
      );
    });
  }

  Widget _column(
      String title,
      int count,
      Color underline,
      List<Widget> children, {
        required AnimationController controller,
        required int colIndex,
        required InFrom from,
      }) {
    final colStart = (0.30 + colIndex * 0.08).clamp(0.30, 0.65).toDouble();
    final colEnd = (colStart + 0.35).clamp(0.55, 1.0).toDouble();

    return _StaggerIn(
      controller: controller,
      start: colStart,
      end: colEnd,
      from: from,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              title,
              style: AppText.body.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.text2,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.card2,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.stroke),
              ),
              child: Text('$count',
                  style: AppText.caption.copyWith(color: AppColors.text3)),
            ),
          ]),
          const SizedBox(height: 6),
          Container(
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              color: underline,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(height: 14),
          ...children.map(
                (w) => Padding(padding: const EdgeInsets.only(bottom: 14), child: w),
          ),
        ],
      ),
    );
  }

  Widget _task(
      String pr,
      Color prColor,
      String title,
      String desc,
      String tag,
      String date,
      ) {
    return UiCard(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          UiChip(pr, selected: true, color: prColor),
          const Spacer(),
          const Icon(Icons.more_horiz, color: AppColors.text3),
        ]),
        const SizedBox(height: 10),
        Text(title, style: AppText.body.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        Text(desc, style: AppText.body2.copyWith(color: AppColors.text3)),
        const SizedBox(height: 12),
        Row(
          children: [
            UiChip(tag),
            const Spacer(),
            Icon(Icons.schedule, size: 14, color: AppColors.text3),
            const SizedBox(width: 6),
            Text(date, style: AppText.caption.copyWith(color: AppColors.text3)),
            const SizedBox(width: 10),
            const Icon(Icons.person_outline, size: 14, color: AppColors.text3),
            const SizedBox(width: 6),
            Text('Nurmuxammad',
                style: AppText.caption.copyWith(color: AppColors.text3)),
          ],
        ),
      ]),
    );
  }

  // Widget _addTask() {
  //   return Container(
  //     height: 70,
  //     decoration: BoxDecoration(
  //       color: Colors.transparent,
  //       borderRadius: BorderRadius.circular(14),
  //       border: Border.all(color: AppColors.stroke),
  //     ),
  //     alignment: Alignment.center,
  //     child: Text('+ Add task', style: AppText.body.copyWith(color: AppColors.text3)),
  //   );
  // }
}

class _StaggerIn extends StatelessWidget {
  final AnimationController controller;
  final double start;
  final double end;
  final InFrom from;
  final Widget child;
  final double distance;

  const _StaggerIn({
    required this.controller,
    required this.child,
    required this.start,
    required this.end,
    this.from = InFrom.bottom,
    this.distance = 0.08,
  });

  Offset _beginOffset() {
    switch (from) {
      case InFrom.left:
        return Offset(-distance, 0);
      case InFrom.right:
        return Offset(distance, 0);
      case InFrom.top:
        return Offset(0, -distance);
      case InFrom.bottom:
        return Offset(0, distance);
    }
  }

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(curve),
      child: SlideTransition(
        position: Tween<Offset>(begin: _beginOffset(), end: Offset.zero).animate(curve),
        child: child,
      ),
    );
  }
}