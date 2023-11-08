import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  final _mybox = Hive.box('myBox');

  List toDoList = [];

  // Load the data from the database
  void loadData() {
    toDoList = _mybox.get('ToDoList');
  }

  // Update the database
  void updateData() {
    _mybox.put('ToDoList', toDoList);
  }
}
