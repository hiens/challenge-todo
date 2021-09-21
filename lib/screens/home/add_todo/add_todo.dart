import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/configs/colors.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/button.dart';
import 'package:uuid/uuid.dart';

part 'add_todo_controller.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({required this.onSubmitted, Key? key}) : super(key: key);
  final Function(Todo) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTodoController>(
      init: AddTodoController(onSubmitted: onSubmitted),
      builder: (AddTodoController controller) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              16 + MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a new todo...',
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: const TextStyle(fontSize: 16),
                      onChanged: (String value) => controller.task = value,
                    ),
                    Obx(() {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: controller.hasDescription ? 50 : 0,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextField(
                          maxLines: 4,
                          minLines: 1,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Write description...',
                            contentPadding: EdgeInsets.all(0),
                          ),
                          style: const TextStyle(fontSize: 12),
                          expands: false,
                          onChanged: (String value) =>
                              controller.description = value,
                        ),
                      );
                    }),
                    Row(
                      children: <Widget>[
                        Obx(() {
                          return GestureDetector(
                            onTap: () => controller.hasDescription =
                                !controller.hasDescription,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                                border: Border.all(
                                  width: 1.5,
                                  color: controller.hasDescription
                                      ? kPrimaryColor
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Icon(
                                Icons.description,
                                size: 16,
                                color: controller.hasDescription
                                    ? kPrimaryColor
                                    : Colors.grey[700]!,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Icon(
                            Icons.event,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Spacer(),
                        Button.elevated(
                          onPressed: controller.submit,
                          icon: const Icon(Icons.add),
                          label: 'Add',
                          elevation: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
