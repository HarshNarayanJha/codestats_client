package com.harshnj.codestats_client

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import java.io.File

import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class StatsWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            // get data from the flutter app

            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.stats_widget).apply {

                val username = widgetData.getString("username", null)
                setTextViewText(R.id.statswidget_username, username ?: "No Text...")

                val level = widgetData.getString("level_text", null)
                setTextViewText(R.id.statswidget_level_text, level ?: "No Text...")

                val current_xp = widgetData.getString("current_xp", null)
                setTextViewText(R.id.statswidget_current_xp, current_xp ?: "No Text...")

                val lang1 = widgetData.getString("lang1", null)
                setTextViewText(R.id.statswidget_lang1, lang1 ?: "No Text...")

                val lang2 = widgetData.getString("lang2", null)
                setTextViewText(R.id.statswidget_lang2, lang2 ?: "No Text...")

                val lang3 = widgetData.getString("lang3", null)
                setTextViewText(R.id.statswidget_lang3, lang3 ?: "No Text...")

                val xp_to_next = widgetData.getString("xp_to_next", null)
                setTextViewText(R.id.statswidget_xp_to_next, xp_to_next ?: "No Text...")

                val last_programmed = widgetData.getString("last_programmed", null)
                setTextViewText(R.id.statswidget_last_programmed, last_programmed ?: "No Text...")

                // Get the progress image and put it in the widget, if exists
                val imageName = widgetData.getString("progress_filename", null)
                val imageFile = File(imageName)
                val imageExists = imageFile.exists()
                if (imageExists) {
                    val progressBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                    setImageViewBitmap(R.id.statswidget_progress_image, progressBitmap)
                } else {
                    println("image not found!, looked @: ${imageName}")
                }
            }

            // update the widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}
