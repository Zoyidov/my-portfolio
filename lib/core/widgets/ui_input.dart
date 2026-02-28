import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class UiSearchInput extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  const UiSearchInput({super.key, required this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.text3),
        prefixIcon: const Icon(Icons.search, color: AppColors.text3),
        filled: true,
        fillColor: AppColors.card2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.7)),
        ),
      ),
    );
  }
}