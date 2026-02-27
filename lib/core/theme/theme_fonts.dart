import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_brand_theme.dart';

/// Resolves the correct [TextTheme] for each [AppBrandTheme].
///
/// - [AppBrandTheme.nothing] → returns [base] unchanged (uses the bundled
///   NothingFont / RobotoMono fallback declared in pubspec.yaml).
/// - [AppBrandTheme.onePlus] → [GoogleFonts.outfit] — clean, geometric
///   sans-serif close to OnePlus's own type choices.
/// - [AppBrandTheme.iOS]     → [GoogleFonts.inter] — the nearest freely-
///   available match for Apple's San Francisco / SF Pro.
///
/// Google Fonts downloads the TTF on first use and caches it in the app's
/// document directory, so subsequent app launches are fully offline.
abstract class ThemeFonts {
  /// Returns a copy of [base] with every defined style's font overridden
  /// to match the supplied [brand].
  static TextTheme resolve(AppBrandTheme brand, TextTheme base) =>
      switch (brand) {
        AppBrandTheme.nothing => base,
        AppBrandTheme.onePlus => GoogleFonts.outfitTextTheme(base),
        AppBrandTheme.iOS => GoogleFonts.interTextTheme(base),
      };
}
