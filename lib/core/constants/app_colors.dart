import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────
///  APP COLORS  — Single source of truth
///  RULE: Never hardcode Color(0xFF...) in any screen.
///        Always use AppColors.something
/// ─────────────────────────────────────────────
class AppColors {
  AppColors._(); // ← private constructor: no one can do AppColors()

  // ── Brand / Primary ──────────────────────────
  static const Color primary       = Color(0xFF5B4CDB); // indigo-purple
  static const Color primaryDark   = Color(0xFF3D30C4); // pressed state
  static const Color primaryLight  = Color(0xFFEDE9FF); // backgrounds, chips

  // ── Secondary / Accent ───────────────────────
  static const Color secondary     = Color(0xFF00C48C); // success green
  static const Color accent        = Color(0xFFFF6B6B); // error/warm accent

  // ── Background ───────────────────────────────
  static const Color background    = Color(0xFFF6F7FB); // main scaffold bg
  static const Color surface       = Color(0xFFFFFFFF); // cards, inputs
  static const Color surfaceDark   = Color(0xFFEFF0F6); // subtle dividers

  // ── Text ─────────────────────────────────────
  static const Color textPrimary   = Color(0xFF1A1D2E); // headlines
  static const Color textSecondary = Color(0xFF6E7191); // subtitles, hints
  static const Color textHint      = Color(0xFFADB5BD); // placeholder

  // ── Border ───────────────────────────────────
  static const Color border        = Color(0xFFE4E6F0);
  static const Color borderFocus   = Color(0xFF5B4CDB); // same as primary

  // ── Status ───────────────────────────────────
  static const Color error         = Color(0xFFFF4757);
  static const Color success       = Color(0xFF00C48C);
  static const Color warning       = Color(0xFFFFAA00);
  static const Color info          = Color(0xFF1DA1F2);

  // ── Splash Gradient ──────────────────────────
  // Used in SplashScreen background
  static const List<Color> splashGradient = [
    Color(0xFF5B4CDB),
    Color(0xFF8B5CF6),
  ];

  // ── Social Button Colors ──────────────────────
  static const Color google        = Color(0xFFDB4437);
  static const Color apple         = Color(0xFF000000);

  // ── Transparent ──────────────────────────────
  static const Color transparent   = Colors.transparent;
  static const Color white         = Colors.white;
  static const Color black         = Colors.black;
}
