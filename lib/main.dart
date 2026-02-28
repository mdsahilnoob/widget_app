import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:google_fonts/google_fonts.dart';

import 'core/models/academic_event.dart';
import 'core/models/class_session.dart';
import 'core/models/note.dart';
import 'core/services/demo_data.dart';
import 'features/onboarding/onboarding_screen.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Isar DB
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([
    ClassSessionSchema,
    NoteSchema,
    AcademicEventSchema,
  ], directory: dir.path);

  // Initialize Demo Data
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
          seedColor: const Color(0xFF0D9488), // Teal color
          brightness: Brightness.light,
          surface: Colors.transparent, // Allow gradient backgrounds
        ),
        scaffoldBackgroundColor:
            Colors.transparent, // Handled by gradient container in screens
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        scaffoldBackgroundColor: const Color(
          0xFF1E212B,
        ), // True Black/Dark Theme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D9488),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light, // Set light mode for the exact UX feel
      home: const OnboardingScreen(),
    );
  }
}
