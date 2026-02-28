import 'package:flutter/material.dart';
import '../../../../app/responsive/adaptive_grid.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';
import '../../../../core/widgets/ui_input.dart';

enum InFrom { left, right, top, bottom }

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with SingleTickerProviderStateMixin {
  String filter = 'All';
  String q = '';

  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _replay() => _c.forward(from: 0);

  final projects = const [
    _Project(
      title: 'ChortoqGo',
      status: 'Pending',
      statusColor: AppColors.orange,
      desc:
      'Food ordering platform for the Chartak district of Namangan region: real-time tracking, booking and payment integration.',
      imageAsset: 'assets/images/chortoqgo.png',
      tags: ['Flutter', 'Supabase', 'BLoC', 'Maps', 'Payment'],
      stars: 24,
      forks: 8,
      updated: '2 days ago',
    ),
    _Project(
      title: 'Cafe App',
      status: 'Active',
      statusColor: AppColors.green,
      desc:
      'A modern ordering system for a cafe: menu management, order tracking, and bonus/loyalty features.',
      imageAsset: 'assets/images/cafe.png',
      tags: ['Flutter', 'Firebase', 'Provider'],
      stars: 18,
      forks: 5,
      updated: '1 week ago',
    ),
    // _Project(
    //   title: 'E-Hisob',
    //   status: 'Completed',
    //   statusColor: AppColors.primary,
    //   desc:
    //   'Accounting app for small businesses: income and expenses, invoice/PDF and analytical reports.',
    //   imageAsset: 'assets/images/ehisob.png',
    //   tags: ['Flutter', 'SQLite', 'Cubit', 'PDF'],
    //   stars: 42,
    //   forks: 15,
    //   updated: '2 months ago',
    // ),
    _Project(
      title: 'Weather Pro',
      status: 'Completed',
      statusColor: AppColors.primary,
      desc:
      'Animated weather app: hourly/daily forecast and location-based updates.',
      imageAsset: 'assets/images/weather.png',
      tags: ['Flutter', 'REST API', 'BLoC'],
      stars: 31,
      forks: 12,
      updated: '3 months ago',
    ),
    _Project(
      title: 'Teach Dart',
      status: 'Active',
      statusColor: AppColors.green,
      desc:
      'Dart language learning platform: lessons.',
      imageAsset: 'assets/images/teachdart.png',
      tags: ['Flutter', 'Hive', 'Quiz'],
      stars: 15,
      forks: 4,
      updated: '4 months ago',
    ),
    _Project(
      title: 'Chateo',
      status: 'Active',
      statusColor: AppColors.green,
      desc:
      'Real-time chat app: group chat, media sharing, and private chat.',
      imageAsset: 'assets/images/chateo.png',
      tags: ['Flutter', 'Firebase', 'WebSocket'],
      stars: 55,
      forks: 20,
      updated: '4 months ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: Responsive.pagePadding(context),
      child: ListView(
        children: [
          const Text('Projects', style: AppText.h2),
          const SizedBox(height: 16),

          UiCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: UiSearchInput(
                    hint: 'Search projects...',
                    onChanged: (v) {
                      setState(() => q = v.trim().toLowerCase());
                      _replay();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    _filterChip('All'),
                    _filterChip('Active'),
                    _filterChip('Paused'),
                    _filterChip('Completed'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          LayoutBuilder(builder: (context, c) {
            final cols = AdaptiveGrid.columns(c.maxWidth, min: 1, max: 2);

            final items = projects.where((p) {
              final okFilter = filter == 'All' || p.status == filter;
              final okQ = q.isEmpty ||
                  p.title.toLowerCase().contains(q) ||
                  p.desc.toLowerCase().contains(q);
              return okFilter && okQ;
            }).toList();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: cols == 1 ? 1.0 : 1.45,
              ),
              itemBuilder: (_, i) {
                final from = i % 2 == 0 ? InFrom.left : InFrom.right;

                return _StaggerIn(
                  controller: _c,
                  index: i,
                  from: from,
                  child: _ProjectCard(p: items[i]),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _filterChip(String t) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        setState(() => filter = t);
        _replay();
      },
      child: UiChip(
        t,
        selected: filter == t,
        color: AppColors.primary,
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final _Project p;
  const _ProjectCard({required this.p});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;

        final imgH = (w < 420)
            ? w * 0.58 // small mobile
            : (w < 700)
            ? w * 0.48 // mobile/tablet
            : w * 0.40; // desktop

        final height = imgH.clamp(150.0, 240.0);

        return UiCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(p.title, style: AppText.h3)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: p.statusColor.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      p.status,
                      style: AppText.caption.copyWith(
                        color: p.statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                p.desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppText.body2.copyWith(color: AppColors.text3),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [for (final t in p.tags) UiChip(t)],
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(color: AppColors.stroke.withOpacity(0.6)),
                  ),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Image.asset(
                    p.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Project {
  final String title;
  final String status;
  final Color statusColor;
  final String desc;
  final String imageAsset;
  final List<String> tags;
  final int stars;
  final int forks;
  final String updated;

  const _Project({
    required this.title,
    required this.status,
    required this.statusColor,
    required this.desc,
    required this.imageAsset,
    required this.tags,
    required this.stars,
    required this.forks,
    required this.updated,
  });
}

class _StaggerIn extends StatelessWidget {
  final AnimationController controller;
  final Widget child;
  final int index;
  final InFrom from;

  const _StaggerIn({
    required this.controller,
    required this.child,
    required this.index,
    required this.from,
  });

  Offset _begin() {
    switch (from) {
      case InFrom.left:
        return const Offset(-0.1, 0);
      case InFrom.right:
        return const Offset(0.1, 0);
      case InFrom.top:
        return const Offset(0, -0.1);
      case InFrom.bottom:
        return const Offset(0, 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.08).clamp(0.0, 0.6);
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start.toDouble(), 1.0,
          curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(curve),
      child: SlideTransition(
        position:
        Tween<Offset>(begin: _begin(), end: Offset.zero).animate(curve),
        child: child,
      ),
    );
  }
}