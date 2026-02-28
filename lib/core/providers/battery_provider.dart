import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'settings_provider.dart';

class BatteryState {
  const BatteryState({this.level = 72, this.isCharging = false});

  final int level;
  final bool isCharging;

  BatteryState copyWith({int? level, bool? isCharging}) => BatteryState(
    level: level ?? this.level,
    isCharging: isCharging ?? this.isCharging,
  );
}

class BatteryNotifier extends Notifier<BatteryState> {
  late SharedPreferences _prefs;

  @override
  BatteryState build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return BatteryState(
      level: _prefs.getInt(AppConstants.prefKeyBatteryLevel) ?? 72,
      isCharging: _prefs.getBool(AppConstants.prefKeyBatteryCharging) ?? false,
    );
  }

  Future<void> setLevel(int level) async {
    final clamped = level.clamp(0, 100);
    await _prefs.setInt(AppConstants.prefKeyBatteryLevel, clamped);
    state = state.copyWith(level: clamped);
  }

  Future<void> setCharging(bool value) async {
    await _prefs.setBool(AppConstants.prefKeyBatteryCharging, value);
    state = state.copyWith(isCharging: value);
  }
}

final batteryProvider = NotifierProvider<BatteryNotifier, BatteryState>(
  BatteryNotifier.new,
);
