import '../models/note_model.dart';
import '../../../../core/database/database_helper.dart';

class NoteLocalDataSource {
  final DatabaseHelper dbHelper;

  NoteLocalDataSource(this.dbHelper);

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

  Future<void> updateNote(NoteModel note) async {
    final db = await dbHelper.database;

    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}