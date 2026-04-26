# Nivra

Nivra is a personal, maintainable downstream fork of [Signal-Android](https://github.com/signalapp/Signal-Android).

## Goal
The primary objective of Nivra is to preserve Signal's end-to-end encryption, security logic, and compatibility entirely intact, while offering a visually customized, Material You-inspired interface and custom branding.

## Maintenance
Nivra is designed to be easily syncable with the upstream Signal repository. All customizations are structurally isolated in a `nivra` Gradle product flavor, or otherwise protected via path guards in GitHub Actions.

## Building
To build Nivra, ensure you select the `nivraProdRelease` (or `nivraProdDebug`) build variant in Android Studio.

```bash
# Example: Building release bundle
./gradlew bundleNivraProdRelease
```

## Contributing / Upstream Sync
This repository runs automated GitHub Action workflows to fetch upstream updates from `https://github.com/signalapp/Signal-Android.git` daily. Safe paths are auto-merged. Core protected paths (crypto, libsignal, WebRTC, etc.) will ALWAYS require human review to prevent accidental tampering with Signal's secure logic.

## Licensing
Signal and Nivra are distributed under the AGPLv3 license. See the LICENSE file for more information.
