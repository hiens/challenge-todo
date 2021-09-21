part of 'add_todo.dart';

class AddTodoController extends GetxController {
  AddTodoController({required this.onSubmitted});
  final Function(Todo) onSubmitted;

  // Reactive vars
  final Rx<String?> _task = Rx<String?>(null);
  final Rx<String?> _description = Rx<String?>(null);
  final Rx<bool> _hasDescription = Rx<bool>(false);
  final Rx<DateTime?> _deadline = Rx<DateTime?>(null);

  // Getters
  String? get task => _task.value;
  set task(String? value) => _task.value = value;
  String? get description => _description.value;
  set description(String? value) => _description.value = value;
  bool get hasDescription => _hasDescription.value;
  set hasDescription(bool value) => _hasDescription.value = value;
  DateTime? get deadline => _deadline.value;
  set deadline(DateTime? value) => _deadline.value = value;

  // Static vars
  final Uuid _uuid = const Uuid();

  /// On click Add
  void submit() {
    final Todo generatedTodo = Todo(
      task: task!,
      uniqueId: _uuid.v1(),
      deadline: deadline,
      description: description,
      isCompleted: false,
    );
    onSubmitted(generatedTodo);

    // Close dialog if it visible
    if (!isClosed) {
      Get.back<void>();
    }
  }
}
