import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Central text-style definitions for the Nothing OS aesthetic.
///
/// Nothing OS uses a monospaced / dotmatrix feel with extreme letter-spacing
/// and very explicit weight contrast. We replicate this with [RobotoMono]
/// as a fallback until the real [NothingFont] TTF assets land in
/// assets/fonts/.
abstract class AppTextStyles {
  static const _fontFamilyFallback = [AppConstants.fontFamilyFallback];

  // ── Display ──────────────────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    color: AppConstants.white,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppConstants.white,
    height: 1.15,
  );

  // ── Headline ─────────────────────────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppConstants.white,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    color: AppConstants.white,
  );

  // ── Title ─────────────────────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    color: AppConstants.white,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    color: AppConstants.white,
  );

  // ── Body ──────────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppConstants.white,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppConstants.whiteMuted,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppConstants.whiteSubtle,
  );

  // ── Label ─────────────────────────────────────────────────────────────────
  /// Used for tags, chips, badges — uppercase tracking is key.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.5,
    color: AppConstants.white,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: AppConstants.whiteSubtle,
  );
}
