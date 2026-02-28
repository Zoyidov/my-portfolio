import 'package:flutter/widgets.dart';
import 'breakpoints.dart';

class Responsive {
  static double w(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isMobile(BuildContext c) => w(c) < Breakpoints.mobile;
  static bool isTablet(BuildContext c) => w(c) >= Breakpoints.mobile && w(c) < Breakpoints.tablet;
  static bool isDesktop(BuildContext c) => w(c) >= Breakpoints.tablet;

  static EdgeInsets pagePadding(BuildContext c) {
    final width = w(c);
    if (width >= Breakpoints.desktop) return const EdgeInsets.all(24);
    if (width >= Breakpoints.tablet) return const EdgeInsets.all(20);
    return const EdgeInsets.all(14);
  }
}