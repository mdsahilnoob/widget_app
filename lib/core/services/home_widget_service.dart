import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../constants/app_constants.dart';

@pragma('vm:entry-point')
Future<void> widgetBackgroundCallback(Uri? uri) async {
  if (uri == null) return;

  debugPrint('[HomeWidget] background callback: $uri');

  switch (uri.host) {
    case AppConstants.widgetUriHostIncrement:
      final prefs = await HomeWidget.getWidgetData<int>(
        AppConstants.widgetKeyCounter,
        defaultValue: 0,
      );
      final newCount = (prefs ?? 0) + 1;
      await HomeWidgetService.pushUpdate(
        title: null,
        subtitle: null,
        counter: newCount,
      );
      break;

    case AppConstants.widgetUriHostTap:
      break;

    default:
      debugPrint('[HomeWidget] unknown uri host: ${uri.host}');
  }
}

abstract class HomeWidgetService {
  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId('group.com.example.widget_app');

    HomeWidget.registerInteractivityCallback(widgetBackgroundCallback);
  }

  static Future<void> pushUpdate({
    String? title,
    String? subtitle,
    int? counter,
  }) async {
    if (title != null) {
      await HomeWidget.saveWidgetData<String>(
        AppConstants.widgetKeyTitle,
        title,
      );
    }
    if (subtitle != null) {
      await HomeWidget.saveWidgetData<String>(
        AppConstants.widgetKeySubtitle,
        subtitle,
      );
    }
    if (counter != null) {
      await HomeWidget.saveWidgetData<int>(
        AppConstants.widgetKeyCounter,
        counter,
      );
    }

    await HomeWidget.updateWidget(
      androidName: AppConstants.androidWidgetName,
      iOSName: AppConstants.iosWidgetName,
    );
  }

  static Future<({String title, String subtitle, int counter})>
  readAll() async {
    final title =
        await HomeWidget.getWidgetData<String>(
          AppConstants.widgetKeyTitle,
          defaultValue: 'WIDGET APP',
        ) ??
        'WIDGET APP';

    final subtitle =
        await HomeWidget.getWidgetData<String>(
          AppConstants.widgetKeySubtitle,
          defaultValue: 'Nothing OS',
        ) ??
        'Nothing OS';

    final counter =
        await HomeWidget.getWidgetData<int>(
          AppConstants.widgetKeyCounter,
          defaultValue: 0,
        ) ??
        0;

    return (title: title, subtitle: subtitle, counter: counter);
  }

  static Stream<Uri?> get widgetClicked => HomeWidget.widgetClicked;

  static Future<Uri?> get initialUri =>
      HomeWidget.initiallyLaunchedFromHomeWidget();
}
