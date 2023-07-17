import 'package:sqflite/sqlite_api.dart';

import '../../domain/model/note.dart';

class NoteDbHelper {
  Database db;

  NoteDbHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    // SELECT * FROM note WHERE id = ?
    // json 형태로
    final List<Map<String, dynamic>> maps =
        await db.query('note', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Note>> getNotes() async {
    // note 테이블의 모든 데이터를 가져온다.
    final maps = await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> insertNote(Note note) async {
    // id를 리턴하면 없다면 0을 리턴한다.
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(Note note) async {
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
