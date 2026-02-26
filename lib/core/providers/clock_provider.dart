import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Emits the current [DateTime] every second.
///
/// Using [autoDispose] ensures the timer is cancelled when no widget is
/// listening (e.g. when the screen is off-screen in an [IndexedStack]).
final clockProvider = StreamProvider.autoDispose<DateTime>((ref) async* {
  // Yield immediately so the display shows a time right away.
  while (true) {
    yield DateTime.now();
    await Future.delayed(const Duration(seconds: 1));
  }
});
