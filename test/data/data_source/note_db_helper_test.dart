import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/data/data_source/note_db_helper.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    // 인-메모리에 DB를 만들어서 테스트를 할 수 있다.
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    // 테스트에 사용할 Table을 만든다.
    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');

    final noteDbHelper = NoteDbHelper(db);

    await noteDbHelper.insertNote(
      Note(title: 'test', content: 'test', color: 1, timestamp: 1),
    );
    expect((await noteDbHelper.getNotes()).length, 1);

    Note note = (await noteDbHelper.getNoteById(1))!;
    expect(note.id, 1);

    // model에서 note 객체를 불변 객체로 만들었기때문에 copywith를 사용해야한다.
    await noteDbHelper.updateNote(note.copyWith(title: 'change'));

    note = (await noteDbHelper.getNoteById(1))!;
    expect(note.title, 'change');

    await noteDbHelper.deleteNote(note);
    expect((await noteDbHelper.getNotes()).length, 0);

    await db.close();
  });
}
