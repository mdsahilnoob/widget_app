# University Timetable App

> A premium, modern University Timetable manager built with Flutter.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.29-blue?logo=flutter)](https://flutter.dev)

---

## Features

- **Smart Timetable**: Organize your classes with a sleek, daily schedule view.
- **Quick Notes**: Capture thoughts on-the-go with our full-screen, high-performance editor.
- **PYQs Access**: Easy access to Previous Year Question papers for all your semesters.
- **Bento UI & Glassmorphism**: A modern design language inspired by Nothing OS and Apple's glassmorphism.
- **Local-first Persistence**: Fast, offline data storage using **Isar DB**.
- **Cross-Platform**: Smooth performance on both mobile and tablet devices.

---

## Screenshots

_Add your screenshots to the `assets/images/` or `fastlane/metadata/` directory._

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.x` ([install](https://docs.flutter.dev/get-started/install))
- Android SDK (API 24+)
- A physical or emulated Android device

### Run locally

```bash
# Clone the repository
git clone https://github.com/mdsahilnoob/widget_app.git

# Navigate to project
cd widget_app

# Fetch dependencies
flutter pub get

# Run on your device
flutter run
```

### Build a signed release APK

1. Generate a keystore (first time only):

```bash
chmod +x scripts/generate_keystore.sh
./scripts/generate_keystore.sh
```

2. Build:

```bash
flutter build apk --release
```

The signed APK is at `build/app/outputs/flutter-apk/app-release.apk`.

---

## CI / Auto-Release (GitHub Actions)

Pushing a tag like `v1.0.0` automatically:

1. Builds a signed release APK
2. Generates a SHA-256 checksum
3. Creates a GitHub Release and attaches both files

### Required GitHub secrets

| Secret            | Value                                    |
| ----------------- | ---------------------------------------- |
| `KEYSTORE_BASE64` | `base64 -w 0 android/app/release.jks`    |
| `KEY_ALIAS`       | Alias used when the keystore was created |
| `KEY_PASSWORD`    | Key password                             |
| `STORE_PASSWORD`  | Keystore password                        |

```bash
git tag v1.0.0
git push origin v1.0.0
```

---

## F-Droid

This app targets F-Droid distribution. Metadata lives at
`fastlane/metadata/android/en-US/`. Reproducible-build support is planned for
a future release.

---

## Credits

Built with ❤️ by **Mohammad Sahil**
Designer & Developer

---

## License

Copyright © 2025 University Timetable Contributors.  
Licensed under the [GNU General Public License v3.0](LICENSE).
