package io.quang.datingsample

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.gjg.androidjobscheduler.AndroidJobScheduler

class MainApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun registerWith(pluginRegistry: PluginRegistry) {
        try {
            GeneratedPluginRegistrant.registerWith(pluginRegistry)
        } catch (e: java.lang.Exception) {

        }
    }

    override fun onCreate() {
        super.onCreate()
        AndroidJobScheduler.setPluginRegistrantCallback(this)
    }
}