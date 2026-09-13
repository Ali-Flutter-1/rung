pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
    // Required by FlutterFire on Android: compiles google-services.json into the
    // string resources the NATIVE FirebaseApp reads. Dart-side initializeApp()
    // covers Dart calls, but FirebaseMessagingService starts in the native
    // process before Dart exists (background/terminated push) — without these
    // resources it can't initialize, so pushes never arrive.
    id("com.google.gms.google-services") version "4.4.2" apply false
}

include(":app")
