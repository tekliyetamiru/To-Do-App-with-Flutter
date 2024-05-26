import 'package:hive_flutter/hive_flutter.dart';

class ToDoData {
  final _mybox = Hive.box('mybox');
  List toDoList = [];
  void createIntialData() {
    toDoList = [
      ["Make tutotial", false],
      ["do execrise", false]
    ];
  }

  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  void updateData() {
    _mybox.put("TODOLIST", toDoList);
  }
}
