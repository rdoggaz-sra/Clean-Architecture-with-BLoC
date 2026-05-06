import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotesByCategory {
  final NoteRepository repository;

  GetNotesByCategory(this.repository);

  Future<List<Note>> call(String categoryId) {
    return repository.getNotesByCategory(categoryId);
  }
}