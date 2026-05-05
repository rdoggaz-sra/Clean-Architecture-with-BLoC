import '../models/note_model.dart';
import '../../../../core/database/database_helper.dart';

class NoteLocalDataSource {
  final dbHelper = DatabaseHelper.instance;

  Future<List<NoteModel>> getNotes() async {
    final db = await dbHelper.database;
    final result = await db.query('notes');

    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<void> addNote(NoteModel note) async {
    final db = await dbHelper.database;
    await db.insert('notes', note.toMap());
  }

  Future<void> deleteNote(String id) async {
    final db = await dbHelper.database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}