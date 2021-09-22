part of 'home.dart';

class HomeScreenController extends GetxController {
  // Reactive vars
  final Rx<int> _tab = Rx<int>(0);
  final Rx<List<Todo>> _todoList = Rx<List<Todo>>(<Todo>[]);

  // Getters/setters
  int get tab => _tab.value;
  set tab(int value) => _tab.value = value;
  List<Todo> get todoList => _todoList.value;
  set todoList(List<Todo> value) => _todoList.value = value;
  List<Todo> get incompleteTodo =>
      todoList.where((Todo e) => !e.isCompleted).toList();
  List<Todo> get completedTodo =>
      todoList.where((Todo e) => e.isCompleted).toList();
  String get title => tab == 0
      ? 'All'
      : tab == 1
          ? 'Incomplete'
          : 'Completed';
  bool get isEmpty =>
      todoList.isEmpty ||
      (tab == 1 && incompleteTodo.isEmpty) ||
      (tab == 2 && completedTodo.isEmpty);

  // Static vars
  final TodoRepository _todoRepository = TodoRepository.instance;

  @override
  void onInit() {
    // Fetch todo list
    fetchTodoList();

    // Auto save todo list to local data
    ever(_todoList, (List<Todo> value) => _saveToLocalDb(value));
    super.onInit();
  }

  /// Fetch todo list from local database
  Future<void> fetchTodoList() async {
    try {
      final List<Todo> results = await _todoRepository.getTodo();
      todoList = results;
    } catch (e) {
      // Show exception in toast
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  /// Import samples from assets
  Future<void> importSamples() async {
    try {
      final List<Todo> results = await _todoRepository.getSampleData();
      todoList = results;
    } catch (e) {
      // Show exception in toast
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  /// Add new Todo to list
  void addTodoItem(Todo item) {
    todoList = <Todo>[...todoList, item];
  }

  /// Remove a todo from list
  void removeTodoItem(String uniqueId) {
    final int removingIndex =
        todoList.indexWhere((Todo e) => e.uniqueId == uniqueId);
    todoList = <Todo>[...todoList]..removeAt(removingIndex);
  }

  /// Check/uncheck todo item
  void toggleCheck(String uniqueId) {
    final int editingIndex =
        todoList.indexWhere((Todo e) => e.uniqueId == uniqueId);
    final Todo updatedTodo = todoList[editingIndex]
        .copyWith(isCompleted: !todoList[editingIndex].isCompleted);
    todoList = <Todo>[...todoList]
      ..removeAt(editingIndex)
      ..add(updatedTodo);
  }

  /// Save todo list to local database
  void _saveToLocalDb(List<Todo> value) {
    try {
      _todoRepository.saveTodo(value);
    } catch (e) {
      // Show exception in toast
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
}
