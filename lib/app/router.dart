import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/app_shell.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/about/presentation/pages/about_page.dart';
import '../features/projects/presentation/pages/projects_page.dart';
import '../features/work_status/presentation/pages/work_status_page.dart';
import '../features/tasks/presentation/pages/tasks_page.dart';
import '../features/notes/presentation/pages/notes_page.dart';
import '../features/contact/presentation/pages/contact_page.dart';
import '../features/components/presentation/pages/components_page.dart';

enum AppRoute { home, about, projects, workStatus, tasks, notes, contact, components }

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomePage()),
          GoRoute(path: '/about', builder: (_, __) => const AboutPage()),
          GoRoute(path: '/projects', builder: (_, __) => const ProjectsPage()),
          GoRoute(path: '/work-status', builder: (_, __) => const WorkStatusPage()),
          GoRoute(path: '/tasks', builder: (_, __) => const TasksPage()),
          GoRoute(path: '/notes', builder: (_, __) => const NotesPage()),
          GoRoute(path: '/contact', builder: (_, __) => const ContactPage()),
          GoRoute(path: '/components', builder: (_, __) => const ComponentsPage()),
        ],
      ),
    ],
  );
}