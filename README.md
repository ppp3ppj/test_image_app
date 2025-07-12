test_image_app
==============

A Proof of Concept (PoC) Flutter app that demonstrates:

- MVVM architecture
- Image picking
- HTTP requests
- Performance testing
- Voice recording
- Background services using WorkManager

Requirements
------------

- Flutter SDK installed and configured
- Android NDK 27+ installed via Android Studio

Features
--------

- [x] MVVM architecture (clean separation of logic)
- [x] Image picker integration
- [x] HTTP request handling
- [x] Performance test support
- [x] Voice recording functionality
- [x] Background services using WorkManager

Build Instructions
------------------
~~~
Android

To build the Android app:

    flutter build apk --release

The release APK will be available at:
build/app/outputs/flutter-apk/app-release.apk

iOS
To build the iOS app:

    flutter build ios --release

Note: iOS builds require a macOS environment with Xcode installed.
