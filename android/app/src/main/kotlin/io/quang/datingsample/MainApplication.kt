package io.quang.datingsample

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
/*
import io.gjg.androidjobscheduler.AndroidJobScheduler
import com.tekartik.sqflite.SqflitePlugin
import com.lyokone.location.LocationPlugin
*/
import io.flutter.plugins.pathprovider.PathProviderPlugin

class MainApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun registerWith(registry: PluginRegistry) {
        try {
            GeneratedPluginRegistrant.registerWith(registry)
        } catch (e: java.lang.Exception) {
            // LocationPlugin.registerWith(registry.registrarFor("com.lyokone.location.LocationPlugin"))
            // PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"))
            // SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"))
        }
    }

    override fun onCreate() {
        super.onCreate()
        // AndroidJobScheduler.setPluginRegistrantCallback(this)
    }

    private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
        val key = GeneratedPluginRegistrant::class.java!!.getCanonicalName()
        if (registry.hasPlugin(key)) {
            return true
        }
        registry.registrarFor(key)
        return false
    }
}