import 'package:flutter/material.dart';

class PyqsScreen extends StatelessWidget {
  const PyqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded dummy data for structure as there's no backend yet
    final Map<String, List<String>> semesters = {
      'Semester 1': [
        'Mathematics-I',
        'Physics',
        'Basic Electrical Engineering',
        'Communicative English',
      ],
      'Semester 2': [
        'Mathematics-II',
        'Chemistry',
        'Programming in C',
        'Engineering Graphics',
      ],
      'Semester 3': [
        'Data Structures',
        'Analog Electronics',
        'Digital Logic',
        'OOP with Java',
      ],
      'Semester 4': [
        'Algorithms',
        'Computer Organization',
        'Operating Systems',
        'Formal Languages',
      ],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Previous Year Questions')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: semesters.length,
        itemBuilder: (context, index) {
          final semester = semesters.keys.elementAt(index);
          final subjects = semesters[semester]!;

          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            title: Text(
              semester,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: subjects.map((subject) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.redAccent,
                ),
                title: Text(subject),
                trailing: const Icon(Icons.download_rounded),
                onTap: () {
                  // Simulate download or open PDF
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Simulating download for $subject PDF...'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
