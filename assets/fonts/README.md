# Custom Font — NothingFont (Placeholder)

This folder is reserved for the Nothing OS inspired custom font.

## How to add the real font

1. Download or license a dotmatrix / monospaced font that matches the Nothing OS
   aesthetic (e.g. **NDot 47**, **Space Mono**, or any OFL-licensed substitute).

2. Rename (or copy) the files:
   - `NothingFont-Regular.ttf`
   - `NothingFont-Bold.ttf`

3. Place both `.ttf` files in this directory (`assets/fonts/`).

4. Uncomment the `fonts:` section in `pubspec.yaml`.

5. Run `flutter pub get` and hot restart the app.

Until the real font files are present the app falls back to **RobotoMono**,
which preserves the monospaced feel of the Nothing OS aesthetic.
