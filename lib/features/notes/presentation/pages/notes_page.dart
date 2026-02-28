import 'package:flutter/material.dart';
import '../../../../app/responsive/adaptive_grid.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';
import '../../../../core/widgets/ui_input.dart';

enum InFrom { left, right, top, bottom }

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  String selectedFolder = 'All Notes';
  String q = '';

  final List<_Note> _notes = [
    _Note(
      folder: 'Flutter',
      title: 'Flutter Performance Optimization',
      body:
      'Best practices: minimize rebuilds, use const widgets, avoid expensive layouts, '
          'profile with DevTools, and optimize images.',
      tags: ['performance', 'optimization', 'best-practices'],
      createdAt: DateTime(2026, 2, 28, 9, 10),
    ),
    _Note(
      folder: 'Architecture',
      title: 'Clean Architecture in Flutter',
      body:
      'Implementation guide: Presentation, Domain, Data. Use repositories, use-cases, and DI for testability.',
      tags: ['clean-architecture', 'design-patterns', 'flutter'],
      createdAt: DateTime(2026, 2, 27, 12, 00),
    ),
    _Note(
      folder: 'Flutter',
      title: 'BLoC vs Riverpod Comparison',
      body:
      'BLoC works great for complex flows; Riverpod is ergonomic and powerful. Choose based on team & scale.',
      tags: ['state-management', 'bloc', 'riverpod'],
      createdAt: DateTime(2026, 2, 25, 18, 40),
    ),
    _Note(
      folder: 'Tips & Tricks',
      title: 'Firebase Integration Checklist',
      body:
      'Checklist: setup project, add dependencies, configure platforms, initialize, enable auth, setup messaging, test.',
      tags: ['firebase', 'backend', 'checklist'],
      createdAt: DateTime(2026, 2, 23, 10, 20),
    ),
    _Note(
      folder: 'Learning',
      title: 'Custom Animations in Flutter',
      body:
      'Smooth custom animations using AnimationController, Tween, CurvedAnimation, AnimatedBuilder. Prefer implicit when possible.',
      tags: ['animation', 'ui', 'flutter'],
      createdAt: DateTime(2026, 2, 21, 15, 05),
    ),
    _Note(
      folder: 'Architecture',
      title: 'API Integration Best Practices',
      body:
      'REST best practices: robust error handling, retry logic, timeouts, caching strategies, and clean DTO->Domain mapping.',
      tags: ['api', 'rest', 'networking'],
      createdAt: DateTime(2026, 2, 15, 11, 30),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Only once: page-entry animation
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 950))
      ..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  // ------------ Derived data (auto stats) ------------

  List<String> get _folders {
    final set = <String>{'All Notes'};
    for (final n in _notes) {
      set.add(n.folder);
    }
    return set.toList();
  }

  List<_Note> get _filteredNotes {
    final query = q.trim().toLowerCase();
    return _notes.where((n) {
      final okFolder = selectedFolder == 'All Notes' || n.folder == selectedFolder;
      final okQ = query.isEmpty ||
          n.title.toLowerCase().contains(query) ||
          n.body.toLowerCase().contains(query) ||
          n.tags.any((t) => t.toLowerCase().contains(query)) ||
          n.folder.toLowerCase().contains(query);
      return okFolder && okQ;
    }).toList();
  }

  int _wordCount(String text) {
    final cleaned = text.trim();
    if (cleaned.isEmpty) return 0;
    return cleaned.split(RegExp(r'\s+')).length;
  }

  int get _totalWords => _notes.fold<int>(0, (sum, n) => sum + _wordCount(n.body));

  int get _thisMonthCount {
    final now = DateTime.now();
    return _notes.where((n) => n.createdAt.year == now.year && n.createdAt.month == now.month).length;
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    final weeks = (diff.inDays / 7).floor();
    if (weeks < 5) return '${weeks}w ago';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotes;

    return Padding(
      padding: Responsive.pagePadding(context),
      child: ListView(
        children: [
          _StaggerIn(
            controller: _c,
            start: 0.00,
            end: 0.20,
            from: InFrom.top,
            child: const Text('Notes', style: AppText.h2),
          ),
          const SizedBox(height: 6),

          _StaggerIn(
            controller: _c,
            start: 0.06,
            end: 0.26,
            from: InFrom.left,
            child: Text(
              'Knowledge base & documentation',
              style: AppText.body.copyWith(color: AppColors.text3),
            ),
          ),
          const SizedBox(height: 16),

          LayoutBuilder(builder: (context, c) {
            final twoCol = c.maxWidth >= 1100;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: twoCol ? 320 : c.maxWidth,
                  child: Column(
                    children: [
                      _StaggerIn(
                        controller: _c,
                        start: 0.10,
                        end: 0.40,
                        from: InFrom.left,
                        child: Text(
                          'Organize your notes by folders, quickly find insights with search, and track your writing stats.',
                          style: AppText.body.copyWith(color: AppColors.text3),
                        ),
                      ),
                      const SizedBox(height: 12),

                      _StaggerIn(
                        controller: _c,
                        start: 0.16,
                        end: 0.55,
                        from: InFrom.left,
                        child: _foldersCard(),
                      ),
                      const SizedBox(height: 12),

                      _StaggerIn(
                        controller: _c,
                        start: 0.22,
                        end: 0.65,
                        from: InFrom.left,
                        child: _quickStatsCard(),
                      ),
                    ],
                  ),
                ),
                if (twoCol) const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      _StaggerIn(
                        controller: _c,
                        start: 0.14,
                        end: 0.45,
                        from: InFrom.right,
                        child: UiSearchInput(
                          hint: 'Search notes, tags, or content...',
                          onChanged: (v) => setState(() => q = v),
                          // ✅ NO replay => no full re-animation
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ✅ Only grid changes softly; page doesn't re-animate
                      _notesGrid(filtered),
                    ],
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  // ---------------- Left column cards ----------------

  Widget _foldersCard() {
    final counts = <String, int>{};
    for (final f in _folders) counts[f] = 0;
    counts['All Notes'] = _notes.length;
    for (final n in _notes) {
      counts[n.folder] = (counts[n.folder] ?? 0) + 1;
    }

    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.folder_outlined, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text('Folders', style: AppText.h3),
        ]),
        const SizedBox(height: 12),

        for (final f in _folders)
          _folderItem(
            f,
            counts[f] ?? 0,
            selected: selectedFolder == f,
            onTap: () => setState(() => selectedFolder = f),
            // ✅ NO replay => no full re-animation
          ),
      ]),
    );
  }

  Widget _folderItem(
      String name,
      int count, {
        required bool selected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.18) : AppColors.card2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.primary.withOpacity(0.35) : AppColors.stroke),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: selected ? AppColors.primary : AppColors.text2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.stroke),
              ),
              child: Text('$count', style: AppText.caption.copyWith(color: AppColors.text3)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickStatsCard() {
    final totalNotes = _notes.length;
    final totalWords = _totalWords;
    final thisMonth = _thisMonthCount;

    return UiCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.query_stats, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text('Quick Stats', style: AppText.h3),
        ]),
        const SizedBox(height: 14),

        // ✅ These animate only on first entry (page animation). Not replayed on filter/search.
        _kvAnimated('Total Notes', totalNotes, start: 0.30, end: 0.90),
        _kvAnimated('Total Words', totalWords, start: 0.34, end: 0.95),
        _kvAnimated('This Month', thisMonth, start: 0.38, end: 1.00),
      ]),
    );
  }

  Widget _kvAnimated(String k, int value, {required double start, required double end}) {
    final anim = IntTween(begin: 0, end: value).animate(
      CurvedAnimation(parent: _c, curve: Interval(start, end, curve: Curves.easeOutCubic)),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(k, style: AppText.body2.copyWith(color: AppColors.text3)),
          const Spacer(),
          AnimatedBuilder(
            animation: anim,
            builder: (_, __) => Text(
              '${anim.value}',
              style: AppText.body.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Grid (soft update on filter/search) ----------------

  Widget _notesGrid(List<_Note> notes) {
    return LayoutBuilder(builder: (context, c) {
      final cols = AdaptiveGrid.columns(c.maxWidth, min: 1, max: 2);
      final ratio = cols == 1 ? (c.maxWidth < 420 ? 1.05 : 1.15) : 1.35;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
        child: GridView.builder(
          key: ValueKey('grid_${selectedFolder}_${q}_${notes.length}'),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: ratio,
          ),
          itemBuilder: (_, i) {
            // ✅ No stagger replay here; page already animated once
            return _NoteCard(
              note: notes[i],
              timeText: _timeAgo(notes[i].createdAt),
              wordsText: '${_wordCount(notes[i].body)} words',
            );
          },
        ),
      );
    });
  }
}

class _NoteCard extends StatelessWidget {
  final _Note note;
  final String timeText;
  final String wordsText;

  const _NoteCard({
    required this.note,
    required this.timeText,
    required this.wordsText,
  });

  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const Icon(Icons.description_outlined, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            UiChip(note.folder),
            const Spacer(),
            const Icon(Icons.more_horiz, color: AppColors.text3),
          ],
        ),
        const SizedBox(height: 10),
        Text(note.title, style: AppText.h3),
        const SizedBox(height: 10),
        Text(
          note.body,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: AppText.body2.copyWith(color: AppColors.text3),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [for (final t in note.tags) UiChip(t)]),
        const Spacer(),
        const Divider(height: 22),
        Row(
          children: [
            Icon(Icons.schedule, size: 14, color: AppColors.text3),
            const SizedBox(width: 6),
            Text(timeText, style: AppText.caption.copyWith(color: AppColors.text3)),
            const Spacer(),
            Text(wordsText, style: AppText.caption.copyWith(color: AppColors.text3)),
          ],
        )
      ]),
    );
  }
}

class _Note {
  final String folder;
  final String title;
  final String body;
  final List<String> tags;
  final DateTime createdAt;

  const _Note({
    required this.folder,
    required this.title,
    required this.body,
    required this.tags,
    required this.createdAt,
  });
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