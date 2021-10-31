import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  // Create or initialize dadabase in Local
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'transfert.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE floozOperation(id TEXT PRIMARY KEY, somme INT, numero TEXT, typeOfTrans TEXT)');
    }, version: 1);
  }

// Post data in local Database
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  //  Fecth Data in Local Database
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
