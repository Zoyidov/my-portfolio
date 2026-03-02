import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';
import '../../domain/entities/home_overview.dart';

class HeroHeader extends StatelessWidget {
  final HomeOverview data;
  const HeroHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.all(22),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0B1D29).withOpacity(0.9),
                  const Color(0xFF101A25).withOpacity(0.9),
                  AppColors.purple.withOpacity(0.12),
                ],
              ),
            ),
            child: isMobile
                ? _MobileLayout(data: data)
                : _DesktopLayout(data: data),
          );
        },
      ),
    );
  }
}




class _DesktopLayout extends StatelessWidget {
  final HomeOverview data;
  const _DesktopLayout({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _HeaderContent(data: data)),
        const SizedBox(width: 16),
        const _Avatar(),
      ],
    );
  }
}



class _MobileLayout extends StatelessWidget {
  final HomeOverview data;
  const _MobileLayout({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeaderContent(data: data),
        const SizedBox(height: 18),
        const Align(
          alignment: Alignment.centerRight,
          child: _Avatar(),
        ),
      ],
    );
  }
}


class _HeaderContent extends StatelessWidget {
  final HomeOverview data;
  const _HeaderContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${data.lastName}  ",
                    style: AppText.h1.copyWith(
                      color: AppColors.text,
                    ),
                  ),
                  TextSpan(
                    text: data.name,
                    style: AppText.h1.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            data.title,
            style: AppText.body.copyWith(color: AppColors.text2),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              _InfoItem(
                icon: Icons.location_on_outlined,
                text: data.location,
              ),
              _InfoItem(
                icon: Icons.schedule,
                text: data.timezone,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(color: AppColors.text3),
          ),
        ),
      ],
    );
  }
}



class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.purple, AppColors.purple],
        ),
        border: Border.all(
          color: AppColors.purple.withOpacity(0.35),
          width: 1,
        ),
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
    );
  }
}