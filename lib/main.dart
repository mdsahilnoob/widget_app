import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'core/models/academic_event.dart';
import 'core/models/class_session.dart';
import 'core/models/note.dart';
import 'features/navigation/app_navigation.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar DB
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [ClassSessionSchema, NoteSchema, AcademicEventSchema],
    directory: dir.path,
  );

  runApp(const UniversityTimetableApp());
}

class UniversityTimetableApp extends StatelessWidget {
  const UniversityTimetableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Timetable',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF), // Adding a premium blue base
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // Responsive to device theme
      home: const AppNavigation(),
    );
  }
}
