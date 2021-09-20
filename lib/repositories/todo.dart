import 'package:todo/models/todo.dart';

class TodoRepository {
  // Implement singleton
  TodoRepository._internal();
  static final TodoRepository _instance = TodoRepository._internal();
  static TodoRepository get instance => _instance;

  /// Get sample data from asset
  Future<List<Todo>> getSampleData() async {
    return <Todo>[];
  }

  /// Get todo list from local database
  Future<List<Todo>> getTodos() async {
    return <Todo>[];
  }

  /// Save todo list to local database
  Future<void> saveTodos() async {}
}
