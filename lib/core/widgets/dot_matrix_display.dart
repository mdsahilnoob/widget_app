import 'package:flutter/material.dart';

// ── 5×7 dot-matrix font ───────────────────────────────────────────────────────
//
// Each character is a list of 7 row-bitmasks.
// For 5-column chars: bit 4 = leftmost column, bit 0 = rightmost.
// For 3-column chars (marked in [_charCols]): bit 2 = left, bit 0 = right.
//
// This font is used to render the Nothing OS inspired dot-matrix display
// without requiring any external TTF assets.

const Map<String, List<int>> _font = {
  // ── Digits ──────────────────────────────────────────────────────────────
  '0': [14, 17, 19, 21, 25, 17, 14],
  '1': [4, 12, 4, 4, 4, 4, 14],
  '2': [14, 17, 1, 2, 4, 8, 31],
  '3': [30, 1, 1, 14, 1, 1, 30],
  '4': [2, 6, 10, 18, 31, 2, 2],
  '5': [31, 16, 16, 30, 1, 1, 30],
  '6': [6, 8, 16, 30, 17, 17, 14],
  '7': [31, 1, 2, 2, 4, 4, 4],
  '8': [14, 17, 17, 14, 17, 17, 14],
  '9': [14, 17, 17, 15, 1, 1, 14],
  // ── Punctuation (3-column, listed in _charCols) ───────────────────────
  ':': [0, 2, 0, 0, 2, 0, 0], // center dot = bit 1 of 3
  '.': [0, 0, 0, 0, 0, 3, 3],
  '-': [0, 0, 0, 7, 0, 0, 0],
  '+': [0, 2, 2, 7, 2, 2, 0],
  '/': [0, 1, 1, 2, 4, 4, 0],
  // ── Letters ───────────────────────────────────────────────────────────
  'A': [14, 17, 17, 31, 17, 17, 17],
  'B': [30, 17, 17, 30, 17, 17, 30],
  'C': [14, 17, 16, 16, 16, 17, 14],
  'D': [30, 17, 17, 17, 17, 17, 30],
  'E': [31, 16, 16, 30, 16, 16, 31],
  'F': [31, 16, 16, 30, 16, 16, 16],
  'G': [14, 17, 16, 23, 17, 17, 14],
  'H': [17, 17, 17, 31, 17, 17, 17],
  'I': [14, 4, 4, 4, 4, 4, 14],
  'J': [1, 1, 1, 1, 1, 17, 14],
  'K': [17, 18, 20, 24, 20, 18, 17],
  'L': [16, 16, 16, 16, 16, 16, 31],
  'M': [17, 27, 21, 17, 17, 17, 17],
  'N': [17, 25, 21, 19, 17, 17, 17],
  'O': [14, 17, 17, 17, 17, 17, 14],
  'P': [30, 17, 17, 30, 16, 16, 16],
  'Q': [14, 17, 17, 17, 21, 18, 13],
  'R': [30, 17, 17, 30, 20, 18, 17],
  'S': [14, 17, 16, 14, 1, 17, 14],
  'T': [31, 4, 4, 4, 4, 4, 4],
  'U': [17, 17, 17, 17, 17, 17, 14],
  'V': [17, 17, 17, 17, 10, 10, 4],
  'W': [17, 17, 17, 21, 21, 27, 17],
  'X': [17, 17, 10, 4, 10, 17, 17],
  'Y': [17, 17, 10, 4, 4, 4, 4],
  'Z': [31, 1, 2, 4, 8, 16, 31],
  ' ': [0, 0, 0, 0, 0, 0, 0],
  '%': [24, 25, 2, 4, 8, 19, 3],
};

/// Characters that use 3 columns instead of the standard 5.
const Map<String, int> _charCols = {
  ':': 3,
  '.': 3,
  '-': 3,
  '+': 3,
  '/': 3,
  '%': 5,
};

// ─────────────────────────────────────────────────────────────────────────────
// Public widget
// ─────────────────────────────────────────────────────────────────────────────

/// Renders [text] as a Nothing OS style dot-matrix display using a
/// [CustomPainter]. No TTF font files are required.
///
/// Supports: 0-9, A-Z (uppercase), ':', '.', '-', '+', '/', '%', ' '.
///
/// Example:
/// ```dart
/// DotMatrixDisplay(
///   text: '12:34',
///   dotSize: 6,
///   spacing: 2,
///   onColor: Colors.white,
/// )
/// ```
class DotMatrixDisplay extends StatelessWidget {
  const DotMatrixDisplay({
    super.key,
    required this.text,
    this.dotSize = 5.0,
    this.spacing = 2.0,
    this.charSpacing = 7.0,
    this.onColor = Colors.white,
    this.offOpacity = 0.07,
  });

  final String text;

  /// Diameter of each individual dot in logical pixels.
  final double dotSize;

  /// Gap between adjacent dot centres in the same character, in pixels.
  final double spacing;

  /// Additional horizontal gap between characters, in pixels.
  final double charSpacing;

  /// Colour of a lit (on) dot.
  final Color onColor;

  /// Opacity of unlit (off / ghost) dots — set to 0 to hide them.
  final double offOpacity;

  // ── Sizing calculations ───────────────────────────────────────────────────

  double get _cell => dotSize + spacing;

  /// Width in logical pixels for a character with [cols] dot-columns.
  double _charWidth(int cols) => (cols - 1) * _cell + dotSize;

  double get _totalWidth {
    double w = 0;
    for (var i = 0; i < text.length; i++) {
      final ch = text[i].toUpperCase();
      final cols = _charCols[ch] ?? 5;
      w += _charWidth(cols);
      if (i < text.length - 1) w += charSpacing;
    }
    return w;
  }

  double get _height => (7 - 1) * _cell + dotSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _totalWidth,
      height: _height,
      child: CustomPaint(
        painter: _DotMatrixPainter(
          text: text.toUpperCase(),
          dotSize: dotSize,
          cell: _cell,
          charSpacing: charSpacing,
          onPaint: Paint()..color = onColor,
          offPaint: Paint()..color = onColor.withValues(alpha: offOpacity),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter
// ─────────────────────────────────────────────────────────────────────────────

class _DotMatrixPainter extends CustomPainter {
  const _DotMatrixPainter({
    required this.text,
    required this.dotSize,
    required this.cell,
    required this.charSpacing,
    required this.onPaint,
    required this.offPaint,
  });

  final String text;
  final double dotSize;
  final double cell;
  final double charSpacing;
  final Paint onPaint;
  final Paint offPaint;

  @override
  void paint(Canvas canvas, Size size) {
    double x = 0;
    for (var i = 0; i < text.length; i++) {
      final ch = text[i];
      final cols = _charCols[ch] ?? 5;
      final glyph = _font[ch] ?? _font[' ']!;
      _paintChar(canvas, glyph, cols, x);
      x += (cols - 1) * cell + dotSize + charSpacing;
    }
  }

  void _paintChar(Canvas canvas, List<int> glyph, int cols, double offsetX) {
    final r = dotSize / 2;
    for (var row = 0; row < 7; row++) {
      final rowBits = glyph[row];
      for (var col = 0; col < cols; col++) {
        // Bit order: most-significant bit = leftmost column.
        final bit = (rowBits >> (cols - 1 - col)) & 1;
        final cx = offsetX + col * cell + r;
        final cy = row * cell + r;
        canvas.drawCircle(Offset(cx, cy), r, bit == 1 ? onPaint : offPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotMatrixPainter old) =>
      old.text != text ||
      old.dotSize != dotSize ||
      old.onPaint.color != onPaint.color ||
      old.offPaint.color != offPaint.color;
}
