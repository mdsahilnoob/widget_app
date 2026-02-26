# Widget App

> Nothing OS-style home screen widget manager — local-first, 100% open source.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.29-blue?logo=flutter)](https://flutter.dev)

---

## Features

| Widget                    | Description                                                                       |
| ------------------------- | --------------------------------------------------------------------------------- |
| **Digital Clock**         | Dot-matrix HH:MM display with blinking colon, AM/PM badge and running seconds     |
| **Battery Level**         | Custom painter with 10 segments, charging bolt, red accent below 20 %             |
| **Quick Note**            | Editable note pushed live to the Android home screen widget subtitle              |
| **Widget Bridge**         | Control panel: push title, subtitle, counter to your home screen widget instantly |
| **Bidirectional counter** | Tap `+` on the home screen widget without opening the app                         |

All data is stored locally in SharedPreferences — no internet connection, no analytics, no trackers.

---

## Screenshots

_Add screenshots to `fastlane/metadata/android/en-US/images/phoneScreenshots/`_

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.0` ([install](https://docs.flutter.dev/get-started/install))
- Android SDK (API 21+)
- A physical or emulated Android device

### Run locally

```bash
git clone https://github.com/YOUR_USERNAME/widget_app.git
cd widget_app
flutter pub get
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

## Architecture

```
lib/
├── core/
│   ├── constants/      app_constants.dart
│   ├── providers/      clock, battery, quick_note, widget_data, settings
│   ├── services/       home_widget_service.dart
│   ├── theme/          app_theme.dart, app_text_styles.dart
│   └── widgets/        dot_matrix_display.dart
└── features/
    ├── home/           home_screen.dart  (Widget Bridge panel)
    └── widgets/        nothing_clock_card, nothing_battery_card,
                        nothing_quick_note_card, widgets_screen.dart
```

State management: **Riverpod v2** (`AsyncNotifierProvider`, `StreamProvider.autoDispose`)  
Persistence: **SharedPreferences**  
Home screen widgets: **home_widget ^0.9.0**

---

## License

Copyright © 2025 widget_app contributors.  
Licensed under the [GNU General Public License v3.0](LICENSE).
