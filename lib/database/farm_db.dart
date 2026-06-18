import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/farm_model.dart';

class FarmDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'farmwise.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE farms (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            animal TEXT,
            count INTEGER,
            age INTEGER,
            weight REAL,
            goal TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertFarm(FarmModel farm) async {
    final db = await database;
    return await db.insert('farms', farm.toMap());
  }

  static Future<List<FarmModel>> getFarms() async {
    final db = await database;
    final result = await db.query('farms');

    return result.map((e) => FarmModel.fromMap(e)).toList();
  }
}
