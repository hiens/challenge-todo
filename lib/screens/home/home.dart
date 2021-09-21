import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo/configs/colors.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/repositories/todo.dart';
import 'package:todo/widgets/subheader.dart';

import 'add_todo/add_todo.dart';
import 'bottom_bar.dart';

part 'home_controller.dart';
part 'todo_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildTodoList(HomeScreenController controller) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: <Widget>[
        if (controller.tab == 0) const Subheader(label: 'INCOMPLETE'),
        if (controller.tab != 2 && controller.incompleteTodo.isNotEmpty)
          AutomaticAnimatedList<Todo>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: controller.incompleteTodo,
            insertDuration: const Duration(milliseconds: 500),
            removeDuration: const Duration(milliseconds: 500),
            keyingFunction: (Todo item) => Key(item.uniqueId),
            itemBuilder: (
              BuildContext context,
              Todo item,
              Animation<double> animation,
            ) {
              return FadeTransition(
                key: Key(item.uniqueId),
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                    reverseCurve: Curves.easeIn,
                  ),
                  child: TodoItem(
                    item,
                    onTap: () {},
                    key: Key('todo-item-${item.uniqueId}'),
                  ),
                ),
              );
            },
          ),
        if (controller.tab == 0) const Subheader(label: 'COMPLETED'),
        if (controller.tab != 1 && controller.completedTodo.isNotEmpty)
          AutomaticAnimatedList<Todo>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: controller.completedTodo,
            insertDuration: const Duration(milliseconds: 500),
            removeDuration: const Duration(milliseconds: 500),
            keyingFunction: (Todo item) => Key(item.uniqueId),
            itemBuilder: (
              BuildContext context,
              Todo item,
              Animation<double> animation,
            ) {
              return FadeTransition(
                key: Key(item.uniqueId),
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                    reverseCurve: Curves.easeIn,
                  ),
                  child: TodoItem(
                    item,
                    onTap: () {},
                    key: Key('todo-item-${item.uniqueId}'),
                  ),
                ),
              );
            },
          ),
      ],
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
              child: Obx(() => _buildTodoList(controller)),
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
