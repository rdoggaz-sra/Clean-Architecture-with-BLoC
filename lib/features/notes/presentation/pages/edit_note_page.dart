import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class EditNotePage extends StatefulWidget {
  final Note note;

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    super.initState();
  }

  void _updateNote() {
    final updatedNote = Note(
      id: widget.note.id,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      categoryId: widget.note.categoryId,
    );

    context.read<NoteBloc>().add(UpdateNoteEvent(updatedNote));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController),
            const SizedBox(height: 12),
            TextField(controller: _contentController, maxLines: 5),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateNote,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}