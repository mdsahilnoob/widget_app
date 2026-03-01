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
                    val androidClass = android::class.java
                    val getNamespace = androidClass.getMethod("getNamespace")
                    val setNamespace = androidClass.getMethod("setNamespace", String::class.java)

                    if (getNamespace.invoke(android) == null) {
                        val fallbackNamespace = "com.isar.${project.name.replace("-", "_")}"
                        setNamespace.invoke(android, fallbackNamespace)
                    }
                } catch (e: Exception) { }

                
                tasks.matching { it.name.contains("process") && it.name.contains("Manifest") }.configureEach {
                    doFirst {
                        val manifestFile = file("${project.projectDir}/src/main/AndroidManifest.xml")
                        if (manifestFile.exists()) {
                            val content = manifestFile.readText()
                            val updatedContent = content.replace(Regex("""package="[^"]*""""), "")
                            if (content != updatedContent) {
                                println("Stripping legacy package attribute from: ${project.name}")
                                manifestFile.writeText(updatedContent)
                            }
                        }
                    }
                }
            }
        }
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(this.name)
    this.layout.buildDirectory.value(newSubprojectBuildDir)
}


subprojects {
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}