import 'dart:convert';

class Todo {
  Todo({
    required this.task,
    this.description,
    this.isCompleted = false,
    this.deadline,
  });

  final String task;
  final String? description;
  final bool isCompleted;
  final DateTime? deadline;

  Todo copyWith({
    String? task,
    String? description,
    bool? isCompleted,
    DateTime? deadline,
  }) {
    return Todo(
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      deadline: deadline ?? this.deadline,
    );
  }

  /// Create Todo instance from json object
  static Todo fromJson(dynamic input) {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonEncode(input));

      return Todo(
        task: jsonData['task'],
        description: jsonData['description'],
        isCompleted: jsonData['isCompleted'],
        deadline: jsonData['deadline'] != null
            ? DateTime.tryParse(jsonData['deadline'])?.toLocal()
            : null,
      );
    } catch (e) {
      throw 'Failed to parse Todo model';
    }
  }

  /// Create json object from File instance
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'task': task,
      'description': description,
      'isCompleted': isCompleted,
      'deadline': deadline?.toIso8601String(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
