package com.example.widget_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Android AppWidgetProvider for the Nothing OS inspired home screen widget.
 *
 * Data flow:
 *   Flutter app  →  HomeWidget.saveWidgetData()  →  SharedPreferences
 *              →  HomeWidget.updateWidget()       →  onUpdate() here
 *                                                 →  RemoteViews update
 *
 * Shared data is stored under the "HomeWidgetPlugin" SharedPreferences file
 * by the home_widget package and read via [HomeWidgetPlugin.getData].
 */
class NothingWidgetProvider : AppWidgetProvider() {

    // ── Entry-points ─────────────────────────────────────────────────────────

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (id in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, id)
        }
    }

    // ── Widget render ────────────────────────────────────────────────────────

    private fun updateAppWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
    ) {
        // Read the shared data written by Flutter via home_widget.
        val widgetData = HomeWidgetPlugin.getData(context)

        val title   = widgetData.getString("widget_title",   "WIDGET APP") ?: "WIDGET APP"
        val subtitle = widgetData.getString("widget_subtitle", "Nothing OS")  ?: "Nothing OS"
        val counter = widgetData.getInt("widget_counter", 0)
        val counterStr = counter.toString().padStart(2, '0')

        val views = RemoteViews(context.packageName, R.layout.nothing_widget_layout)

        // ── Bind data ────────────────────────────────────────────────────────
        views.setTextViewText(R.id.tv_widget_title, title.uppercase())
        views.setTextViewText(R.id.tv_widget_subtitle, subtitle)
        views.setTextViewText(R.id.tv_widget_counter, counterStr)

        // ── PendingIntents ───────────────────────────────────────────────────

        // Tapping the widget body opens the Flutter app (foreground).
        val launchIntent: PendingIntent = HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            uri = android.net.Uri.parse("widgetapp://${AppWidgetConstants.URI_HOST_TAP}"),
        )
        views.setOnClickPendingIntent(R.id.widget_root, launchIntent)

        // The "+" button sends a background increment intent handled by the
        // Dart widgetBackgroundCallback (no need to open the app).
        val incrementIntent: PendingIntent = HomeWidgetBackgroundIntent.getBroadcast(
            context,
            uri = android.net.Uri.parse("widgetapp://${AppWidgetConstants.URI_HOST_INCREMENT}"),
        )
        views.setOnClickPendingIntent(R.id.btn_increment, incrementIntent)

        // ── Commit ───────────────────────────────────────────────────────────
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}

/** Mirrors [AppConstants] widgetUri* values so they stay in sync. */
object AppWidgetConstants {
    const val URI_HOST_TAP       = "tap_widget"
    const val URI_HOST_INCREMENT = "increment_counter"
}
