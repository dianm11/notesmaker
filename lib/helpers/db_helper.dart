import 'dart:io';

import 'package:notesmaker/models/memo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._CreateObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._CreateObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var noteDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return noteDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        note TEXT
        )
        ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<int> insert(Note object) async {
    Database db = await this.database;
    int count = await db.insert('notes', object.toMap());
    return count;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('notes', orderBy: 'title');
    return mapList;
  }
  

  Future<int> update(Note object) async {
    Database db = await this.database;
    int count = await db
        .update('notes', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('notes', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Note>> getNotesList() async {
    var noteMapList = await select();
    int count = noteMapList.length;
    List<Note> noteList = List<Note>();
    for (int i = 0; i < count; i++) {
      noteList.add(Note.forMap(noteMapList[i]));
    }
    return noteList;
  }
}
