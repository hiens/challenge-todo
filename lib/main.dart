import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/configs/database.dart';

import 'configs/theme/theme.dart';
import 'screens/home/home.dart';

Future<void> main() async {
  // Widgets binding
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive
  await Database.instance.init();

  // Run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      popGesture: true,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? const SizedBox(),
        );
      },
      home: const HomeScreen(),
    );
  }
}
