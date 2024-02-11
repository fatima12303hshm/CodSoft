// ignore_for_file: prefer_typing_uninitialized_variables, await_only_futures, file_names

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/source/model/Task.dart';

class DBFcts {
  late Database database;

  Future<void> openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE Tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            day TEXT NOT NULL,
            startTime TEXT NOT NULL,
            dueTime TEXT NOT NULL,
            priority INTEGER NOT NULL,
            status INTEGER NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertIntoDB(Task task) async {
    await openDB();
    Database db = await database;
    await db.insert('Tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  Future<void> deleteTask(int taskId) async {
    await openDB();

    Database db = await database;
    db.delete('Tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<void> updateTask(int taskId, int stat) async {
    await openDB();

    Database db = await database;
    db.update('Tasks', {'status': stat}, where: 'id=?', whereArgs: [taskId]);
  }

  Future<List<Task>> getAllTasks() async {
    try {
      await openDB();

      String currentDate = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toIso8601String();
      final db = await database;
      List<Map<String, dynamic>> tasksMap = await db.query('Tasks',
          where: 'status=? and day=?',
          whereArgs: [0, currentDate],
          orderBy: 'startTime');

      print("Current Date $currentDate");

      List<Task> tasks = tasksMap.map((map) => Task.fromMap(map)).toList();

      return tasks;
    } catch (e) {
      print("Error in getTopTasks: $e");
      return [];
    }
  }

  Future<Task> getTaskById(int ID) async {
    await openDB();

    final db = await database;
    List<Map<String, dynamic>> tasksMap =
        await db.query('Tasks', where: 'id=?', whereArgs: [ID], limit: 1);
    Task returnedTask = Task(
        title: tasksMap[0]['title'],
        description: tasksMap[0]['description'],
        day: tasksMap[0]['day'],
        startTime: tasksMap[0]['startTime'],
        dueTime: tasksMap[0]['dueTime'],
        priority: tasksMap[0]['priority'],
        status: tasksMap[0]['status']);
    return returnedTask;
  }

  Future<Task?> getCurrentTask() async {
    String currentDate = DateTime.now().toIso8601String();

    print('Current Date: $currentDate');

    await openDB();

    final db = await database;

    List<Map<String, dynamic>> tasksMap = await db.rawQuery('''
      SELECT * FROM Tasks 
      WHERE status=?
      ORDER BY startTime DESC
      LIMIT 1
    ''', [1]);

    List<Task> returnedTask = tasksMap.map((map) => Task.fromMap(map)).toList();

    if (returnedTask.isNotEmpty) {
      return returnedTask[0];
    } else {
      return null;
    }
  }

  Future<List<Task>> getTopTasks() async {
    try {
      await openDB();

      String currentDate = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toIso8601String();
      final db = await database;
      List<Map<String, dynamic>> tasksMap = await db.query('Tasks',
          where: 'status=? and day=?',
          whereArgs: [0, currentDate],
          orderBy: 'startTime',
          limit: 2);

      print("Current Date $currentDate");

      List<Task> tasks = tasksMap.map((map) => Task.fromMap(map)).toList();

      return tasks;
    } catch (e) {
      print("Error in getTopTasks: $e");
      return [];
    }
  }

  Future<int> getStatusbyId(int Id) async {
    await openDB();
    final db = await database;
    List<Map<String, dynamic>> stat = await db
        .rawQuery('''SELECT status FROM Tasks WHERE id=? LIMIT 1''', [Id]);
    if (stat.isNotEmpty) {
      return stat[0]['status'] as int;
    } else {
      return -1;
    }
  }

  Future<int> getCount() async {
    await openDB();
    final db = await database;

    List<Map<String, dynamic>> result = await db
        .rawQuery('''select count(id) as count from Tasks where status=? ''', [0]);

    int count = Sqflite.firstIntValue(result) ?? 0;

    return count;
  }
}
