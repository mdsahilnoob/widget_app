import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String appName = 'Widget App';
  static const String appVersion = '1.0.0';

  static const Color black = Color(0xFF000000);

  static const Color surfaceDark = Color(0xFF0D0D0D);

  static const Color borderGrey = Color(0xFF1F1F1F);

  static const Color borderGreyLight = Color(0xFF2C2C2C);

  static const Color white = Color(0xFFFFFFFF);

  static const Color whiteMuted = Color(0xFFB3B3B3);

  static const Color whiteSubtle = Color(0xFF666666);

  static const Color accentRed = Color(0xFFFF3B30);

  static const String fontFamily = 'NothingFont';

  static const String fontFamilyFallback = 'RobotoMono';

  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  static const double radiusNone = 0.0;
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;

  static const double borderThin = 0.5;
  static const double borderNormal = 1.0;
  static const double borderThick = 1.5;

  static const String prefKeyThemeMode = 'theme_mode';
  static const String prefKeyOnboardingDone = 'onboarding_done';
  static const String prefKeyWidgetLayout = 'widget_layout';

  static const String prefKeyBrandTheme = 'brand_theme';

  static const String prefKeyBatteryLevel = 'battery_level';

  static const String prefKeyBatteryCharging = 'battery_charging';

  static const String prefKeyQuickNote = 'quick_note';

  static const String widgetKeyTitle = 'widget_title';

  static const String widgetKeySubtitle = 'widget_subtitle';

  static const String widgetKeyCounter = 'widget_counter';

  static const String androidWidgetName = 'NothingWidgetProvider';

  static const String iosWidgetName = 'NothingWidget';

  static const String widgetUriHostTap = 'tap_widget';
  static const String widgetUriHostIncrement = 'increment_counter';
}
