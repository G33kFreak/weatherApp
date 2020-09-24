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

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'database.db'),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE cities (
          name TEXT PRIMARY KEY
        )
        ''');
    }, version: 1);
  }

  newCity(String cityName) async {
    final db = await database;

    var response = await db.rawInsert('''
      INSERT INTO cities (
        name
      ) VALUES (?)
    ''', [cityName]);
    return response;
  }

  deleteCity(String name) async {
    final db = await database;

    await db.delete('cities', where: "name = ?", whereArgs: [name]);
  }

  Future<List<String>> getCities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cities');

    return List.generate(maps.length, (i) => maps[i]['name']);
  }
}
