import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/notes/data/datasources/note_local_datasource.dart';
import 'features/notes/data/repositories/note_repository_impl.dart';
import 'features/notes/domain/usecases/add_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/domain/usecases/get_notes.dart';
import 'features/notes/presentation/bloc/note_bloc.dart';
import 'features/notes/presentation/bloc/note_event.dart';
import 'features/notes/presentation/pages/notes_page.dart';

void main() {
  final dataSource = NoteLocalDataSource();
  final repository = NoteRepositoryImpl(dataSource);

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final NoteRepositoryImpl repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => NoteBloc(
          getNotes: GetNotes(repository),
          addNote: AddNote(repository),
          deleteNote: DeleteNote(repository),
        )..add(LoadNotes()),
        child: const NotesPage(),
      ),
    );
  }
}