import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class UiCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  const UiCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.stroke),
      ),
      child: child,
    );
  }
}

class UiCardHover extends StatelessWidget {
  final Widget child;
  const UiCardHover({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 0,
            offset: Offset(0, 8),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: UiCard(child: child),
    );
  }
}