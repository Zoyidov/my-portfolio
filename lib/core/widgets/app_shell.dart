import 'package:flutter/material.dart';
import '../../app/responsive/responsive.dart';
import 'sidebar.dart';
import 'topbar.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Scaffold(
        drawer: const Drawer(child: Sidebar(isDrawer: true)),
        appBar: AppBar(
          title: const Text('Dasturchi haqqida ma\'lumot'),
          actions: const [SizedBox(width: 8)],
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        body: child,
      );
    }

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(isDrawer: false),
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}