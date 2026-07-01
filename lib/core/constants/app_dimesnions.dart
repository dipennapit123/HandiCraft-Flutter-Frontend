/// ─────────────────────────────────────────────
///  APP DIMENSIONS — Spacing & Size system
///  RULE: Never write magic numbers like SizedBox(height: 16).
///        Use AppDimensions.md instead.
///
///  SPACING SCALE (8pt grid system):
///   xs   =  4   — tight gaps (icon ↔ text)
///   sm   =  8   — small internal padding
///   md   = 16   — standard spacing (most common)
///   lg   = 24   — section spacing
///   xl   = 32   — large breathing room
///   xxl  = 48   — hero/splash big gaps
///   xxxl = 64   — page-level large gaps
///
///  WHY 8PT GRID?
///   Almost all screens divide evenly by 8px.
///   Consistent multiples of 8 makes layouts feel
///   professional and rhythmic automatically.
/// ─────────────────────────────────────────────
class AppDimensions {
  AppDimensions._();

  // ── Spacing (8pt grid) ───────────────────────
  static const double xs   = 4.0;
  static const double sm   = 8.0;
  static const double md   = 16.0;
  static const double lg   = 24.0;
  static const double xl   = 32.0;
  static const double xxl  = 48.0;
  static const double xxxl = 64.0;

  // ── Border Radius ────────────────────────────
  static const double radiusXs   = 4.0;   // tags, chips
  static const double radiusSm   = 8.0;   // small cards
  static const double radiusMd   = 12.0;  // inputs, buttons
  static const double radiusLg   = 16.0;  // cards, sheets
  static const double radiusXl   = 24.0;  // modals
  static const double radiusFull = 100.0; // pills, round buttons

  // ── Icon Sizes ───────────────────────────────
  static const double iconSm  = 16.0;
  static const double iconMd  = 20.0;
  static const double iconLg  = 24.0;
  static const double iconXl  = 32.0;

  // ── Screen Padding ───────────────────────────
  /// Standard horizontal padding for all screens
  static const double screenPaddingH = 24.0;
  /// Standard vertical padding for all screens
  static const double screenPaddingV = 20.0;


  // ── Component Heights ────────────────────────
  static const double buttonHeightLg = 56.0; // primary CTA
  static const double buttonHeightMd = 48.0; // secondary buttons
  static const double buttonHeightSm = 36.0; // small/inline buttons
  static const double inputHeight    = 56.0; // text fields
  static const double appBarHeight   = 60.0;
}
