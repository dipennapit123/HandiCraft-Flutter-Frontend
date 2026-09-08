import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';

class AppTextStyles {
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Playfair Display',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSecondaryContainer,
    letterSpacing: 0.05,
  );
}
