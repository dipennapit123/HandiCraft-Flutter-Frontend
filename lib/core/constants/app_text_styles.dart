import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/core/constants/app_colors.dart';

/// ─────────────────────────────────────────────
///  APP TEXT STYLES — Typography system
///  RULE: Never write TextStyle(...) inline in any screen.
///        Always use AppTextStyles.something

class AppTextStyles {
  AppTextStyles._();

  // ── Display ──────────────────────────────────
  /// 48px Bold — Use for the app name on  screen
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    letterSpacing: -1.2,
    height: 1.2,
  );

  // ── Headings ─────────────────────────────────
  /// 40px Bold — Screen main titles ("Welcome back")
  static const TextStyle heading1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  /// 32px SemiBold — Section titles, modal headers
  static const TextStyle heading2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    letterSpacing: 0,
  );

  /// 30px Regular — Card titles, list item titles
  static const TextStyle heading3 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: -0.75,
  );

  // ── Body ─────────────────────────────────────
  /// 16px Regular — Main Content
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 14px Regular — Secondary Content or  text, descriptions
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    // height: 1.6,
  );

  /// 12px Regular — Captions, metadata or others
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // ── Labels ───────────────────────────────────
  // label" refers to a property or a concept used across various widgets to display text,
  // describe input fields, or provide descriptive metadata for accessibility features.

  /// 24Px SemiBold — CategoryName text
  static const TextStyle labelExtraLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  /// 14px SemiBold — Button text
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.7,
  );

  /// 14px Medium — Input field labels ("Email", "Password")
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.7,
  );

  /// 11px Medium — Badge text, tiny chips and others
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );

  // ── Special Purpose ──────────────────────────
  /// For clickable text links ("Forgot password?", "Sign up")
  static const TextStyle link = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    // decoration: TextDecoration.none,
  );

  /// For error messages under input fields
  static const TextStyle errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
    // height: 1.4,
  );
}
