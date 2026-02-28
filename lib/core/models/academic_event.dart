import 'package:isar/isar.dart';

part 'academic_event.g.dart';

@collection
class AcademicEvent {
  Id id = Isar.autoIncrement;

  late String title;
  
  late DateTime date;
  
  @enumerated
  late EventType type;
}

enum EventType {
  exam,
  holiday,
  event
}
