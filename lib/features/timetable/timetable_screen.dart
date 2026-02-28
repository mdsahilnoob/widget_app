import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/models/class_session.dart';
import '../../main.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _selectedDay = DateTime.now().weekday > 5
      ? 1
      : DateTime.now().weekday; // Default to current day (Mon-Fri)

  final _days = [
    {'id': 1, 'label': 'Mon'},
    {'id': 2, 'label': 'Tue'},
    {'id': 3, 'label': 'Wed'},
    {'id': 4, 'label': 'Thu'},
    {'id': 5, 'label': 'Fri'},
  ];

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
                  const Icon(
                    LucideIcons.arrowLeft,
                    size: 24,
                    color: Colors.transparent,
                  ), // Space balancing
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
            // Glassmorphic Weekday Picker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _days.map((day) {
                        final isSelected = day['id'] == _selectedDay;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDay = day['id'] as int;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2DD4BF)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              day['label'] as String,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: StreamBuilder<List<ClassSession>>(
                stream: isar.classSessions
                    .filter()
                    .dayOfWeekEqualTo(_selectedDay)
                    .sortByStartTime()
                    .watch(fireImmediately: true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final classes = snapshot.data ?? [];

                  if (classes.isEmpty) {
                    return Center(
                      child: Text(
                        'No classes today! 🎉',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: Colors.black54),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      final session = classes[index];
                      Color bgColor = index % 2 == 0
                          ? Colors.white.withValues(alpha: 0.7)
                          : const Color(0xFFCBECE8).withValues(alpha: 0.7);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildTaskItem(session, bgColor),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(ClassSession session, Color bgColor) {
    final startTimeString =
        '${session.startTime.hour.toString().padLeft(2, '0')}:${session.startTime.minute.toString().padLeft(2, '0')}';
    final endTimeString =
        '${session.endTime.hour.toString().padLeft(2, '0')}:${session.endTime.minute.toString().padLeft(2, '0')}';

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
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
                child: const Icon(
                  LucideIcons.monitorPlay,
                  size: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1E212B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${session.lecturer} • ${session.room}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$startTimeString - $endTimeString',
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
