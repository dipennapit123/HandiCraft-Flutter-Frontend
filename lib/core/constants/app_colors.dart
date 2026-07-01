import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────
///  APP COLORS  — Single source of truth
///  RULE: Never hardcode Color(0xFF...) in any screen.
///        Always use AppColors.something
/// ─────────────────────────────────────────────
class AppColors {
  AppColors._(); // ← private constructor: no one can do AppColors()

  // ── Brand / Primary ──────────────────────────
  static const Color primary          = Color(0xFF5C0510);
  // static const Color primaryDark   = Color(0xFF3D30C4);
  // static const Color primaryLight  = Color(0xFF564241);
  // static const Color primarySoft   = Color(0xFFEEF2FF);

  // // ── Secondary / Accent ───────────────────────
  // static const Color secondary     = Color(0xFF00C48C);
  // static const Color secondaryDark       = Color(0xFFFF6B6B);

  // // ── Background ───────────────────────────────
  static const Color background    = Color(0xFFDDC0BE);
  // static const Color surface       = Color(0xFFFFFFFF); // cards, inputs
  // static const Color surfaceDark   = Color(0xFFEFF0F6); // subtle dividers
  // used in: inputbackground, containerbackground etc

  // ── Text ─────────────────────────────────────
  static const Color textPrimary   = Color(0xFF605E58);
  static const Color textSecondary = Color(0xFF564241);
  static const Color textTertiary  = Color(0xff605E58);
  static const Color textHint      = Color(0xFF605E58); // placeholder
// textMain , textBody, textTitle, textSubtitle, textPlaceholder

  // ── Border ───────────────────────────────────
  static const Color border        = Color(0xFFFFF0EF);
  static const Color borderFocus   = Color(0xFF5B4CDB); // same as primary

  // ── Status ───────────────────────────────────
  static const Color error         = Color(0xFFFF4757);
  static const Color success       = Color(0xFF00C48C);
  static const Color warning       = Color(0xFFFFAA00);
  static const Color info          = Color(0xFF1DA1F2);

  // ── Social Button Colors ──────────────────────
  static const Color google        = Color(0xFFDB4437);
  static const Color apple         = Color(0xFF000000);

  // ── Transparent ──────────────────────────────
  static const Color transparent   = Colors.transparent;
  static const Color white         = Colors.white;
  static const Color black         = Colors.black;
  static const Color softBlack= Color(0xff231919);

}


// // ── Splash Gradient ──────────────────────────
// // Used in SplashScreen background
// static const List<Color> splashGradient = [
//   Color(0xFF5B4CDB),
//   Color(0xFF8B5CF6),
// ];


