import 'package:get_it/get_it.dart';

import 'core/database/database_helper.dart';
import 'features/categories/data/datasources/category_local_datasource.dart';
import 'features/categories/data/repositories/category_repository_impl.dart';
import 'features/categories/domain/repositories/category_repository.dart';
import 'features/categories/domain/usecases/add_category.dart';
import 'features/categories/domain/usecases/get_categories.dart';
import 'features/categories/presentation/bloc/category_bloc.dart';
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
  sl.registerLazySingleton(() => DatabaseHelper());

  // Data source
  sl.registerLazySingleton(() => NoteLocalDataSource(sl()));
  sl.registerLazySingleton(() => CategoryLocalDataSource(sl()));

  // register interface
  sl.registerLazySingleton<NoteRepository>(
        () => NoteRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotes(sl()));
  sl.registerLazySingleton(() => AddNote(sl()));
  sl.registerLazySingleton(() => DeleteNote(sl()));
  sl.registerLazySingleton(() => UpdateNote(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => AddCategory(sl()));

  // Bloc
  sl.registerFactory(() => NoteBloc(
    getNotes: sl(),
    addNote: sl(),
    deleteNote: sl(),
    updateNote: sl(),
  ));

  sl.registerFactory(() => CategoryBloc(
    getCategories: sl(),
    addCategory: sl(),
  ));
}