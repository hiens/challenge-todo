import 'package:flutter/material.dart';
import 'package:todo/configs/colors.dart';
import 'package:todo/widgets/button.dart';

Future<void> openAddTodoDialog({
  required BuildContext context,
}) async {
  return await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
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
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a new todo...',
                      contentPadding: EdgeInsets.all(0),
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8),
                  //   child: TextField(
                  //     maxLines: 4,
                  //     minLines: 1,
                  //     decoration: InputDecoration(
                  //       isDense: true,
                  //       border: InputBorder.none,
                  //       hintText: 'Write description...',
                  //       contentPadding: const EdgeInsets.all(0),
                  //     ),
                  //     style: TextStyle(fontSize: 12),
                  //     expands: false,
                  //   ),
                  // ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                          border: Border.all(
                            width: 1.5,
                            color: kPrimaryColor,
                          ),
                        ),
                        child: const Icon(
                          Icons.description,
                          size: 16,
                          color: kPrimaryColor,
                        ),
                      ),
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
                        onPressed: () {},
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
