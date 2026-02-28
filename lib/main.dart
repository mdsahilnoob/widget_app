import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/brand_theme_provider.dart';
import 'core/providers/settings_provider.dart';
import 'core/providers/widget_data_provider.dart';
import 'core/services/home_widget_service.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/widgets/widgets_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  await HomeWidgetService.initialize();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const WidgetApp(),
    ),
  );
}

class WidgetApp extends ConsumerStatefulWidget {
  const WidgetApp({super.key});

  @override
  ConsumerState<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends ConsumerState<WidgetApp> {
  StreamSubscription<Uri?>? _widgetClickSub;

  @override
  void initState() {
    super.initState();
    _listenToWidgetClicks();
    _handleLaunchFromWidget();
  }

  void _listenToWidgetClicks() {
    _widgetClickSub = HomeWidgetService.widgetClicked.listen((uri) {
      if (uri == null) return;
      debugPrint('[HomeWidget] foreground click: $uri');
      if (uri.host == 'increment_counter') {
        ref.read(widgetDataProvider.notifier).incrementCounter();
      }
    });
  }

  Future<void> _handleLaunchFromWidget() async {
    final uri = await HomeWidgetService.initialUri;
    if (uri != null) {
      debugPrint('[HomeWidget] launched from widget: $uri');
    }
  }

  @override
  void dispose() {
    _widgetClickSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brand = ref.watch(brandThemeProvider);
    final themeData = AppTheme.forBrand(brand);
    return MaterialApp(
      title: 'Widget App',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,
      theme: themeData,
      darkTheme: themeData,
      home: const _AppShell(),
    );
  }
}

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
