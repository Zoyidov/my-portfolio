import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../../app/responsive/responsive.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/hero_header.dart';
import '../widgets/stats_row.dart';
import '../widgets/recent_activity.dart';
import '../widgets/weekly_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  bool _played = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _playOnce() {
    if (_played) return;
    _played = true;
    _c.forward(from: 0);
  }

  void _resetAnim() {
    _played = false;
    _c.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..load(),
      child: Padding(
        padding: Responsive.pagePadding(context),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              _resetAnim();
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              _resetAnim();
              return Center(child: Text(state.message));
            }
            if (state is! HomeLoaded) return const SizedBox.shrink();

            _playOnce();
            final d = state.data;

            return ListView(
              children: [
                // 1) Header pastdan
                StaggerIn(
                  controller: _c,
                  start: 0.00,
                  end: 0.35,
                  from: InFrom.bottom,
                  child: HeroHeader(data: d),
                ),
                const SizedBox(height: 16),

                // 2) Stats chapdan
                StaggerIn(
                  controller: _c,
                  start: 0.10,
                  end: 0.45,
                  from: InFrom.left,
                  child: StatsRow(data: d),
                ),
                const SizedBox(height: 16),

                // 3) Kontent bloklar: Recent chapdan, Weekly o‘ngdan / tepdan
                LayoutBuilder(
                  builder: (context, c) {
                    final twoCol = c.maxWidth >= 1100;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: StaggerIn(
                            controller: _c,
                            start: 0.22,
                            end: 0.70,
                            from: InFrom.left,
                            child: const RecentActivity(),
                          ),
                        ),
                        if (twoCol) const SizedBox(width: 16),
                        if (twoCol)
                          Expanded(
                            flex: 4,
                            child: StaggerIn(
                              controller: _c,
                              start: 0.30,
                              end: 0.85,
                              from: InFrom.right,
                              child: const WeeklyProgress(),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),

                // 4) Mobile’da weekly progress full width bo‘lsa tepdan/pastdan
                LayoutBuilder(
                  builder: (context, c) {
                    final showFullWidth = c.maxWidth < 1100;
                    if (!showFullWidth) return const SizedBox.shrink();

                    return StaggerIn(
                      controller: _c,
                      start: 0.35,
                      end: 0.95,
                      from: InFrom.top,
                      child: const WeeklyProgress(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



enum InFrom { left, right, top, bottom }

class StaggerIn extends StatelessWidget {
  final AnimationController controller;
  final double start; // 0..1
  final double end;   // 0..1
  final InFrom from;
  final double distance; // px-like fraction in Offset (0.06-0.12 yaxshi)
  final Widget child;

  const StaggerIn({
    super.key,
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

    final slide = Tween<Offset>(begin: _beginOffset(), end: Offset.zero).animate(curve);
    final fade = Tween<double>(begin: 0, end: 1).animate(curve);

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}