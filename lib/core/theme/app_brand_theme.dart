import 'package:flutter/material.dart';

enum AppBrandTheme {
  nothing,
  onePlus,
  iOS;

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

  Color get accentColor => switch (this) {
    AppBrandTheme.nothing => const Color(0xFFFFFFFF),
    AppBrandTheme.onePlus => const Color(0xFFFF3131),
    AppBrandTheme.iOS => const Color(0xFF007AFF),
  };

  Color get previewBackground => switch (this) {
    AppBrandTheme.nothing => const Color(0xFF000000),
    AppBrandTheme.onePlus => const Color(0xFF090909),
    AppBrandTheme.iOS => const Color(0xFFF2F2F7),
  };

  Color get previewForeground => switch (this) {
    AppBrandTheme.nothing => const Color(0xFFFFFFFF),
    AppBrandTheme.onePlus => const Color(0xFFFFFFFF),
    AppBrandTheme.iOS => const Color(0xFF000000),
  };
}
