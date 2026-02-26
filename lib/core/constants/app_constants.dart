import 'package:flutter/material.dart';

/// App-wide constants for the Nothing OS inspired widget app.
abstract class AppConstants {
  // ── App Info ─────────────────────────────────────────────────────────────
  static const String appName = 'Widget App';
  static const String appVersion = '1.0.0';

  // ── Colors ────────────────────────────────────────────────────────────────
  /// Pure black — the primary background, matching Nothing OS dark mode.
  static const Color black = Color(0xFF000000);

  /// Off-black for elevated surfaces (cards, bottom sheets).
  static const Color surfaceDark = Color(0xFF0D0D0D);

  /// The border / divider grey used heavily on Nothing OS.
  static const Color borderGrey = Color(0xFF1F1F1F);

  /// Secondary border, slightly lighter.
  static const Color borderGreyLight = Color(0xFF2C2C2C);

  /// Pure white — primary accent / text.
  static const Color white = Color(0xFFFFFFFF);

  /// Muted white for secondary text.
  static const Color whiteMuted = Color(0xFFB3B3B3);

  /// Subtle white for disabled / hint text.
  static const Color whiteSubtle = Color(0xFF666666);

  /// Nothing's signature red dot accent.
  static const Color accentRed = Color(0xFFFF3B30);

  // ── Typography ───────────────────────────────────────────────────────────
  /// Placeholder font family — replace .ttf assets to activate.
  static const String fontFamily = 'NothingFont';

  /// Fallback system font used until real font assets are added.
  static const String fontFamilyFallback = 'RobotoMono';

  // ── Spacing ───────────────────────────────────────────────────────────────
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  // ── Border Radius ─────────────────────────────────────────────────────────
  static const double radiusNone = 0.0;
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;

  // ── Border Width ──────────────────────────────────────────────────────────
  static const double borderThin = 0.5;
  static const double borderNormal = 1.0;
  static const double borderThick = 1.5;

  // ── SharedPreferences Keys ────────────────────────────────────────────────
  static const String prefKeyThemeMode = 'theme_mode';
  static const String prefKeyOnboardingDone = 'onboarding_done';
  static const String prefKeyWidgetLayout = 'widget_layout';
}
