import 'package:get_it/get_it.dart';

import 'features/notes/data/datasources/note_local_datasource.dart';
import 'features/notes/data/repositories/note_repository_impl.dart';
import 'features/notes/domain/repositories/note_repository.dart';
import 'features/notes/domain/usecases/add_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/domain/usecases/get_notes.dart';
import 'features/notes/domain/usecases/update_note.dart';
import 'features/notes/presentation/bloc/note_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data source
  sl.registerLazySingleton(() => NoteLocalDataSource());

  // register interface
  sl.registerLazySingleton<NoteRepository>(
        () => NoteRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotes(sl()));
  sl.registerLazySingleton(() => AddNote(sl()));
  sl.registerLazySingleton(() => DeleteNote(sl()));
  sl.registerLazySingleton(() => UpdateNote(sl()));

  // Bloc
  sl.registerFactory(() => NoteBloc(
    getNotes: sl(),
    addNote: sl(),
    deleteNote: sl(),
    updateNote: sl(),
  ));
}