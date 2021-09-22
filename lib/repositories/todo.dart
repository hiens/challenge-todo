import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:todo/configs/database.dart';
import 'package:todo/models/todo.dart';

class TodoRepository {
  // Implement singleton
  TodoRepository._internal();
  static final TodoRepository _instance = TodoRepository._internal();
  static TodoRepository get instance => _instance;

  /// Get sample data from asset
  Future<List<Todo>> getSampleData() async {
    final String response =
        await rootBundle.loadString('assets/jsons/sample_data.json');
    final dynamic data = await json.decode(response);

    if (data is List && data.isNotEmpty)
      return data.map((dynamic item) => Todo.fromJson(item)).toList();
    else
      return <Todo>[];
  }

  /// Get todo list from local database
  Future<List<Todo>> getTodo() async {
    final Box<dynamic> todoBox = Database.todo();

    if (todoBox.values.isNotEmpty)
      return todoBox.values.map((dynamic item) => Todo.fromJson(item)).toList();
    else
      return <Todo>[];
  }

  /// Save todo list to local database
  Future<void> saveTodo(List<Todo> list) async {
    final Box<dynamic> todoBox = Database.todo();
    todoBox.deleteAll(todoBox.keys);
    todoBox.addAll(list.map<dynamic>((Todo item) => item.toJson()).toList());
  }
}
