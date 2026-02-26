## [Unreleased]

## [1.0.0] - 2026-02-27

### Added

- Digital dot-matrix clock card (custom `DotMatrixDisplay` painter, no TTF)
- Battery level indicator card with custom `_BatteryShapePainter`
- Quick Note card — editable, persisted to SharedPreferences
- Widget Bridge panel on the Home screen: push title, subtitle, counter to
  the Android home screen widget
- Bidirectional counter: increment button on the home screen widget fires a
  `HomeWidgetBackgroundIntent` URI, picked up by the app even when closed
- Nothing OS pure-black theme (nothing_clock typography, zero elevation)
- Riverpod v2 state management with `AsyncNotifierProvider` and
  `StreamProvider.autoDispose`
- `home_widget ^0.9.0` bridge with `registerInteractivityCallback`
- GPLv3 license
- GitHub Actions auto-release workflow (tag → signed APK → GitHub Releases)
