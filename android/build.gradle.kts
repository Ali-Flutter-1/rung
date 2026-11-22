allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// posthog_flutter 5.28.0 declares `com.posthog:posthog-android:[3.51.0,4.0.0]`.
// Square brackets are inclusive, so Gradle resolves 4.0.0, whose API renames
// break the plugin's Kotlin sources (PostHogOnFeatureFlags, RRStyle, ...).
// Pin to the newest 3.x until the plugin is upgraded.
subprojects {
    configurations.all {
        resolutionStrategy {
            force("com.posthog:posthog-android:3.75.0")
        }
    }
}
