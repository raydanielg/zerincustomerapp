pluginManagement {
    val flutterSdkPath = run {
        val propertiesFile = file("local.properties")
        val flutterSdkFromLocalProperties = if (propertiesFile.exists()) {
            val properties = java.util.Properties()
            propertiesFile.inputStream().use { properties.load(it) }
            properties.getProperty("flutter.sdk")
        } else {
            null
        }

        val flutterSdkFromEnv = System.getenv("FLUTTER_ROOT")

        val resolvedFlutterSdkPath = flutterSdkFromLocalProperties ?: flutterSdkFromEnv
        require(resolvedFlutterSdkPath != null) {
            "Flutter SDK path not found. Set 'flutter.sdk' in android/local.properties or set the FLUTTER_ROOT environment variable."
        }

        resolvedFlutterSdkPath
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
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false

}

include(":app")