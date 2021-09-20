import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (HomeScreenController controller) {
        return Scaffold();
      },
    );
  }
}
