import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// ── Load signing properties from android/key.properties ──────────────────────
// The file is NOT committed to VCS (see android/.gitignore).
// In CI the file is written by the GitHub Actions workflow before this runs.
val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties()
if (keyPropertiesFile.exists()) {
    keyProperties.load(keyPropertiesFile.inputStream())
}

android {
    namespace = "com.example.widget_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.widget_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ── Signing configs ───────────────────────────────────────────────────────
    signingConfigs {
        if (keyPropertiesFile.exists()) {
            create("release") {
                keyAlias      = keyProperties.getProperty("keyAlias")      ?: ""
                keyPassword   = keyProperties.getProperty("keyPassword")   ?: ""
                storePassword = keyProperties.getProperty("storePassword") ?: ""
                val storeFilePath = keyProperties.getProperty("storeFile")
                if (!storeFilePath.isNullOrBlank()) {
                    storeFile = file("${project.projectDir}/$storeFilePath")
                }
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (keyPropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                // Fallback to debug key locally when key.properties is absent.
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled  = false  // set true + add proguard rules when ready
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
