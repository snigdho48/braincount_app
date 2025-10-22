# Flutter ProGuard Rules for APK Size Optimization

# Keep Flutter Engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep Google Sign In
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Keep Camera plugin
-keep class io.flutter.plugins.camera.** { *; }
-keep class androidx.camera.** { *; }

# Keep Image Picker
-keep class io.flutter.plugins.imagepicker.** { *; }

# Keep Permission Handler
-keep class com.baseflow.permissionhandler.** { *; }

# Keep Shared Preferences
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# Keep HTTP
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# Keep annotations
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

# GetX Controllers - Critical for reactive state management
-keep class * extends io.flutter.embedding.engine.plugins.FlutterPlugin { *; }
-keep class * extends io.flutter.embedding.engine.plugins.activity.ActivityAware { *; }

# Keep all Dart model classes from obfuscation - Prevents JSON parsing issues
-keep class **.models.** { *; }
-keep class **.data.models.** { *; }
-keep class **.controllers.** { *; }
-keep class **.bindings.** { *; }
-keep class **.services.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Gson (if used for JSON)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}

# Optimize
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
-optimizationpasses 5
-allowaccessmodification
-dontpreverify

# Keep crashlytics (if you add it later)
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Additional optimizations
-repackageclasses ''
-allowaccessmodification

