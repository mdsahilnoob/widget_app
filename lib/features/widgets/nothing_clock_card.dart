import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/clock_provider.dart';
import '../../core/widgets/dot_matrix_display.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Nothing Digital Clock Widget Card
// ─────────────────────────────────────────────────────────────────────────────

/// A full-width card showing the current time as a dot-matrix display.
///
/// The primary display (HH:MM) uses large dots. The running seconds
/// counter appears below at half the size, alongside the current date.
/// The colon blinks on odd seconds for an authentic LED clock effect.
class NothingClockCard extends ConsumerWidget {
  const NothingClockCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockAsync = ref.watch(clockProvider);
    return clockAsync.when(
      loading: () => const _ClockShell(child: _ClockPlaceholder()),
      error: (e, _) => const _ClockShell(child: _ClockPlaceholder()),
      data: (now) => _ClockShell(child: _ClockFace(now: now)),
    );
  }
}

// ── Shell ─────────────────────────────────────────────────────────────────────

class _ClockShell extends StatelessWidget {
  const _ClockShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _NothingCard(tag: 'CLOCK', child: child);
  }
}

// ── Clock face ────────────────────────────────────────────────────────────────

class _ClockFace extends StatelessWidget {
  const _ClockFace({required this.now});
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    // Colon blinks on odd seconds.
    final colonChar = now.second.isOdd ? ' ' : ':';

    // Convert to 12-hour so the AM/PM badge is consistent.
    final hour12 = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final hh = _pad(hour12);
    final mm = _pad(now.minute);
    final ss = _pad(now.second);
    final timeStr = '$hh$colonChar$mm';

    final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final dateStr =
        '${weekdays[now.weekday - 1]}  ${now.day}  ${months[now.month - 1]}  ${now.year}';

    final amPm = now.hour < 12 ? 'AM' : 'PM';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Large HH:MM ────────────────────────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DotMatrixDisplay(
              text: timeStr,
              dotSize: 6,
              spacing: 2.5,
              charSpacing: 8,
              onColor: AppConstants.white,
              offOpacity: 0.06,
            ),
            const SizedBox(width: 10),
            // AM/PM badge
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: DotMatrixDisplay(
                text: amPm,
                dotSize: 3,
                spacing: 1.5,
                charSpacing: 5,
                onColor: AppConstants.whiteMuted,
                offOpacity: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceMD),
        // ── Seconds ────────────────────────────────────────────────────────
        DotMatrixDisplay(
          text: ss,
          dotSize: 3.5,
          spacing: 1.5,
          charSpacing: 5,
          onColor: AppConstants.whiteMuted,
          offOpacity: 0.05,
        ),
        const SizedBox(height: AppConstants.spaceMD),
        // ── Date ───────────────────────────────────────────────────────────
        Text(dateStr, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');
}

// ── Placeholder ───────────────────────────────────────────────────────────────

class _ClockPlaceholder extends StatelessWidget {
  const _ClockPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DotMatrixDisplay(
      text: '00:00',
      dotSize: 6,
      spacing: 2.5,
      charSpacing: 8,
      onColor: AppConstants.white,
      offOpacity: 0.06,
    );
  }
}

// ── Shared Nothing card shell ─────────────────────────────────────────────────

class _NothingCard extends StatelessWidget {
  const _NothingCard({required this.tag, required this.child});
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          // Tag pill
          _TagPill(label: tag),
          const SizedBox(height: AppConstants.spaceMD),
          child,
        ],
      ),
    );
  }
}

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
