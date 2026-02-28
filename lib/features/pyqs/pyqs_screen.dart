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
        color: Color(0xFFF8FAFC),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE2E8F0), Color(0xFFF1F5F9), Color(0xFFF8FAFC)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PyqsHeader(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 16,
                    bottom: 120,
                  ),
                  itemCount: semesters.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final semester = semesters.keys.elementAt(index);
                    final subjects = semesters[semester]!;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: _SemesterCard(
                        semester: semester,
                        subjects: subjects,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PyqsHeader extends StatelessWidget {
  const _PyqsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 48, 28, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PYQs',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1E212B),
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Previous Year Question Papers',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SemesterCard extends StatelessWidget {
  final String semester;
  final List<String> subjects;

  const _SemesterCard({required this.semester, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(
                  LucideIcons.download,
                  size: 20,
                  color: Colors.black26,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading $subject PDF...'),
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
    );
  }
}
