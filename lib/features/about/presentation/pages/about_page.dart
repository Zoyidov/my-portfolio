import 'package:flutter/material.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';
import '../../../home/presentation/pages/home_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
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
          StaggerIn(
            controller: _c,
            start: 0.00,
            end: 0.20,
            from: InFrom.top,
            child: const Text('About Me', style: AppText.h2),
          ),
          const SizedBox(height: 6),

          StaggerIn(
            controller: _c,
            start: 0.05,
            end: 0.25,
            from: InFrom.left,
            child: Text(
              'Get to know more about my background, skills, and experience',
              style: AppText.body.copyWith(color: AppColors.text3),
            ),
          ),
          const SizedBox(height: 16),

          StaggerIn(
            controller: _c,
            start: 0.12,
            end: 0.40,
            from: InFrom.right,
            child: _profileCard(),
          ),

          const SizedBox(height: 16),

          LayoutBuilder(builder: (context, c) {
            final twoCol = c.maxWidth >= 1100;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StaggerIn(
                    controller: _c,
                    start: 0.25,
                    end: 0.70,
                    from: InFrom.left,
                    child: _skillsCard(controller: _c),
                  ),
                ),
                if (twoCol) const SizedBox(width: 16),
                if (twoCol)
                  Expanded(
                    child: StaggerIn(
                      controller: _c,
                      start: 0.32,
                      end: 0.78,
                      from: InFrom.right,
                      child: _stackCard(),
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 16),

          StaggerIn(
            controller: _c,
            start: 0.45,
            end: 1.00,
            from: InFrom.bottom,
            child: _workExperience(),
          ),
        ],
      ),
    );
  }

  // ---------------- UI ----------------

  Widget _profileCard() {
    return UiCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/images/me.jpg'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Nurmuxammad', style: AppText.h3),
              const SizedBox(height: 4),
              const Text('Flutter Developer',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text(
                'Passionate Flutter developer with ${calculateExperience()}+ years of experience building high-quality cross-platform applications...',
                style: const TextStyle(color: AppColors.text3),
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                UiChip(
                  '${calculateExperience()}+ Years Experience',
                  selected: true,
                  color: AppColors.primary,
                ),
                const UiChip('10+ Projects Delivered', selected: true, color: AppColors.purple),
                const UiChip('Available for Freelance', selected: true, color: AppColors.green),
              ]),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _skillsCard({required AnimationController controller}) {
    Widget row(String label, int pct,
        {required double start,
          required double end,
          required InFrom from}) {

      final appearCurve = CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );

      final progressAnim = Tween<double>(begin: 0, end: pct / 100).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            start + 0.05,   // biroz kechroq boshlansin
            1.0,            // oxirigacha davom etsin
            curve: Curves.easeOutExpo, // 🔥 sekin boshlanib silliq to‘ladi
          ),
        ),
      );

      return StaggerIn(
        controller: controller,
        start: start,
        end: end,
        from: from,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(label,
                      style: AppText.body.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: progressAnim,
                    builder: (_, __) {
                      final p = (progressAnim.value * 100).round();
                      return Text('$p%',
                          style:
                          AppText.caption.copyWith(color: AppColors.text2));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 6,
                  color: AppColors.accent.withOpacity(0.7),
                  child: AnimatedBuilder(
                    animation: progressAnim,
                    builder: (_, __) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progressAnim.value,
                        child: Container(color: AppColors.purple),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.school_outlined, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          const Text('Core Skills', style: AppText.h3),
        ]),
        const SizedBox(height: 16),

        row('Flutter', 95, start: 0.28, end: 0.48, from: InFrom.left),
        row('Dart', 95, start: 0.32, end: 0.52, from: InFrom.right),
        row('BLoC/Cubit', 90, start: 0.36, end: 0.56, from: InFrom.left),
        row('Firebase', 85, start: 0.40, end: 0.60, from: InFrom.right),
        row('Supabase', 80, start: 0.44, end: 0.64, from: InFrom.left),
        row('REST API', 90, start: 0.48, end: 0.68, from: InFrom.right),
        row('Clean Architecture', 85, start: 0.52, end: 0.72, from: InFrom.left),
        row('GoRouter', 88, start: 0.56, end: 0.76, from: InFrom.right),
      ]),
    );
  }

  Widget _stackCard() {
    const chips = [
      'Flutter','Dart','Firebase','Supabase','BLoC','Cubit','Provider','Riverpod',
      'GetX','Hive','SQLite','REST API','GraphQL','Git','GitHub','Figma','Clean Architecture','SOLID','TDD'
    ];
    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tech Stack', style: AppText.h3),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final c in chips) UiChip(c),
        ]),
      ]),
    );
  }

  Widget _workExperience() {
    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.work_outline, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          const Text('Work Experience', style: AppText.h3),
        ]),
        const SizedBox(height: 16),
        _timeline(
          title: 'Senior Flutter Developer',
          company: 'Tech Solutions Inc.',
          range: '2024 - Present',
          bullets: const [
            'Built 3 production apps with 50k+ downloads',
            'Reduced app load time by 40%',
            'Implemented CI/CD pipeline',
          ],
        ),
        const SizedBox(height: 18),
        _timeline(
          title: 'Flutter Developer',
          company: 'StartUp Hub',
          range: '2023 - 2026',
          bullets: const [
            'Delivered 8+ client projects',
            'Maintained 4.8+ rating on app stores',
            'Integrated payment gateways and third-party APIs',
          ],
        ),
        const SizedBox(height: 18),
        _timeline(
          title: 'Junior Mobile Developer',
          company: 'Digital Agency',
          range: '2021 - 2022',
          bullets: const [
            'Learned Flutter and Dart fundamentals',
            'Contributed to 5 team projects',
          ],
        ),
      ]),
    );
  }

  Widget _timeline({
    required String title,
    required String company,
    required String range,
    required List<String> bullets,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          ),
          Container(width: 2, height: 80, color: AppColors.stroke),
        ]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('$company  •  $range', style: AppText.caption.copyWith(color: AppColors.text3)),
            const SizedBox(height: 8),
            for (final b in bullets)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Text('• ', style: TextStyle(color: AppColors.text3)),
                    Expanded(child: Text(b, style: AppText.body2.copyWith(color: AppColors.text3))),
                  ],
                ),
              ),
          ]),
        ),
      ],
    );
  }

  double calculateExperience() {
    final startDate = DateTime(2023, 3);
    final now = DateTime.now();

    final difference = now.difference(startDate);
    return difference.inDays / 365;
  }
}