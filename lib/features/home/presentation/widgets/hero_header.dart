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
      child: Container(
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
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppText.h1.copyWith(color: AppColors.text),
                        children: [
                          const TextSpan(text: "Zoyidov  "),
                          TextSpan(text: data.name, style: AppText.h1.copyWith(color: AppColors.primary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(data.title, style: AppText.body.copyWith(color: AppColors.text2)),
                    const SizedBox(height: 12),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 14,
                      runSpacing: 6,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primary),
                            const SizedBox(width: 6),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 220), // kerak bo‘lsa mosla
                              child: Text(
                                data.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.caption.copyWith(color: AppColors.text3),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.schedule, size: 16, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              data.timezone,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.caption.copyWith(color: AppColors.text3),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(14),
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
            ),
          ],
        ),
      ),
    );
  }
}