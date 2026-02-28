import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/home_widget_service.dart';

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

  final bool isSyncing;

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
      lastError: lastError,
    );
  }

  @override
  String toString() =>
      'WidgetData(title: $title, subtitle: $subtitle, '
      'counter: $counter, isSyncing: $isSyncing)';
}

class WidgetDataNotifier extends AsyncNotifier<WidgetData> {
  @override
  Future<WidgetData> build() async {
    final stored = await HomeWidgetService.readAll();
    final data = WidgetData(
      title: stored.title,
      subtitle: stored.subtitle,
      counter: stored.counter,
    );

    await HomeWidgetService.pushUpdate(
      title: data.title,
      subtitle: data.subtitle,
      counter: data.counter,
    );

    return data;
  }

  Future<void> updateTitle(String title) => _sync(title: title);

  Future<void> updateSubtitle(String subtitle) => _sync(subtitle: subtitle);

  Future<void> incrementCounter() async {
    final current = state.value?.counter ?? 0;
    await _sync(counter: current + 1);
  }

  Future<void> decrementCounter() async {
    final current = state.value?.counter ?? 0;
    await _sync(counter: (current - 1).clamp(0, 9999));
  }

  Future<void> resetCounter() => _sync(counter: 0);

  Future<void> _sync({String? title, String? subtitle, int? counter}) async {
    final prev = state.value ?? const WidgetData();

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
      state = AsyncData(
        prev.copyWith(isSyncing: false, lastError: e.toString()),
      );
    }
  }
}

final widgetDataProvider =
    AsyncNotifierProvider<WidgetDataNotifier, WidgetData>(
      WidgetDataNotifier.new,
    );
