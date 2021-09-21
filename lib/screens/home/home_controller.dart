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

  // Static vars
  final TodoRepository _todoRepository = TodoRepository.instance;

  @override
  void onInit() {
    // Fetch todo list
    fetchTodoList();

    // Auto save todo list to local data
    ever(_todoList, (List<Todo> value) => null);
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

  /// Add new Todo to list
  void addTodoItem(Todo item) {
    todoList = <Todo>[...todoList, item];
  }

  /// Save todo list to local database
  void _saveToLocalDb(List<Todo> value) {
    _todoRepository.saveTodo(value);
  }
}
