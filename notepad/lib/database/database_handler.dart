import 'package:notepad/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  DatabaseHandler._();
  static final DatabaseHandler db = DatabaseHandler._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        creation_date DATE
      )
      ''');
    }, version: 1);
  }

  addNewNote(NoteModel note) async {
    final db = await database;
    db!.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteNote(String title) async {
    final db = await database;
    int count =
        await db!.rawDelete("DELETE FROM notes where title = ?", [title]);
    return count;
  }

  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db!.query('notes');
    if (res.length == 0) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  Future<int> updateNote(int id, String changedText) async {
    final db = await database;
    int count = await db!.rawUpdate('''
      UPDATE notes SET body = ? where id = ?
      ''', [changedText, id]);
    return count;
  }
}
