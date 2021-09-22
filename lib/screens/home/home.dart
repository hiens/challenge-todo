import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/configs/colors.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/repositories/todo.dart';
import 'package:todo/widgets/button.dart';
import 'package:todo/widgets/subheader.dart';

import 'add_todo/add_todo.dart';
import 'bottom_bar.dart';

part 'home_controller.dart';
part 'todo_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  /// Build incompleted todo list
  Widget _buildTodoList({
    required List<Todo> list,
    required Function(String) onTapItem,
    required Function(String) onRemoved,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        return TodoItem(
          list[i],
          onTap: () => onTapItem(list[i].uniqueId),
          onRemoved: () => onRemoved(list[i].uniqueId),
          key: Key('todo-item-${list[i].uniqueId}'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (HomeScreenController controller) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Obx(() {
              return Text(
                controller.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              );
            }),
          ),
          body: RefreshIndicator(
            onRefresh: controller.fetchTodoList,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.white,
              ),
              child: Obx(() {
                if (controller.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: Get.width / 2,
                        height: Get.width / 2,
                        child: Image.asset('assets/images/empty-box.png'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No todos yet!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Button.outlined(
                        label: 'Import samples',
                        icon: const Icon(Icons.import_export),
                        onPressed: controller.importSamples,
                      ),
                    ],
                  );
                } else {
                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: <Widget>[
                      if (controller.tab == 0 &&
                          controller.incompleteTodo.isNotEmpty)
                        const Subheader(label: 'INCOMPLETE'),
                      if (controller.tab != 2 &&
                          controller.incompleteTodo.isNotEmpty)
                        _buildTodoList(
                          list: controller.incompleteTodo,
                          onTapItem: controller.toggleCheck,
                          onRemoved: controller.removeTodoItem,
                        ),
                      if (controller.tab == 0 &&
                          controller.completedTodo.isNotEmpty)
                        const Subheader(label: 'COMPLETED'),
                      if (controller.tab != 1 &&
                          controller.completedTodo.isNotEmpty)
                        _buildTodoList(
                          list: controller.completedTodo,
                          onTapItem: controller.toggleCheck,
                          onRemoved: controller.removeTodoItem,
                        ),
                    ],
                  );
                }
              }),
            ),
          ),
          bottomNavigationBar: Obx(() {
            return CustomBottomBar(
              activeIndex: controller.tab,
              onTap: (int selectedIndex) => controller.tab = selectedIndex,
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (BuildContext ctx) => AddTodoDialog(
                  onSubmitted: (Todo item) => controller.addTodoItem(item),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
