import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_brand_theme.dart';
import 'theme_fonts.dart';

abstract class OnePlusTheme {
  static const _red = Color(0xFFFF3131);
  static const _bg = Color(0xFF090909);
  static const _surface = Color(0xFF141414);
  static const _border = Color(0xFF2A2A2A);
  static const _borderLight = Color(0xFF3A3A3A);
  static const _white = Color(0xFFFFFFFF);
  static const _muted = Color(0xFFAAAAAA);
  static const _subtle = Color(0xFF555555);

  static ThemeData build() {
    const cs = ColorScheme(
      brightness: Brightness.dark,
      surface: _bg,
      primary: _red,
      onPrimary: _white,
      primaryContainer: _border,
      onPrimaryContainer: _white,
      secondary: _muted,
      onSecondary: _bg,
      secondaryContainer: _border,
      onSecondaryContainer: _white,
      tertiary: _red,
      onTertiary: _white,
      tertiaryContainer: _border,
      onTertiaryContainer: _white,
      error: _red,
      onError: _white,
      errorContainer: _border,
      onErrorContainer: _red,
      onSurface: _white,
      onSurfaceVariant: _muted,
      surfaceContainerHighest: _border,
      outline: _border,
      outlineVariant: _borderLight,
      scrim: _bg,
      inverseSurface: _white,
      onInverseSurface: _bg,
      inversePrimary: _bg,
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: _bg,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    const baseText = TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: _white,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: _white,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _white,
        letterSpacing: 0.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _white,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _white,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _muted,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _white,
        letterSpacing: 0.2,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: _muted,
        letterSpacing: 0.5,
      ),
    );

    final textTheme = ThemeFonts.resolve(AppBrandTheme.onePlus, baseText);

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: _bg,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: _bg,
        foregroundColor: _white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        shape: const Border(bottom: BorderSide(color: _border, width: 1)),
      ),

      cardTheme: CardThemeData(
        color: _surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: _border),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: _border,
        thickness: 1,
        space: 0,
      ),

      iconTheme: const IconThemeData(color: _white, size: 24),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _red,
          foregroundColor: _white,
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
          foregroundColor: _red,
          side: const BorderSide(color: _border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _red,
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _red, width: 1.5),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodySmall,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _bg,
        indicatorColor: _border,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(color: _red);
          }
          return textTheme.labelSmall?.copyWith(color: _subtle);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: _red);
          }
          return const IconThemeData(color: _subtle);
        }),
      ),

      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: _red,
        textColor: _white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? _bg : _muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? _red : _border,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: _surface,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: _border),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
