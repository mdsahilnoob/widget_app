import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../core/models/academic_event.dart';

class AcademicCalendarScreen extends StatelessWidget {
  const AcademicCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<AcademicEvent>('academic_events').listenable(),
      builder: (context, box, _) {
        final events = box.values.toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Academic Calendar')),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: events.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No upcoming events',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final event = events[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(
                                event.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}/${event.date.year}',
                                ),
                              ),
                              trailing: Badge(
                                label: Text(event.type.name.toUpperCase()),
                                backgroundColor: _getBadgeColor(event.type),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                              ),
                            ),
                          );
                        }, childCount: events.length),
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: Add Event
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Color _getBadgeColor(EventType type) {
    switch (type) {
      case EventType.exam:
        return Colors.red;
      case EventType.holiday:
        return Colors.green;
      case EventType.event:
        return Colors.blue;
    }
  }
}
