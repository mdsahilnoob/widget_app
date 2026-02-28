import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../home/dashboard_screen.dart';
import '../timetable/timetable_screen.dart';
import '../notes/notes_screen.dart';
import '../pyqs/pyqs_screen.dart';
import '../about/about_us_screen.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TimetableScreen(),
    const NotesScreen(),
    const PyqsScreen(),
    const AboutUsScreen(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(icon: Icon(LucideIcons.home), label: 'Home'),
    NavigationDestination(icon: Icon(LucideIcons.calendar), label: 'Timetable'),
    NavigationDestination(icon: Icon(LucideIcons.fileText), label: 'Notes'),
    NavigationDestination(icon: Icon(LucideIcons.book), label: 'PYQs'),
    NavigationDestination(icon: Icon(LucideIcons.info), label: 'About Us'),
  ];

  final List<NavigationRailDestination> _railDestinations = const [
    NavigationRailDestination(
      icon: Icon(LucideIcons.home),
      label: Text('Home'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.calendar),
      label: Text('Timetable'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.fileText),
      label: Text('Notes'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.book),
      label: Text('PYQs'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.info),
      label: Text('About Us'),
    ),
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
