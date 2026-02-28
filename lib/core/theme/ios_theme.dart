import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_brand_theme.dart';
import 'theme_fonts.dart';

abstract class IOSTheme {
  static const _blue = Color(0xFF007AFF);
  static const _bg = Color(0xFFF2F2F7);
  static const _surface = Color(0xFFFFFFFF);
  static const _border = Color(0xFFC6C6C8);
  static const _borderLight = Color(0xFFE5E5EA);
  static const _label = Color(0xFF000000);
  static const _labelSecondary = Color(0xFF6C6C70);
  static const _labelTertiary = Color(0xFF8E8E93);
  static const _red = Color(0xFFFF3B30);
  static const _green = Color(0xFF30D158);

  static ThemeData build() {
    const cs = ColorScheme(
      brightness: Brightness.light,
      surface: _surface,
      primary: _blue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFD1E8FF),
      onPrimaryContainer: Color(0xFF003D80),
      secondary: _labelSecondary,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE8E8ED),
      onSecondaryContainer: _labelSecondary,
      tertiary: _green,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFDCF5E3),
      onTertiaryContainer: Color(0xFF003311),
      error: _red,
      onError: Colors.white,
      errorContainer: Color(0xFFFFDDD9),
      onErrorContainer: _red,
      onSurface: _label,
      onSurfaceVariant: _labelTertiary,
      surfaceContainerHighest: _border,
      outline: _border,
      outlineVariant: _borderLight,
      scrim: Color(0x66000000),
      inverseSurface: Color(0xFF1C1C1E),
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFF82B4FF),
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: _bg,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    const baseText = TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: _label,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: _label,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: _label,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _label,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _label,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _label,
        letterSpacing: 0.3,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _label,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _label,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _labelTertiary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _label,
        letterSpacing: 0.2,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: _labelTertiary,
        letterSpacing: 0.4,
      ),
    );

    final textTheme = ThemeFonts.resolve(AppBrandTheme.iOS, baseText);

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: _bg,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: _bg,
        foregroundColor: _label,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        surfaceTintColor: Colors.transparent,
        shadowColor: _border,
        titleTextStyle: textTheme.titleLarge,
      ),

      cardTheme: CardThemeData(
        color: _surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: _border, width: 0.5),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: _border,
        thickness: 0.5,
        space: 0,
      ),

      iconTheme: const IconThemeData(color: _blue, size: 24),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _blue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _blue,
          side: const BorderSide(color: _blue),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _blue,
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _border, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _border, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _blue, width: 1.5),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodySmall,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _surface.withAlpha(230),
        indicatorColor: _blue.withAlpha(30),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(color: _blue);
          }
          return textTheme.labelSmall?.copyWith(color: _labelTertiary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: _blue);
          }
          return const IconThemeData(color: _labelTertiary);
        }),
      ),

      listTileTheme: const ListTileThemeData(
        tileColor: _surface,
        iconColor: _blue,
        textColor: _label,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? _blue : _border,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: _surface,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: _border, width: 0.5),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
