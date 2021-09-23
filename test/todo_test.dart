import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo/models/todo.dart';
import 'package:todo/screens/home/home.dart';

void main() {
  group('TodoItem', () {
    testWidgets('Todo item should show title, description',
        (WidgetTester tester) async {
      // Build todo item with sample data
      await tester.pumpWidget(TodoItem(
        Todo(
          uniqueId: 'todo-1',
          task: 'Test title',
          description: 'Test description',
        ),
        key: const Key('test-todo-item-1'),
      ));

      // Verify that title is visible
      expect(find.widgetWithText(Text, 'Test title'), findsOneWidget);
      expect(find.widgetWithText(Text, 'Test description'), findsOneWidget);
    });
    testWidgets('Todo item should checked when tapped',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(TodoItem(
        Todo(
          uniqueId: 'todo-2',
          task: 'Test todo',
        ),
        key: const Key('test-todo-item-2'),
      ));

      // Tap
      await tester.tap(find.text('Test todo'));
      await tester.pump();

      // Verify that checkbox is checked & remove icon is visible
      final Checkbox checkbox = tester.firstWidget(find.byType(Checkbox));
      expect(checkbox.value, false);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });
}
