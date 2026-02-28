import 'package:isar/isar.dart';

part 'class_session.g.dart';

@collection
class ClassSession {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String title;
  
  late String room;
  
  late String lecturer;
  
  late DateTime startTime;
  
  late DateTime endTime;
  
  /// 1 = Monday, 2 = Tuesday, ..., 7 = Sunday
  late int dayOfWeek;
}
