import 'dart:ui';
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

  Widget _buildCustomBottomBar() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.9),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2DD4BF).withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(0, LucideIcons.home, 'Home'),
                  _buildNavItem(1, LucideIcons.calendar, 'Class'),
                  _buildNavItem(2, LucideIcons.fileText, 'Notes'),
                  _buildNavItem(3, LucideIcons.book, 'PYQs'),
                  _buildNavItem(4, LucideIcons.info, 'About'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 12 : 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E212B) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF2DD4BF)
                  : Colors.grey.shade700,
              size: 24,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuint,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile Layout
          return Scaffold(
            extendBody: true, // Crucial for floating nav bar overlap
            backgroundColor: const Color(0xFFE4F5F4), // Base fallback color
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _screens[_selectedIndex],
            ),
            bottomNavigationBar: _buildCustomBottomBar(),
          );
        } else {
          // Tablet/Desktop Layout
          return Scaffold(
            backgroundColor: const Color(0xFFE4F5F4),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  backgroundColor: const Color(0xFFF0FDF4),
                  selectedIconTheme: const IconThemeData(
                    color: Color(0xFF2DD4BF),
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: Colors.grey.shade700,
                  ),
                  selectedLabelTextStyle: const TextStyle(
                    color: Color(0xFF1E212B),
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelTextStyle: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                  indicatorColor: const Color(0xFF1E212B),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(LucideIcons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(LucideIcons.calendar),
                      label: Text('Schedule'),
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
                      label: Text('About'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _screens[_selectedIndex],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
