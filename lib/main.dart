import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/settings_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/widgets/widgets_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise SharedPreferences once and inject it into Riverpod so every
  // provider that needs persistence receives the same instance.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const WidgetApp(),
    ),
  );
}

// ── Root application widget ───────────────────────────────────────────────────

/// [WidgetApp] is a [ConsumerWidget] so it can watch [settingsProvider]
/// and rebuild when the theme mode changes at runtime.
class WidgetApp extends ConsumerWidget {
  const WidgetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Re-render when dark-mode preference changes.
    final isDark = ref.watch(settingsProvider.select((s) => s.isDarkMode));

    return MaterialApp(
      title: 'Widget App',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      // Nothing OS is dark-only; light theme falls back to the same theme.
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      home: const _AppShell(),
    );
  }
}

// ── Bottom-nav shell ──────────────────────────────────────────────────────────

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[HomeScreen(), WidgetsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            selectedIcon: Icon(Icons.widgets),
            label: 'Widgets',
          ),
        ],
      ),
    );
  }
}
