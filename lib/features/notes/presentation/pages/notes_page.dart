import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';

class NotesPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const NotesPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(
      LoadNotesByCategory(widget.categoryId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),

      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoaded) {
            if (state.notes.isEmpty) {
              return const Center(child: Text("No notes"));
            }

            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_, i) {
                final note = state.notes[i];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditNotePage(note: note),
                              ),
                            );

                            context.read<NoteBloc>().add(
                              LoadNotesByCategory(widget.categoryId),
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<NoteBloc>().add(DeleteNoteEvent(note.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNotePage(
                categoryId: widget.categoryId,
              ),
            ),
          );

          context.read<NoteBloc>().add(
            LoadNotesByCategory(widget.categoryId),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}