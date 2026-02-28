import '../../main.dart';
import '../models/academic_event.dart';
import '../models/class_session.dart';

class DemoDataInitializer {
  static Future<void> initializeIfNeeded() async {
    // Check if we already have data
    final classCount = await isar.classSessions.count();
    if (classCount > 0) return; // Already initialized

    // Create demo data
    final sessions = [
      ClassSession()
        ..title = 'Algorithms'
        ..room = 'Room A-101'
        ..lecturer = 'Dr. Sharma'
        ..startTime = DateTime(2025, 1, 1, 9, 0)
        ..endTime = DateTime(2025, 1, 1, 10, 30)
        ..dayOfWeek = 1, // Monday
      ClassSession()
        ..title = 'Computer Organization'
        ..room = 'Lab 3'
        ..lecturer = 'Prof. Gupta'
        ..startTime = DateTime(2025, 1, 1, 11, 0)
        ..endTime = DateTime(2025, 1, 1, 12, 30)
        ..dayOfWeek = 1, // Monday
      ClassSession()
        ..title = 'Operating Systems'
        ..room = 'Lecture Hall 2'
        ..lecturer = 'Dr. Kumar'
        ..startTime = DateTime(2025, 1, 2, 10, 0)
        ..endTime = DateTime(2025, 1, 2, 11, 30)
        ..dayOfWeek = 2, // Tuesday
      ClassSession()
        ..title = 'Formal Languages'
        ..room = 'Room C-302'
        ..lecturer = 'Prof. Singh'
        ..startTime = DateTime(2025, 1, 2, 14, 0)
        ..endTime = DateTime(2025, 1, 2, 15, 30)
        ..dayOfWeek = 2, // Tuesday
      ClassSession()
        ..title = 'Algorithms'
        ..room = 'Room A-101'
        ..lecturer = 'Dr. Sharma'
        ..startTime = DateTime(2025, 1, 3, 9, 0)
        ..endTime = DateTime(2025, 1, 3, 10, 30)
        ..dayOfWeek = 3, // Wednesday
      ClassSession()
        ..title = 'Computer Organization'
        ..room = 'Lab 3'
        ..lecturer = 'Prof. Gupta'
        ..startTime = DateTime(2025, 1, 4, 11, 0)
        ..endTime = DateTime(2025, 1, 4, 12, 30)
        ..dayOfWeek = 4, // Thursday
      ClassSession()
        ..title = 'Operating Systems'
        ..room = 'Lecture Hall 2'
        ..lecturer = 'Dr. Kumar'
        ..startTime = DateTime(2025, 1, 5, 10, 0)
        ..endTime = DateTime(2025, 1, 5, 11, 30)
        ..dayOfWeek = 5, // Friday
      ClassSession()
        ..title = 'Formal Languages (Tutorial)'
        ..room = 'Room C-302'
        ..lecturer = 'Prof. Singh'
        ..startTime = DateTime(2025, 1, 5, 14, 0)
        ..endTime = DateTime(2025, 1, 5, 15, 30)
        ..dayOfWeek = 5, // Friday
    ];

    final events = [
      AcademicEvent()
        ..title = 'Mid Semester Exams'
        ..date = DateTime(2025, 3, 15)
        ..type = EventType.exam,
      AcademicEvent()
        ..title = 'Holi Foundation Day'
        ..date = DateTime(2025, 3, 24)
        ..type = EventType.holiday,
      AcademicEvent()
        ..title = 'Tech Fest 2025'
        ..date = DateTime(2025, 4, 10)
        ..type = EventType.event,
    ];

    await isar.writeTxn(() async {
      await isar.classSessions.putAll(sessions);
      await isar.academicEvents.putAll(events);
    });
  }
}
