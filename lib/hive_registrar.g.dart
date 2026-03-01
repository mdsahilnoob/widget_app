import 'package:hive_ce/hive_ce.dart';
import 'package:widget_app/core/models/academic_event.dart';
import 'package:widget_app/core/models/class_session.dart';
import 'package:widget_app/core/models/note.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(AcademicEventAdapter());
    registerAdapter(ClassSessionAdapter());
    registerAdapter(EventTypeAdapter());
    registerAdapter(NoteAdapter());
  }
}

extension IsolatedHiveRegistrar on IsolatedHiveInterface {
  void registerAdapters() {
    registerAdapter(AcademicEventAdapter());
    registerAdapter(ClassSessionAdapter());
    registerAdapter(EventTypeAdapter());
    registerAdapter(NoteAdapter());
  }
}
