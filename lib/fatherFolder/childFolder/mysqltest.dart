import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String notes = 'notes';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  //  يتم استدعاؤها مرة واحدة فقط وظيفتها انشاء جدول _oncreate()

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $notes (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        note TEXT
      )
    ''');
    print("ONCREATE: =================== ");
  }
  //   version    كل ما تم تغير   onUpgrade تم استدعاء

  _onupgrade(Database db, int oldVersion, int newversion) {
    print(" onUpgrade: ==========================");
  }

  Future<int> addNote(String note) async {
    final db = await database;
    return await db.insert(notes, {'note': note});
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query(notes);
  }

  Future<int> updateNote(int id, String note) async {
    final db = await database;

    int s = await db.update('notes', {'note': note},
        where: 'id = ?', whereArgs: [id]);
    print("s = $s");
    return s;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(notes, where: 'id = ?', whereArgs: [id]);
  }
}
