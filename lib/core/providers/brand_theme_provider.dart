import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/settings_provider.dart';
import '../theme/app_brand_theme.dart';

// ── Brand-theme notifier ──────────────────────────────────────────────────────

/// Persists and broadcasts the active [AppBrandTheme].
///
/// State is stored in [SharedPreferences] under [AppConstants.prefKeyBrandTheme]
/// so the user's choice survives app restarts.
class BrandThemeNotifier extends Notifier<AppBrandTheme> {
  @override
  AppBrandTheme build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final raw = prefs.getString(AppConstants.prefKeyBrandTheme) ?? 'nothing';
    return AppBrandTheme.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => AppBrandTheme.nothing,
    );
  }

  /// Persists [brand] and notifies all listeners immediately.
  Future<void> setTheme(AppBrandTheme brand) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(AppConstants.prefKeyBrandTheme, brand.name);
    state = brand;
  }
}

/// The single global provider for the active brand theme.
///
/// Usage:
/// ```dart
/// final brand = ref.watch(brandThemeProvider);
/// final themeData = AppTheme.forBrand(brand);
/// ```
final brandThemeProvider = NotifierProvider<BrandThemeNotifier, AppBrandTheme>(
  BrandThemeNotifier.new,
);
