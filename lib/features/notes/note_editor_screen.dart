import 'package:hive_ce/hive.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/models/note.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _selectedColor;

  final List<int> _availableColors = [
    0xFFCBECE8, // Mint
    0xFFFBE4C7, // Peach
    0xFFFDE4EC, // Pink
    0xFFD4EFEF, // Blueish
    0xFFE4F5F4, // Light Mint
    0xFFF0FDF4, // Light Green
    0xFFFFF7ED, // Light Orange
    0xFFF8FAFC, // Slate
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    _selectedColor = widget.note?.color ?? _availableColors[0];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note cannot be empty!')));
      return;
    }

    final noteToSave = widget.note ?? Note()
      ..timestamp = DateTime.now();

    noteToSave.title = title.isEmpty ? 'Untitled' : title;
    noteToSave.content = content;
    noteToSave.color = _selectedColor;
    noteToSave.timestamp = DateTime.now();

    final notesBox = Hive.box<Note>('notes');
    if (widget.note != null) {
      final key = widget.note!.key;
      if (key != null) {
        await notesBox.put(key, noteToSave);
      } else {
        await notesBox.add(noteToSave);
      }
    } else {
      await notesBox.add(noteToSave);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _deleteNote() async {
    if (widget.note != null) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        final key = widget.note!.key;
        if (key != null) {
          final notesBox = Hive.box<Note>('notes');
          await notesBox.delete(key);
        }
        if (mounted) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_selectedColor).withValues(alpha: 0.3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(LucideIcons.trash2, color: Colors.redAccent),
              onPressed: _deleteNote,
            ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: FilledButton(
              onPressed: _saveNote,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF1E212B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Color selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: _availableColors.map((colorValue) {
                final isSelected = _selectedColor == colorValue;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = colorValue),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(colorValue),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black87 : Colors.white24,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Color(colorValue).withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: isSelected
                        ? const Icon(
                            LucideIcons.check,
                            size: 16,
                            color: Colors.black54,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E212B),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black26),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Last edited: ${widget.note?.timestamp.toString().substring(0, 16) ?? DateTime.now().toString().substring(0, 16)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _contentController,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Start writing...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black26),
                      ),
                    ),
                    const SizedBox(height: 100), // Reserve space for scrolling
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
