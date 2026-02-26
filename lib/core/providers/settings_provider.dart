import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

// ── SharedPreferences singleton provider ─────────────────────────────────────

/// Provides an async-initialised [SharedPreferences] instance.
/// Override this in tests with [ProviderContainer(overrides: [...])].
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden before use. '
    'Call SharedPreferences.getInstance() in main() and pass the result '
    'via ProviderScope(overrides: [...]).',
  );
});

// ── Settings state ────────────────────────────────────────────────────────────

/// Immutable snapshot of all user-facing settings.
class AppSettings {
  const AppSettings({
    this.isDarkMode = true,
    this.isOnboardingDone = false,
    this.widgetLayout = WidgetLayout.grid,
  });

  final bool isDarkMode;
  final bool isOnboardingDone;
  final WidgetLayout widgetLayout;

  AppSettings copyWith({
    bool? isDarkMode,
    bool? isOnboardingDone,
    WidgetLayout? widgetLayout,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isOnboardingDone: isOnboardingDone ?? this.isOnboardingDone,
      widgetLayout: widgetLayout ?? this.widgetLayout,
    );
  }

  @override
  String toString() =>
      'AppSettings(isDarkMode: $isDarkMode, '
      'isOnboardingDone: $isOnboardingDone, '
      'widgetLayout: $widgetLayout)';
}

enum WidgetLayout { grid, list }

// ── Settings notifier ────────────────────────────────────────────────────────

class SettingsNotifier extends Notifier<AppSettings> {
  late SharedPreferences _prefs;

  @override
  AppSettings build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return _loadFromPrefs();
  }

  // ── Load ──────────────────────────────────────────────────────────────────

  AppSettings _loadFromPrefs() {
    final isDark = _prefs.getBool(AppConstants.prefKeyThemeMode) ?? true;
    final onboardingDone =
        _prefs.getBool(AppConstants.prefKeyOnboardingDone) ?? false;
    final layoutIndex = _prefs.getInt(AppConstants.prefKeyWidgetLayout) ?? 0;

    return AppSettings(
      isDarkMode: isDark,
      isOnboardingDone: onboardingDone,
      widgetLayout: WidgetLayout.values[layoutIndex],
    );
  }

  // ── Mutations ─────────────────────────────────────────────────────────────

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(AppConstants.prefKeyThemeMode, value);
    state = state.copyWith(isDarkMode: value);
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(AppConstants.prefKeyOnboardingDone, true);
    state = state.copyWith(isOnboardingDone: true);
  }

  Future<void> setWidgetLayout(WidgetLayout layout) async {
    await _prefs.setInt(AppConstants.prefKeyWidgetLayout, layout.index);
    state = state.copyWith(widgetLayout: layout);
  }

  Future<void> resetAll() async {
    await _prefs.remove(AppConstants.prefKeyThemeMode);
    await _prefs.remove(AppConstants.prefKeyOnboardingDone);
    await _prefs.remove(AppConstants.prefKeyWidgetLayout);
    state = const AppSettings();
  }
}

/// The single global provider for all app settings.
final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);
