import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  // Implement singleton
  Database._internal();
  static final Database _instance = Database._internal();
  static Database get instance => _instance;

  /// Init hive database
  Future<void> init() async {
    // Db path
    final Directory directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);

    // Open boxes
    await Hive.openBox<dynamic>('todo');
  }

  /// Get boxes
  static Box<dynamic> todo() => Hive.box<dynamic>('todo');
}
