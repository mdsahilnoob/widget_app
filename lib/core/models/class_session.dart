import 'package:hive_ce/hive.dart';

part 'class_session.g.dart';

@HiveType(typeId: 2)
class ClassSession extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String room;

  @HiveField(2)
  late String lecturer;

  @HiveField(3)
  late DateTime startTime;

  @HiveField(4)
  late DateTime endTime;

  /// 1 = Monday, 2 = Tuesday, ..., 7 = Sunday
  @HiveField(5)
  late int dayOfWeek;
}
