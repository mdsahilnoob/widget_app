import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../services/home_widget_service.dart';
import 'settings_provider.dart';

class QuickNoteNotifier extends Notifier<String> {
  late SharedPreferences _prefs;

  @override
  String build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return _prefs.getString(AppConstants.prefKeyQuickNote) ?? '';
  }

  Future<void> saveNote(String note) async {
    await _prefs.setString(AppConstants.prefKeyQuickNote, note);
    state = note;

    await HomeWidgetService.pushUpdate(subtitle: note);
  }

  Future<void> clearNote() async {
    await _prefs.remove(AppConstants.prefKeyQuickNote);
    state = '';
    await HomeWidgetService.pushUpdate(subtitle: '');
  }
}

final quickNoteProvider = NotifierProvider<QuickNoteNotifier, String>(
  QuickNoteNotifier.new,
);
