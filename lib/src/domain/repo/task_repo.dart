import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskRepo {
  const TaskRepo._(this._db);

  final Database _db;

  static Future<TaskRepo> create() async {
    final db = await openDatabase(
      "tasks_x.db",
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
                      CREATE TABLE tasks(
                          id TEXT PRIMARY KEY,
                          title TEXT,
                          description TEXT,
                          createdAt TEXT
                          )
                      ''');
      },
      onUpgrade: (db, prev, version) async {
        if (prev < 2) {
          await db.execute(
            "ALTER TABLE tasks ADD COLUMN status TEXT NOT NULL DEFAULT 'pending'",
          );

          await db.execute(
            "ALTER TABLE tasks ADD COLUMN updatedAt TEXT DEFAULT '1970-01-01T00:00:00.000Z'",
          );
        }
      },
    );

    return TaskRepo._(db);
  }

  Future<Task?> addTask(Task task) async {
    final result = await _db.insert(
      'tasks',
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result == 0 ? null : task;
  }

  Future<List<Task>> getTasks() async {
    final rows = await _db.query('tasks');
    return rows.map((row) => Task.fromJson(row)).toList();
  }

  Future<int> toggleTaskStatus(String taskId, TaskStatus status) async {
    final result = await _db.update(
      'tasks',
      {'status': status.name, "updatedAt": DateTime.now().toString()},
      where: 'id = ?',
      whereArgs: [taskId],
    );

    return result;
  }

  /// if it returns 0, then nothing deleted
  Future<int> deleteTask(String id) async {
    return await _db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
