import '../../main.dart';
import '../models/academic_event.dart';
import '../models/class_session.dart';
import '../models/note.dart';

class DemoDataInitializer {
  static Future<void> initializeIfNeeded() async {
    // Check if we already have data
    final classCount = await isar.classSessions.count();
    if (classCount > 0) return; // Already initialized

    // Create demo data for a Computer Science student
    final sessions = [
      // Monday
      ClassSession()
        ..title = 'Data Structures & Algorithms'
        ..room = 'Lab 1 - Block A'
        ..lecturer = 'Dr. A. Sharma'
        ..startTime = DateTime(2025, 1, 1, 9, 0)
        ..endTime = DateTime(2025, 1, 1, 11, 0)
        ..dayOfWeek = 1,
      ClassSession()
        ..title = 'Database Management Systems'
        ..room = 'Lecture Hall 4'
        ..lecturer = 'Prof. B. Kumar'
        ..startTime = DateTime(2025, 1, 1, 11, 30)
        ..endTime = DateTime(2025, 1, 1, 12, 30)
        ..dayOfWeek = 1,
      // Tuesday
      ClassSession()
        ..title = 'Operating Systems'
        ..room = 'Room 202'
        ..lecturer = 'Dr. S. Singh'
        ..startTime = DateTime(2025, 1, 2, 10, 0)
        ..endTime = DateTime(2025, 1, 2, 11, 30)
        ..dayOfWeek = 2,
      ClassSession()
        ..title = 'Computer Networks'
        ..room = 'Lab 4'
        ..lecturer = 'Prof. M. Das'
        ..startTime = DateTime(2025, 1, 2, 12, 0)
        ..endTime = DateTime(2025, 1, 2, 13, 0)
        ..dayOfWeek = 2,
      // Wednesday
      ClassSession()
        ..title = 'Theory of Computation'
        ..room = 'Room 305'
        ..lecturer = 'Dr. V. Gupta'
        ..startTime = DateTime(2025, 1, 3, 9, 0)
        ..endTime = DateTime(2025, 1, 3, 10, 30)
        ..dayOfWeek = 3,
      ClassSession()
        ..title = 'Software Engineering'
        ..room = 'Lecture Hall 1'
        ..lecturer = 'Prof. R. Patel'
        ..startTime = DateTime(2025, 1, 3, 11, 0)
        ..endTime = DateTime(2025, 1, 3, 12, 30)
        ..dayOfWeek = 3,
      // Thursday
      ClassSession()
        ..title = 'Artificial Intelligence'
        ..room = 'Room 204'
        ..lecturer = 'Dr. N. Roy'
        ..startTime = DateTime(2025, 1, 4, 10, 0)
        ..endTime = DateTime(2025, 1, 4, 11, 30)
        ..dayOfWeek = 4,
      ClassSession()
        ..title = 'Data Structures Lab'
        ..room = 'Lab 1 - Block A'
        ..lecturer = 'Dr. A. Sharma'
        ..startTime = DateTime(2025, 1, 4, 13, 0)
        ..endTime = DateTime(2025, 1, 4, 15, 0)
        ..dayOfWeek = 4,
      // Friday
      ClassSession()
        ..title = 'Operating Systems Lab'
        ..room = 'Lab 3'
        ..lecturer = 'Dr. S. Singh'
        ..startTime = DateTime(2025, 1, 5, 9, 0)
        ..endTime = DateTime(2025, 1, 5, 11, 0)
        ..dayOfWeek = 5,
      ClassSession()
        ..title = 'Web Technologies'
        ..room = 'Room 101'
        ..lecturer = 'Prof. K. Mishra'
        ..startTime = DateTime(2025, 1, 5, 11, 30)
        ..endTime = DateTime(2025, 1, 5, 13, 0)
        ..dayOfWeek = 5,
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

    final initialNotes = [
      Note()
        ..title = 'DBMS Normalization rules'
        ..content =
            '1NF: Atomic values.\n2NF: 1NF + No partial dependency.\n3NF: 2NF + No transitive dependency.\nBCNF: Strict 3NF.'
        ..timestamp = DateTime.now()
        ..color = 0xFFCBECE8, // Mint
      Note()
        ..title = 'Process Scheduling Algorithms'
        ..content =
            'FCFS, SJF, Round Robin (time quantum is critical for context switching overhead), Priority.'
        ..timestamp = DateTime.now()
        ..color = 0xFFFBE4C7, // Pale Orange
      Note()
        ..title = 'OSI Model Layers'
        ..content =
            '1. Physical\n2. Data Link\n3. Network\n4. Transport\n5. Session\n6. Presentation\n7. Application'
        ..timestamp = DateTime.now()
        ..color = 0xFFFDE4EC, // Pink
    ];

    // Transaction to insert all demo data
    await isar.writeTxn(() async {
      await isar.classSessions.putAll(sessions);
      await isar.academicEvents.putAll(events);
      await isar.notes.putAll(initialNotes);
    });
  }
}
