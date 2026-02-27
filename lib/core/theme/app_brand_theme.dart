import 'package:flutter/material.dart';

/// The three supported brand UI themes.
///
/// Each value maps to a full [ThemeData] built in its own class and a
/// [google_fonts] text-theme resolved in [ThemeFonts].
enum AppBrandTheme {
  nothing,
  onePlus,
  iOS;

  // ── Display metadata ──────────────────────────────────────────────────────

  String get displayName => switch (this) {
    AppBrandTheme.nothing => 'Nothing OS',
    AppBrandTheme.onePlus => 'OnePlus',
    AppBrandTheme.iOS => 'iOS',
  };

  String get description => switch (this) {
    AppBrandTheme.nothing => 'Pure black. Dot-matrix type. Zero noise.',
    AppBrandTheme.onePlus => 'Oxygen OS red accent. Outfit font. Dark & bold.',
    AppBrandTheme.iOS => 'System light mode. Inter font. Frosted glass.',
  };

  /// The brand's signature accent colour — used in the theme picker UI
  /// independently of the active [ThemeData].
  Color get accentColor => switch (this) {
    AppBrandTheme.nothing => const Color(0xFFFFFFFF),
    AppBrandTheme.onePlus => const Color(0xFFFF3131),
    AppBrandTheme.iOS => const Color(0xFF007AFF),
  };

  /// Background tint for the picker card preview tile.
  Color get previewBackground => switch (this) {
    AppBrandTheme.nothing => const Color(0xFF000000),
    AppBrandTheme.onePlus => const Color(0xFF090909),
    AppBrandTheme.iOS => const Color(0xFFF2F2F7),
  };

  /// Foreground (text/icon) colour on the picker card preview tile.
  Color get previewForeground => switch (this) {
    AppBrandTheme.nothing => const Color(0xFFFFFFFF),
    AppBrandTheme.onePlus => const Color(0xFFFFFFFF),
    AppBrandTheme.iOS => const Color(0xFF000000),
  };
}
