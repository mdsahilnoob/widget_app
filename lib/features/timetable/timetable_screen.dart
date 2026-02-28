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
  int _selectedDay = DateTime.now().weekday > 5 ? 1 : DateTime.now().weekday;

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
        color: Color(0xFFF8FAFC),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE2E8F0), Color(0xFFF1F5F9), Color(0xFFF8FAFC)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TimetableHeader(),
              const _TimetableTitle(),
              const SizedBox(height: 24),
              _WeekdayPicker(
                days: _days,
                selectedDay: _selectedDay,
                onDaySelected: (id) => setState(() => _selectedDay = id),
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
                      return const _EmptyTimetableState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 120,
                      ),
                      itemCount: classes.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final session = classes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _ClassItem(session: session, index: index),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimetableHeader extends StatelessWidget {
  const _TimetableHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40), // Balance
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
    );
  }
}

class _TimetableTitle extends StatelessWidget {
  const _TimetableTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E212B),
              height: 1.2,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekdayPicker extends StatelessWidget {
  final List<Map<String, dynamic>> days;
  final int selectedDay;
  final ValueChanged<int> onDaySelected;

  const _WeekdayPicker({
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
          children: days.map((day) {
            final isSelected = day['id'] == selectedDay;
            return Expanded(
              child: GestureDetector(
                onTap: () => onDaySelected(day['id'] as int),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2DD4BF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      day['label'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black54,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
                        fontSize: 11, // Smaller font to fit 5 items
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ClassItem extends StatelessWidget {
  final ClassSession session;
  final int index;

  const _ClassItem({required this.session, required this.index});

  @override
  Widget build(BuildContext context) {
    final startTimeString =
        '${session.startTime.hour.toString().padLeft(2, '0')}:${session.startTime.minute.toString().padLeft(2, '0')}';
    final endTimeString =
        '${session.endTime.hour.toString().padLeft(2, '0')}:${session.endTime.minute.toString().padLeft(2, '0')}';

    final Color bgColor = index % 2 == 0
        ? Colors.white.withValues(alpha: 0.7)
        : const Color(0xFFCBECE8).withValues(alpha: 0.7);

    return Container(
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1E212B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${session.lecturer} • ${session.room}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$startTimeString - $endTimeString',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTimetableState extends StatelessWidget {
  const _EmptyTimetableState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(LucideIcons.partyPopper, size: 80, color: Colors.black12),
          SizedBox(height: 24),
          Text(
            'No classes today! 🎉',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
