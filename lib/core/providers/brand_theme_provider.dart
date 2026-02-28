import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/settings_provider.dart';
import '../theme/app_brand_theme.dart';

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

  Future<void> setTheme(AppBrandTheme brand) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(AppConstants.prefKeyBrandTheme, brand.name);
    state = brand;
  }
}

final brandThemeProvider = NotifierProvider<BrandThemeNotifier, AppBrandTheme>(
  BrandThemeNotifier.new,
);
