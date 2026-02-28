import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class UiChip extends StatelessWidget {
  final String text;
  final Color? color;
  final bool selected;
  const UiChip(this.text, {super.key, this.color, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? c.withOpacity(0.18) : AppColors.accent.withOpacity(0.35),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: selected ? c.withOpacity(0.55) : AppColors.stroke),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: selected ? c : AppColors.text2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}