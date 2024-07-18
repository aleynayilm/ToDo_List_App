import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  final _toDoBox = Hive.box('toDoBox');

  void createInitialData() {
    toDoList = [
      ["Eat Healty", false],
      ["Do Exercise", false]
    ];
  }

  void loadData() {
    toDoList = _toDoBox.get("TODOLIST");
  }

  void updateDatabase() {
    _toDoBox.put("TODOLIST", toDoList);
  }
}
