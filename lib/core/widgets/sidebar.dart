import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class Sidebar extends StatefulWidget {
  final bool isDrawer;
  const Sidebar({super.key, required this.isDrawer});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    final width = collapsed ? 88.0 : 260.0;

    final content = Container(
      width: widget.isDrawer ? null : width,
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(right: BorderSide(color: AppColors.stroke)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _header(context),
            const SizedBox(height: 10),
            _nav(context),
          ],
        ),
      ),
    );

    return widget.isDrawer ? content : AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: width,
      child: content,
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.purple]),
              border: Border.all(color: AppColors.stroke),
            ),
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.asset(
                'assets/images/me.jpg',
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (!collapsed)
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nurmuxammad', style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(height: 2),
                  Text('Flutter Developer', style: TextStyle(color: AppColors.text3, fontSize: 12)),
                ],
              ),
            ),
          // if (!widget.isDrawer)
          //   IconButton(
          //     onPressed: () => setState(() => collapsed = !collapsed),
          //     icon: Icon(collapsed ? Icons.chevron_right : Icons.chevron_left, color: AppColors.text2),
          //   ),
        ],
      ),
    );
  }

  Widget _nav(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          _item(context, 'Home', Icons.home_outlined, '/home', loc),
          _item(context, 'About', Icons.person_outline, '/about', loc),
          _item(context, 'Projects', Icons.folder_outlined, '/projects', loc),
          _item(context, 'Work Status', Icons.work_outline, '/work-status', loc),
          _item(context, 'Tasks', Icons.checklist_outlined, '/tasks', loc),
          _item(context, 'Notes', Icons.note_outlined, '/notes', loc),
          _item(context, 'Contact', Icons.mail_outline, '/contact', loc),
          const SizedBox(height: 10),
          _item(context, 'Components', Icons.code, '/components', loc),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String label, IconData icon, String path, String loc) {
    final selected = loc.startsWith(path);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (widget.isDrawer) {
            Navigator.of(context).pop(); // ✅ drawer close
          }
          context.go(path);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withOpacity(0.18) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary.withOpacity(0.35) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? AppColors.primary : AppColors.text2, size: 20),
              const SizedBox(width: 10),
              if (!collapsed)
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected ? AppColors.primary : AppColors.text2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}