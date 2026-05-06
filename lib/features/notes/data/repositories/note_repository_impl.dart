import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl(this.localDataSource);

  @override
  Future<List<Note>> getNotes() async {
    return localDataSource.getNotes();
  }

  @override
  Future<void> addNote(Note note) async {
    localDataSource.addNote(NoteModel.fromEntity(note));
  }

  @override
  Future<void> deleteNote(String id) async {
    localDataSource.deleteNote(id);
  }

  @override
  Future<void> updateNote(Note note) async {
    await localDataSource.updateNote(
      NoteModel.fromEntity(note),
    );
  }

  @override
  Future<List<Note>> getNotesByCategory(String categoryId) async {
    return await localDataSource.getNotesByCategory(categoryId);
  }
}