import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  final _box = Hive.box('taskBox');

  void createInitialData() {
    todoList = [
      ["Make tutorial", false],
      ["Do Exercise", false]
    ];
  }

  void loadData() {
    todoList = _box.get("TODOLIST");
  }

  void updateDatabase() {
    _box.put("TODOLIST", todoList);
  }
}
