import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/home_widget_service.dart';

// ── State model ───────────────────────────────────────────────────────────────

/// Holds the data currently mirrored to the Android home screen widget.
class WidgetData {
  const WidgetData({
    this.title = 'WIDGET APP',
    this.subtitle = 'Nothing OS',
    this.counter = 0,
    this.isSyncing = false,
    this.lastError,
  });

  final String title;
  final String subtitle;
  final int counter;

  /// True while an async write to the platform is in flight.
  final bool isSyncing;

  /// Non-null when the last platform call threw an exception.
  final String? lastError;

  WidgetData copyWith({
    String? title,
    String? subtitle,
    int? counter,
    bool? isSyncing,
    String? lastError,
  }) {
    return WidgetData(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      counter: counter ?? this.counter,
      isSyncing: isSyncing ?? this.isSyncing,
      lastError: lastError, // always overwrite (allows clearing)
    );
  }

  @override
  String toString() =>
      'WidgetData(title: $title, subtitle: $subtitle, '
      'counter: $counter, isSyncing: $isSyncing)';
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class WidgetDataNotifier extends AsyncNotifier<WidgetData> {
  // ── Build (initial load from shared storage) ───────────────────────────────

  @override
  Future<WidgetData> build() async {
    final stored = await HomeWidgetService.readAll();
    final data = WidgetData(
      title: stored.title,
      subtitle: stored.subtitle,
      counter: stored.counter,
    );

    // Seed SharedPrefs on first launch so the Android widget always has
    // something to display even before the user manually pushes anything.
    await HomeWidgetService.pushUpdate(
      title: data.title,
      subtitle: data.subtitle,
      counter: data.counter,
    );

    return data;
  }

  // ── Mutations ──────────────────────────────────────────────────────────────

  /// Updates only the headline [title] on the home screen widget.
  Future<void> updateTitle(String title) => _sync(title: title);

  /// Updates only the [subtitle] caption on the home screen widget.
  Future<void> updateSubtitle(String subtitle) => _sync(subtitle: subtitle);

  /// Increments the counter by one and pushes the update.
  Future<void> incrementCounter() async {
    final current = state.value?.counter ?? 0;
    await _sync(counter: current + 1);
  }

  /// Decrements the counter by one (floor 0) and pushes the update.
  Future<void> decrementCounter() async {
    final current = state.value?.counter ?? 0;
    await _sync(counter: (current - 1).clamp(0, 9999));
  }

  /// Resets the counter to zero.
  Future<void> resetCounter() => _sync(counter: 0);

  // ── Internal write helper ──────────────────────────────────────────────────

  /// Optimistically updates [state], calls [HomeWidgetService.pushUpdate], and
  /// reverts with an error message if the platform call fails.
  Future<void> _sync({String? title, String? subtitle, int? counter}) async {
    final prev = state.value ?? const WidgetData();

    // Optimistic update so the UI feels instant.
    state = AsyncData(
      prev.copyWith(
        title: title,
        subtitle: subtitle,
        counter: counter,
        isSyncing: true,
        lastError: null,
      ),
    );

    try {
      await HomeWidgetService.pushUpdate(
        title: title,
        subtitle: subtitle,
        counter: counter,
      );
      state = AsyncData(
        (state.value ?? const WidgetData()).copyWith(isSyncing: false),
      );
    } catch (e) {
      // Roll back to previous data and surface the error.
      state = AsyncData(
        prev.copyWith(isSyncing: false, lastError: e.toString()),
      );
    }
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────

/// Global provider. Initialise [HomeWidgetService] in [main()] before this
/// is first read so the platform channel is ready.
final widgetDataProvider =
    AsyncNotifierProvider<WidgetDataNotifier, WidgetData>(
      WidgetDataNotifier.new,
    );
