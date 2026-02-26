import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../constants/app_constants.dart';

// ── Background callback ───────────────────────────────────────────────────────
// MUST be a top-level function. The @pragma annotation keeps it alive in
// release mode (AOT tree-shaking).

/// Called by [HomeWidget] whenever the user interacts with the home screen
/// widget AND the Flutter engine is NOT currently running in the foreground.
///
/// [uri] encodes the action: e.g. `widgetapp://increment_counter` or
/// `widgetapp://tap_widget`.
@pragma('vm:entry-point')
Future<void> widgetBackgroundCallback(Uri? uri) async {
  if (uri == null) return;

  debugPrint('[HomeWidget] background callback: $uri');

  switch (uri.host) {
    case AppConstants.widgetUriHostIncrement:
      // Read the current counter, increment it, write back, and repaint.
      final prefs = await HomeWidget.getWidgetData<int>(
        AppConstants.widgetKeyCounter,
        defaultValue: 0,
      );
      final newCount = (prefs ?? 0) + 1;
      await HomeWidgetService.pushUpdate(
        title: null, // keep existing title
        subtitle: null, // keep existing subtitle
        counter: newCount,
      );
      break;

    case AppConstants.widgetUriHostTap:
      // Widget was tapped — the main app will be opened automatically by the
      // PendingIntent set in the AppWidgetProvider. Nothing extra to do here.
      break;

    default:
      debugPrint('[HomeWidget] unknown uri host: ${uri.host}');
  }
}

// ── Service ───────────────────────────────────────────────────────────────────

/// Thin wrapper over the [HomeWidget] platform plugin.
///
/// Responsibilities:
///  • Write data to the shared-storage channel (readable by the Android
///    [AppWidgetProvider] and the iOS WidgetKit extension via App Groups).
///  • Trigger a repaint of every placed instance of the home screen widget.
///  • Register the [widgetBackgroundCallback] with the platform.
///  • Expose a [Stream] of interactions that originate from the widget while
///    the app is in the foreground.
abstract class HomeWidgetService {
  // ── Initialisation ────────────────────────────────────────────────────────

  /// Call once in [main()] after [WidgetsFlutterBinding.ensureInitialized()].
  static Future<void> initialize() async {
    // iOS uses App Groups to share data between the app and the widget
    // extension. Replace with your real group identifier when targeting iOS.
    await HomeWidget.setAppGroupId('group.com.example.widget_app');

    // Register the background isolate entry-point.
    HomeWidget.registerInteractivityCallback(widgetBackgroundCallback);
  }

  // ── Write + update ────────────────────────────────────────────────────────

  /// Persists [title], [subtitle], and [counter] to the shared storage and
  /// then asks the OS to repaint every placed widget instance.
  ///
  /// Pass `null` for any field you do NOT want to overwrite.
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

  // ── Read ──────────────────────────────────────────────────────────────────

  /// Reads all widget fields from shared storage in a single batch.
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

  // ── Foreground interaction stream ─────────────────────────────────────────

  /// A [Stream] that emits [Uri] values when the user taps the home screen
  /// widget while the Flutter app is in the foreground.
  static Stream<Uri?> get widgetClicked => HomeWidget.widgetClicked;

  /// Returns the [Uri] the app was launched from if it was opened via the
  /// home screen widget, or `null` otherwise.
  static Future<Uri?> get initialUri =>
      HomeWidget.initiallyLaunchedFromHomeWidget();
}
