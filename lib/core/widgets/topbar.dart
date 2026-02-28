import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.stroke)),
      ),
      child: Row(
        children: [
          Text(' ', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppColors.text2)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: AppColors.text2)),
        ],
      ),
    );
  }
}