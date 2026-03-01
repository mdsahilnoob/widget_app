import 'package:hive_ce/hive.dart';

part 'academic_event.g.dart';

@HiveType(typeId: 0)
class AcademicEvent extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime date;

  @HiveField(2)
  late EventType type;
}

@HiveType(typeId: 1)
enum EventType {
  @HiveField(0)
  exam,
  @HiveField(1)
  holiday,
  @HiveField(2)
  event,
}
