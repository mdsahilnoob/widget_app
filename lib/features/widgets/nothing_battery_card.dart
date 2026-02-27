import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/battery_provider.dart';
import '../../core/widgets/dot_matrix_display.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Nothing Battery Level Widget Card
// ─────────────────────────────────────────────────────────────────────────────

/// Displays the current battery level as a Nothing OS style indicator.
///
/// Features:
///  • Custom [_BatteryShapePainter] draws a segmented battery outline.
///  • Dot-matrix percentage readout.
///  • Charging toggle + level slider (V1 simulation; replace provider in V2
///    with [battery_plus] without touching this widget).
class NothingBatteryCard extends ConsumerWidget {
  const NothingBatteryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final battery = ref.watch(batteryProvider);

    final Color accentColor = battery.level <= 20
        ? AppConstants.accentRed
        : AppConstants.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spaceMD),
      decoration: BoxDecoration(
        color: AppConstants.surfaceDark,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(
          color: AppConstants.borderGrey,
          width: AppConstants.borderNormal,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Tag ──────────────────────────────────────────────────────────
          _TagPill(label: battery.isCharging ? 'BATTERY  ⚡' : 'BATTERY'),
          const SizedBox(height: AppConstants.spaceMD),

          // ── Visual + readout row ──────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Battery shape painter
              CustomPaint(
                size: const Size(110, 50),
                painter: _BatteryShapePainter(
                  level: battery.level,
                  accentColor: accentColor,
                  isCharging: battery.isCharging,
                ),
              ),
              const SizedBox(width: AppConstants.spaceLG),
              // Dot-matrix percentage
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DotMatrixDisplay(
                    text: '${battery.level}',
                    dotSize: 6,
                    spacing: 2.5,
                    charSpacing: 8,
                    onColor: accentColor,
                    offOpacity: 0.06,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '%',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: accentColor),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spaceMD),
          const Divider(),
          const SizedBox(height: AppConstants.spaceSM),

          // ── Status label ─────────────────────────────────────────────────
          Text(
            _statusLabel(battery.level, battery.isCharging),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: accentColor),
          ),
          const SizedBox(height: AppConstants.spaceMD),

          // ── Slider ───────────────────────────────────────────────────────
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 1,
              activeTrackColor: AppConstants.white,
              inactiveTrackColor: AppConstants.borderGrey,
              thumbColor: AppConstants.white,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayColor: AppConstants.white.withValues(alpha: 0.08),
            ),
            child: Slider(
              value: battery.level.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (v) =>
                  ref.read(batteryProvider.notifier).setLevel(v.round()),
            ),
          ),

          // ── Charging toggle ───────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CHARGING MODE',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Switch(
                value: battery.isCharging,
                onChanged: (v) =>
                    ref.read(batteryProvider.notifier).setCharging(v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _statusLabel(int level, bool charging) {
    if (charging) return 'CHARGING\u2026';
    if (level == 100) return 'FULLY CHARGED';
    if (level >= 80) return 'HIGH';
    if (level >= 40) return 'NORMAL';
    if (level >= 20) return 'LOW — CONSIDER CHARGING';
    return 'CRITICAL — CHARGE NOW';
  }
}

// ── Battery painter ───────────────────────────────────────────────────────────

/// Draws a segmented battery outline that illustrates [level] (0–100).
///
/// Design:
///  • Main body outline with 1 dp stroke.
///  • 10 inner segments filled proportionally to [level].
///  • Positive terminal nub on the right side.
///  • Charging bolt symbol when [isCharging] is true.
class _BatteryShapePainter extends CustomPainter {
  const _BatteryShapePainter({
    required this.level,
    required this.accentColor,
    required this.isCharging,
  });

  final int level;
  final Color accentColor;
  final bool isCharging;

  static const int _segments = 10;
  static const double _nubWidth = 6;
  static const double _nubHeight = 18;
  static const double _radius = 3;
  static const double _stroke = 1;
  static const double _segGap = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final bodyW = size.width - _nubWidth;
    final bodyH = size.height;
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, bodyW, bodyH),
      const Radius.circular(_radius),
    );

    // ── Outline ───────────────────────────────────────────────────────────
    final outlinePaint = Paint()
      ..color = AppConstants.borderGreyLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke;
    canvas.drawRRect(bodyRect, outlinePaint);

    // ── Positive terminal nub ──────────────────────────────────────────────
    final nubTop = (bodyH - _nubHeight) / 2;
    final nubRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(bodyW, nubTop, _nubWidth, _nubHeight),
      const Radius.circular(2),
    );
    canvas.drawRRect(nubRect, outlinePaint);

    // ── Segments ───────────────────────────────────────────────────────────
    const padding = 6.0;
    final innerW = bodyW - padding * 2;
    final innerH = bodyH - padding * 2;
    final segW = (innerW - (_segments - 1) * _segGap) / _segments;
    final filledSegs = (level / 100 * _segments).round();

    final filledPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final dimPaint = Paint()
      ..color = AppConstants.borderGrey
      ..style = PaintingStyle.fill;

    for (var i = 0; i < _segments; i++) {
      final segX = padding + i * (segW + _segGap);
      final segRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(segX, padding, segW, innerH),
        const Radius.circular(1.5),
      );
      canvas.drawRRect(segRect, i < filledSegs ? filledPaint : dimPaint);
    }

    // ── Charging bolt ──────────────────────────────────────────────────────
    if (isCharging) {
      // Use black on lit segments (≥1 segment filled), white on dark background.
      final boltColor = filledSegs > 0
          ? AppConstants.black
          : AppConstants.white;
      final boltPaint = Paint()
        ..color = boltColor
        ..style = PaintingStyle.fill;

      final cx = bodyW / 2;
      final cy = bodyH / 2;
      final boltPath = Path()
        ..moveTo(cx + 3, cy - 9)
        ..lineTo(cx - 2, cy + 1)
        ..lineTo(cx + 1, cy + 1)
        ..lineTo(cx - 3, cy + 9)
        ..lineTo(cx + 2, cy - 1)
        ..lineTo(cx - 1, cy - 1)
        ..close();
      canvas.drawPath(boltPath, boltPaint);
    }
  }

  @override
  bool shouldRepaint(_BatteryShapePainter old) =>
      old.level != level ||
      old.isCharging != isCharging ||
      old.accentColor != accentColor;
}

// ── Tag pill (shared) ─────────────────────────────────────────────────────────

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceSM,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.borderGreyLight,
          width: AppConstants.borderThin,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusSM),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
