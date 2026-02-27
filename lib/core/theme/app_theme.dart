import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';
import 'app_brand_theme.dart';
import 'app_text_styles.dart';
import 'ios_theme.dart';
import 'oneplus_theme.dart';

/// Builds and dispatches [ThemeData] for the three supported brand themes.
///
/// Nothing OS design principles (default):
///  • Pure black (#000000) backgrounds — no grey-wash.
///  • White as the sole primary accent (no colour bleed).
///  • High-contrast 1 px borders separating every surface.
///  • Monospaced / wide-tracked typography from [AppTextStyles].
///  • Zero corner radius on most surfaces (square, industrial look).
abstract class AppTheme {
  // ── Public entry points ──────────────────────────────────────────────────

  /// Legacy accessor — returns the Nothing OS dark theme.
  static ThemeData get darkTheme => _buildDarkTheme();

  /// Returns the [ThemeData] that matches the currently active [AppBrandTheme].
  /// Use this in [MaterialApp.theme] / [MaterialApp.darkTheme].
  static ThemeData forBrand(AppBrandTheme brand) => switch (brand) {
    AppBrandTheme.nothing => _buildDarkTheme(),
    AppBrandTheme.onePlus => OnePlusTheme.build(),
    AppBrandTheme.iOS => IOSTheme.build(),
  };

  // ── Private builder ───────────────────────────────────────────────────────

  static ThemeData _buildDarkTheme() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      // Backgrounds
      surface: AppConstants.black,
      // Primary
      primary: AppConstants.white,
      onPrimary: AppConstants.black,
      primaryContainer: AppConstants.borderGrey,
      onPrimaryContainer: AppConstants.white,
      // Secondary
      secondary: AppConstants.whiteMuted,
      onSecondary: AppConstants.black,
      secondaryContainer: AppConstants.borderGrey,
      onSecondaryContainer: AppConstants.white,
      // Tertiary
      tertiary: AppConstants.accentRed,
      onTertiary: AppConstants.white,
      tertiaryContainer: AppConstants.borderGrey,
      onTertiaryContainer: AppConstants.white,
      // Error
      error: AppConstants.accentRed,
      onError: AppConstants.white,
      errorContainer: AppConstants.borderGrey,
      onErrorContainer: AppConstants.accentRed,
      // Surfaces
      onSurface: AppConstants.white,
      onSurfaceVariant: AppConstants.whiteMuted,
      surfaceContainerHighest: AppConstants.borderGrey,
      outline: AppConstants.borderGrey,
      outlineVariant: AppConstants.borderGreyLight,
      scrim: AppConstants.black,
      inverseSurface: AppConstants.white,
      onInverseSurface: AppConstants.black,
      inversePrimary: AppConstants.black,
    );

    // Keep system UI bars pitch black with white icons.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppConstants.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppConstants.black,
      fontFamily: AppConstants.fontFamily,

      // ── Text theme ────────────────────────────────────────────────────────
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        titleLarge: AppTextStyles.titleLarge,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // ── AppBar ─────────────────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.black,
        foregroundColor: AppConstants.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        shape: Border(
          bottom: BorderSide(
            color: AppConstants.borderGrey,
            width: AppConstants.borderNormal,
          ),
        ),
      ),

      // ── Card ───────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppConstants.surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          side: const BorderSide(
            color: AppConstants.borderGrey,
            width: AppConstants.borderNormal,
          ),
        ),
      ),

      // ── Divider ────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppConstants.borderGrey,
        thickness: AppConstants.borderNormal,
        space: 0,
      ),

      // ── Icon ───────────────────────────────────────────────────────────────
      iconTheme: const IconThemeData(color: AppConstants.white, size: 24),

      // ── ElevatedButton ────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.white,
          foregroundColor: AppConstants.black,
          elevation: 0,
          textStyle: AppTextStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          ),
        ),
      ),

      // ── OutlinedButton ────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.white,
          side: const BorderSide(
            color: AppConstants.borderGreyLight,
            width: AppConstants.borderNormal,
          ),
          textStyle: AppTextStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          ),
        ),
      ),

      // ── TextButton ────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.white,
          textStyle: AppTextStyles.labelLarge,
        ),
      ),

      // ── InputDecoration ───────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          borderSide: const BorderSide(
            color: AppConstants.borderGrey,
            width: AppConstants.borderNormal,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          borderSide: const BorderSide(
            color: AppConstants.borderGrey,
            width: AppConstants.borderNormal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          borderSide: const BorderSide(
            color: AppConstants.white,
            width: AppConstants.borderThick,
          ),
        ),
        labelStyle: AppTextStyles.bodyMedium,
        hintStyle: AppTextStyles.bodySmall,
      ),

      // ── BottomNavigationBar ───────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppConstants.black,
        selectedItemColor: AppConstants.white,
        unselectedItemColor: AppConstants.whiteSubtle,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // ── NavigationBar (Material 3) ────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppConstants.black,
        indicatorColor: AppConstants.borderGrey,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.labelSmall.copyWith(color: AppConstants.white);
          }
          return AppTextStyles.labelSmall;
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppConstants.white);
          }
          return const IconThemeData(color: AppConstants.whiteSubtle);
        }),
      ),

      // ── ListTile ──────────────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: AppConstants.white,
        textColor: AppConstants.white,
        contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.spaceMD),
      ),

      // ── Switch ────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppConstants.black;
          }
          return AppConstants.whiteSubtle;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppConstants.white;
          }
          return AppConstants.borderGrey;
        }),
      ),

      // ── SnackBar ──────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppConstants.surfaceDark,
        contentTextStyle: AppTextStyles.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          side: const BorderSide(color: AppConstants.borderGrey),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
