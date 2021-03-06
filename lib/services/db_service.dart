import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbService {
  DbService._();
  static final DbService db = DbService._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  _onCreate(db, version) async {
    await db.execute('''
        CREATE TABLE cities (
          id TEXT PRIMARY KEY
        )
        ''');
  }

  _onUpgrade(db, oldVersion, newVersion) async {
    await db.execute('''DROP TABLE IF EXISTS cities''');
    _onCreate(db, newVersion);
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'database.db'),
        onCreate: _onCreate, onUpgrade: _onUpgrade, version: 2);
  }

  newCity(int id) async {
    final db = await database;

    var response = await db.rawInsert('''
      INSERT INTO cities (
        id
      ) VALUES (?)
    ''', [id]);
    return response;
  }

  deleteCity(int id) async {
    final db = await database;

    await db.delete('cities', where: "id = ?", whereArgs: [id]);
  }

  Future<List<int>> getCities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cities');
    return List.generate(maps.length, (i) => int.parse(maps[i]['id']));
  }
}
