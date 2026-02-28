import 'package:flutter/material.dart';

import '../timetable/daily_classes_screen.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DailyClassesScreen(),
    const Scaffold(body: Center(child: Text('Academic Calendar'))),
    const Scaffold(body: Center(child: Text('Notes'))),
    const Scaffold(body: Center(child: Text('PYQs'))),
    const Scaffold(body: Center(child: Text('About Us'))),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(icon: Icon(Icons.schedule), label: 'Classes'),
    NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
    NavigationDestination(icon: Icon(Icons.note), label: 'Notes'),
    NavigationDestination(icon: Icon(Icons.library_books), label: 'PYQs'),
    NavigationDestination(icon: Icon(Icons.info), label: 'About Us'),
  ];

  final List<NavigationRailDestination> _railDestinations = const [
    NavigationRailDestination(icon: Icon(Icons.schedule), label: Text('Classes')),
    NavigationRailDestination(icon: Icon(Icons.calendar_month), label: Text('Calendar')),
    NavigationRailDestination(icon: Icon(Icons.note), label: Text('Notes')),
    NavigationRailDestination(icon: Icon(Icons.library_books), label: Text('PYQs')),
    NavigationRailDestination(icon: Icon(Icons.info), label: Text('About Us')),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile Layout
          return Scaffold(
            body: _screens[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: _destinations,
            ),
          );
        } else {
          // Tablet/Desktop Layout
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: _railDestinations,
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _screens[_selectedIndex]),
              ],
            ),
          );
        }
      },
    );
  }
}
