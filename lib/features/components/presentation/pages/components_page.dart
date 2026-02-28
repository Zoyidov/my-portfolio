import 'package:flutter/material.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../../../core/widgets/ui_chip.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.pagePadding(context),
      child: ListView(
        children: [
          const Text('Component Library', style: AppText.h2),
          const SizedBox(height: 6),
          Text('Complete UI component system with Flutter Web-inspired design',
              style: AppText.body.copyWith(color: AppColors.text3)),
          const SizedBox(height: 16),

          Row(
            children: const [
              UiChip('Buttons', selected: true, color: AppColors.primary),
              SizedBox(width: 8),
              UiChip('Inputs'),
              SizedBox(width: 8),
              UiChip('Cards'),
              SizedBox(width: 8),
              UiChip('Badges'),
              SizedBox(width: 8),
              UiChip('Feedback'),
            ],
          ),
          const SizedBox(height: 16),

          UiCard(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Buttons', style: AppText.h3),
              const SizedBox(height: 14),
              Text('Primary Buttons', style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10, children: [
                FilledButton(onPressed: () {}, child: const Text('Default')),
                FilledButton(onPressed: () {}, child: const Text('Small')),
                FilledButton(onPressed: () {}, child: const Text('Large')),
                FilledButton(onPressed: null, child: const Text('Disabled')),
                FilledButton(onPressed: () {}, child: const Text('Click Me')),
              ]),
              const SizedBox(height: 18),
              Text('Secondary Buttons', style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10, children: [
                OutlinedButton(onPressed: () {}, child: const Text('Secondary')),
                OutlinedButton(onPressed: () {}, child: const Text('Outline')),
                TextButton(onPressed: () {}, child: const Text('Ghost')),
                TextButton(onPressed: () {}, child: const Text('Link')),
              ]),
              const SizedBox(height: 18),
              Text('Icon Buttons', style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10, children: [
                FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('Download')),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete'),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.red),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.star_border)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              ]),
            ]),
          ),

          const SizedBox(height: 16),
          UiCard(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Design Tokens', style: AppText.h3),
              const SizedBox(height: 14),
              Wrap(spacing: 14, runSpacing: 14, children: [
                _token('Primary', AppColors.primary, '#00D9FF'),
                _token('Purple', AppColors.purple, '#7B8BFA'),
                _token('Green', AppColors.green, '#34D399'),
                _token('Orange', AppColors.orange, '#F9923C'),
                _token('Red', AppColors.red, '#FF4D6A'),
                _token('Background', AppColors.bg, '#0B0F14'),
                _token('Card', AppColors.card, '#0E141B'),
                _token('Accent', AppColors.accent, '#1E2936'),
              ]),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _token(String name, Color c, String hex) {
    return SizedBox(
      width: 180,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.stroke),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
        Text(hex, style: AppText.caption.copyWith(color: AppColors.text3)),
      ]),
    );
  }
}