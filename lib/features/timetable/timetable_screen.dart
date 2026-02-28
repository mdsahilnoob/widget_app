import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE4F5F4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4EFEF), Color(0xFFE4F5F4), Color(0xFFF0FDF4)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(LucideIcons.arrowLeft, size: 24),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.calendar, size: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 6,
                          left: 0,
                          right: -10,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCBECE8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        Text(
                          'Learning',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF1E212B),
                                height: 1.2,
                                fontSize: 36,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      'Timetable',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E212B),
                            height: 1.2,
                            fontSize: 36,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Glassmorphic Calendar Bento
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.8),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'October',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E212B),
                                    ),
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        LucideIcons.chevronLeft,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        LucideIcons.chevronRight,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildCustomCalendar(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTaskItem(
                      LucideIcons.layoutTemplate,
                      'Typography',
                      'Kate Martinez',
                      Colors.white.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 16),
                    _buildTaskItem(
                      LucideIcons.gem,
                      'Illustration',
                      'Steve Rodriguez',
                      Colors.white.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCalendar() {
    final daysOfWeek = ['Mon', 'Thu', 'Wed', 'Tue', 'Fri', 'Sat', 'Sun'];

    // Generating calendar structure matching design
    final calendarDays = [
      {'day': '26', 'style': 'normal'},
      {'day': '27', 'style': 'normal'},
      {'day': '28', 'style': 'normal'},
      {'day': '29', 'style': 'cyan'},
      {'day': '30', 'style': 'normal'},
      {'day': '31', 'style': 'cyan'},
      {'day': '1', 'style': 'normal'},
      {'day': '2', 'style': 'cyan'},
      {'day': '3', 'style': 'normal'},
      {'day': '4', 'style': 'normal'},
      {'day': '5', 'style': 'normal'},
      {'day': '6', 'style': 'normal'},
      {'day': '7', 'style': 'normal'},
      {'day': '8', 'style': 'normal'},
      {'day': '9', 'style': 'cyan'},
      {'day': '10', 'style': 'normal'},
      {'day': '11', 'style': 'normal'},
      {'day': '12', 'style': 'cyan'},
      {'day': '13', 'style': 'normal'},
      {'day': '14', 'style': 'normal'},
      {'day': '15', 'style': 'normal'},
      {'day': '16', 'style': 'black'},
      {'day': '17', 'style': 'black'},
      {'day': '18', 'style': 'normal'},
      {'day': '19', 'style': 'normal'},
      {'day': '20', 'style': 'normal'},
      {'day': '21', 'style': 'normal'},
      {'day': '22', 'style': 'normal'},
      {'day': '23', 'style': 'normal'},
      {'day': '24', 'style': 'normal'},
      {'day': '25', 'style': 'normal'},
      {'day': '26', 'style': 'normal'},
      {'day': '27', 'style': 'normal'},
      {'day': '28', 'style': 'normal'},
      {'day': '29', 'style': 'normal'},
      {'day': '30', 'style': 'cyan'},
      {'day': '31', 'style': 'cyan'},
      {'day': '1', 'style': 'cyan'},
      {'day': '2', 'style': 'cyan'},
      {'day': '3', 'style': 'normal'},
      {'day': '4', 'style': 'normal'},
      {'day': '5', 'style': 'normal'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: daysOfWeek
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 12,
            crossAxisSpacing: 4,
          ),
          itemCount: calendarDays.length,
          itemBuilder: (context, index) {
            final data = calendarDays[index];
            Color bgColor = Colors.transparent;
            Color textColor = Colors.black87;

            if (data['style'] == 'cyan') {
              bgColor = const Color(0xFF2DD4BF);
              textColor = Colors.white;
            } else if (data['style'] == 'black') {
              bgColor = const Color(0xFF1E212B);
              textColor = Colors.white;
            } else {
              if (index < 3 || index >= calendarDays.length - 5) {
                textColor = Colors.black38;
              }
            }

            return Container(
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  data['day']!,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTaskItem(
    IconData iconData,
    String title,
    String subtitle,
    Color bgColor,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, size: 24, color: Colors.black87),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1E212B),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Transform.rotate(
                  angle: -0.785,
                  child: const Icon(
                    LucideIcons.arrowRight,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
