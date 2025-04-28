import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/constants.dart'; 

class DBHelper {
  static Database? _db;
  static const _dbName = 'restaurant.db';
  static const _dbVersion = 1; 

  static Future<Database> database() async {
    if (_db != null) return _db!;
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = p.join(docDir.path, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _db!;
  }

  static Future<void> _onCreate(Database db, int version) async {
    // 1. tabloları oluştur
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        price REAL,
        imageUrl TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE tablesData(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        status TEXT,
        time TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderNumber INTEGER,
        date TEXT,
        total REAL,
        status TEXT
      )
    ''');

    // 2. constants.dart içindeki örnek ürünleri ekle
    for (var item in foodItems) {
      await db.insert('products', {
        'name': item.name,
        'category': item.category,
        'price': item.price,
        'imageUrl': item.imageUrl,
      });
    }
  }

  static Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    // versiyon yükseldiğinde tablovarı silip baştan oluştur ve seed et
    if (oldV < newV) {
      await db.execute('DROP TABLE IF EXISTS products');
      await db.execute('DROP TABLE IF EXISTS tablesData');
      await db.execute('DROP TABLE IF EXISTS orders');
      await _onCreate(db, newV);
    }
  }

  static Future<int> insert(String table, Map<String,dynamic> data) async {
    final db = await database();
    return db.insert(table, data);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }

  static Future<int> update(String table, Map<String,dynamic> data, String where, List<dynamic> args) async {
    final db = await database();
    return db.update(table, data, where: where, whereArgs: args);
  }

  static Future<int> delete(String table, String where, List<dynamic> args) async {
    final db = await database();
    return db.delete(table, where: where, whereArgs: args);
  }
}
