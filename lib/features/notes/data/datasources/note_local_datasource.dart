import '../models/note_model.dart';

class NoteLocalDataSource {
  final List<NoteModel> _notes = [];

  List<NoteModel> getNotes() => _notes;

  void addNote(NoteModel note) => _notes.add(note);

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
  }
}