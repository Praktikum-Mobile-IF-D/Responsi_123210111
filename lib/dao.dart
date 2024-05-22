import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:responsi_123210111/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DBdao {
  static final DBdao _instance = DBdao._();
  static Database? _database;
  DBdao._();

  factory DBdao() {
    return _instance;
  }

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await getDb();
    return _database!;
  }
   // late Database database;
  // var userlists;

  Future<Database> getDb() async {
    String path =
      join(await getDatabasesPath(), 'userdata.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate:  _onCreate,
    );
    // ,
    //   onCreate: (db, version) {
    //     return db.execute(
    //       'CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT, bookmark TEXT)',
    //     );
    //   },
    //   version: 1,
    // );
    // userlists = await users();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, bookmark TEXT)');
  }

  Future<int> insertUser(String username, String password, String bookmark) async {
    final db = await database;
    return await db.insert('users', {
      'username': username,
      'password': password,
      'bookmark': bookmark,
    });
  }

  Future<Map<String, dynamic>?> check(String username, String password) async {
    final db = await database;
    final response = await db.query('users',
    where: 'username = ? AND password = ?',
    whereArgs: [username,password]);

    return response.isNotEmpty ? response.first : null;
  }

  // Future<void> insertUser(User user) async {
  //   final db = await database;
  //
  //   await db.insert(
  //     'users',
  //     user.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<List<User>> users() async {
  //   final db = await database;
  //   final List<Map<String, Object?>>
  //   userMaps = await db.query('users');
  //
  //   return [
  //     for (final {
  //       'username': username as String,
  //       'password': password as String,
  //       'bookmark': bookmark as String,
  //     } in userMaps)
  //       User(username: username, password: password, bookmark: bookmark)
  //   ];
  // }
}
