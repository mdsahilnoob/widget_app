import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PyqsScreen extends StatelessWidget {
  const PyqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> semesters = {
      'Semester 1': ['Mathematics-I', 'Physics', 'BEE', 'English'],
      'Semester 2': ['Mathematics-II', 'Chemistry', 'C Prog.', 'Graphics'],
      'Semester 3': ['Data Structures', 'Analog', 'Digital Logic', 'Java'],
      'Semester 4': ['Algorithms', 'COA', 'Operating Systems', 'FLATA'],
    };

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4EFEF), Color(0xFFE4F5F4), Color(0xFFF0FDF4)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'PYQs',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E212B),
                fontSize: 32,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          itemCount: semesters.length,
          itemBuilder: (context, index) {
            final semester = semesters.keys.elementAt(index);
            final subjects = semesters[semester]!;

            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 1.5,
                      ),
                    ),
                    child: ExpansionTile(
                      shape: const Border(),
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      title: Text(
                        semester,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF1E212B),
                        ),
                      ),
                      children: subjects.map((subject) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 4.0,
                              ),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFDE4EC),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  LucideIcons.fileText,
                                  color: Colors.black87,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                subject,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  LucideIcons.download,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Simulating download for $subject PDF...',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    backgroundColor: const Color(0xFF1E212B),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
