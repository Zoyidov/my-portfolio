import 'package:flutter/widgets.dart';

class AdaptiveGrid {
  static int columns(double width, {int min = 1, int max = 4}) {
    if (width >= 1400) return max.clamp(min, max);
    if (width >= 1100) return 3.clamp(min, max);
    if (width >= 760) return 2.clamp(min, max);
    return 1;
  }
}