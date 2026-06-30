import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ─────────────────────────────────────────────
///  APP TEXT STYLES — Typography system
///  RULE: Never write TextStyle(...) inline in any screen.
///        Always use AppTextStyles.something
///
///  SCALE:
///   displayLarge  → 32px  Bold    — App name / Hero titles
///   heading1      → 26px  Bold    — Screen titles
///   heading2      → 20px  SemiBold— Section titles
///   heading3      → 17px  SemiBold— Card titles
///   bodyLarge     → 16px  Regular — Main body text
///   bodyMedium    → 14px  Regular — Secondary body
///   bodySmall     → 12px  Regular — Captions, metadata
///   labelLarge    → 15px  SemiBold— Button labels
///   labelMedium   → 13px  Medium  — Input labels, tags
///   labelSmall    → 11px  Medium  — Badges, timestamps
/// ─────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  // ── Display ──────────────────────────────────
  /// 32px Bold — Use for the app name on splash screen
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    letterSpacing: -1.0,
    height: 1.2,
  );

  // ── Headings ─────────────────────────────────
  /// 26px Bold — Screen main titles ("Welcome back")
  static const TextStyle heading1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.3,
  );

  /// 20px SemiBold — Section titles, modal headers
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.4,
  );

  /// 17px SemiBold — Card titles, list item titles
  static const TextStyle heading3 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ── Body ─────────────────────────────────────
  /// 16px Regular — Primary reading text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  /// 14px Regular — Secondary text, descriptions
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  /// 12px Regular — Captions, metadata, timestamps
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.5,
  );

  // ── Labels ───────────────────────────────────
  /// 15px SemiBold — Button text
  static const TextStyle labelLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.3,
  );

  /// 13px Medium — Input field labels ("Email", "Password")
  static const TextStyle labelMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  /// 11px Medium — Badge text, tiny chips
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );

  // ── Special Purpose ──────────────────────────
  /// For clickable text links ("Forgot password?", "Sign up")
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  /// For error messages under input fields
  static const TextStyle errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
    height: 1.4,
  );
}
