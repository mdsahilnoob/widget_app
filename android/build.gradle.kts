allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    afterEvaluate {
        val project = this
        if (project.hasProperty("android")) {
            val android = project.extensions.findByName("android")
            if (android != null) {
                try {
                    // Reflection fix for Namespace issue in older plugins like Isar
                    val androidClass = android::class.java
                    val getNamespace = androidClass.getMethod("getNamespace")
                    val setNamespace = androidClass.getMethod("setNamespace", String::class.java)

                    if (getNamespace.invoke(android) == null) {
                        // Dynamically set a unique namespace based on project name
                        val fallbackNamespace = "com.isar.${project.name.replace("-", "_")}"
                        setNamespace.invoke(android, fallbackNamespace)
                    }
                } catch (e: Exception) {
                    // Silent catch for compatibility
                }
            }
        }
    }
}

// Optimization for Flutter build speed and storage
val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(this.name)
    this.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Important: Move this outside to avoid evaluation order loops
project(":app") {
    subprojects {
        evaluationDependsOn(":app")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}