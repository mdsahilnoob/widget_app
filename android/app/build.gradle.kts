import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    
    id("dev.flutter.flutter-gradle-plugin")
}




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
                
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled  = false  
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
