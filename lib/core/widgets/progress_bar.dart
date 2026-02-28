import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class UiProgressBar extends StatelessWidget {
  final double value; // 0..1
  final Color color;
  final double height;
  const UiProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: height,
        color: AppColors.accent.withOpacity(0.55),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            width: (MediaQuery.sizeOf(context).width) * 0.0001, // placeholder, overridden by LayoutBuilder in parent if needed
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(color: color),
            ),
          ),
        ),
      ),
    );
  }
}