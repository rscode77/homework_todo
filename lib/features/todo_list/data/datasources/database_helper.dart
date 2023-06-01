import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tasks2_db.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER,
            title TEXT,
            description TEXT,
            date TEXT,
            status TEXT,
            personal TEXT,
            userID INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List<TaskModel>.from(maps.map((map) => TaskModel.fromJson(map)));
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(int taskId, String taskStatus) async {
    final db = await database;
    await db.update(
      'tasks',
      {'status': taskStatus.toLowerCase()},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearTable() async {
    final db = await database;
    await db.execute('DELETE FROM tasks');
  }
}
