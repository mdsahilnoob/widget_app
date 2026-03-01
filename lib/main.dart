import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'core/models/academic_event.dart';
import 'core/models/class_session.dart';
import 'core/models/note.dart';
import 'core/services/demo_data.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ClassSessionAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(AcademicEventAdapter());
  Hive.registerAdapter(EventTypeAdapter());

  await Hive.openBox<ClassSession>('class_sessions');
  await Hive.openBox<Note>('notes');
  await Hive.openBox<AcademicEvent>('academic_events');

  await DemoDataInitializer.initializeIfNeeded();

  runApp(const UniversityTimetableApp());
}

class UniversityTimetableApp extends StatelessWidget {
  const UniversityTimetableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Timetable',
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D9488),
          brightness: Brightness.light,
          surface: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFF1E212B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D9488),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const OnboardingScreen(),
    );
  }
}
