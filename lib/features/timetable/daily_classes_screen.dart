import 'package:flutter/material.dart';
import '../../core/models/class_session.dart';

class DailyClassesScreen extends StatelessWidget {
  const DailyClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Monday to Friday
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Classes'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Monday'),
              Tab(text: 'Tuesday'),
              Tab(text: 'Wednesday'),
              Tab(text: 'Thursday'),
              Tab(text: 'Friday'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _DayScheduleView(day: 1), // Monday
            _DayScheduleView(day: 2), // Tuesday
            _DayScheduleView(day: 3), // Wednesday
            _DayScheduleView(day: 4), // Thursday
            _DayScheduleView(day: 5), // Friday
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Add Class Session
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _DayScheduleView extends StatelessWidget {
  final int day;

  const _DayScheduleView({required this.day});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch from Isar Database based on 'day'
    final List<ClassSession> classes = []; 

    if (classes.isEmpty) {
      return Center(
        child: Text(
          'No classes scheduled',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final session = classes[index];
        final startTimeStr = '${session.startTime.hour.toString().padLeft(2, '0')}:${session.startTime.minute.toString().padLeft(2, '0')}';
        final endTimeStr = '${session.endTime.hour.toString().padLeft(2, '0')}:${session.endTime.minute.toString().padLeft(2, '0')}';

        return Card(
          elevation: 2, // Material 3 Elevated Card style
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(startTimeStr, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('to'),
                Text(endTimeStr),
              ],
            ),
            title: Text(
              session.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.room, size: 16),
                    const SizedBox(width: 4),
                    Text(session.room),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 4),
                    Text(session.lecturer),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
