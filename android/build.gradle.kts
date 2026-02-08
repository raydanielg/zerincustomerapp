import com.android.build.gradle.AppExtension
import com.android.build.gradle.LibraryExtension

// Root-level build.gradle.kts
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // classpath("com.google.gms:google-services:4.4.4")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory.value(rootProject.layout.projectDirectory.dir("../build"))

subprojects {
    project.layout.buildDirectory.value(rootProject.layout.buildDirectory.dir(project.name))
}

subprojects {
    project.configurations.all {
        resolutionStrategy {
            force("com.android.tools:desugar_jdk_libs:2.1.5")
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Forces all Flutter plugins to use compileSdk 36
subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            val android = project.extensions.getByName("android")

            when (android) {
                is LibraryExtension -> {
                    android.compileSdk = 36
                }
                is AppExtension -> {
                    android.compileSdkVersion(36)
                }
            }
        }
    }
}