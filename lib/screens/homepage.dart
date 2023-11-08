import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/data/db.dart';

import 'widgets/dialog_box.dart';
import 'widgets/to_do_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    db.loadData();
    checker();
  }

  final box = Hive.box('myBox');

  final TextEditingController _controller = TextEditingController();

  bool isEmpty = false;

  ToDoDatabase db = ToDoDatabase();
  void checker() {
    if (db.toDoList.isEmpty) {
      setState(() {
        isEmpty = true;
      });
    }
  }

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void editTask(int index) {
    showDialog(
        context: context,
        builder: (context) => DialogBox(
              controller: _controller,
              isEdit: true,
              task: () {
                setState(() {
                  String newText = _controller.text;
                  db.toDoList[index][0] = newText;
                  _controller.clear();
                  Navigator.pop(context);
                });
              },
            ));
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      checker();
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) => DialogBox(
              controller: _controller,
              task: () {
                setState(() {
                  db.toDoList.add([_controller.text, false]);
                  _controller.clear();
                  isEmpty = false;
                  Navigator.pop(context);
                });
              },
            ));
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('HIVE TODO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        child: const Icon(Icons.add),
      ),
      body: isEmpty
          ? const Center(
              child: Text(
              'No Task Available',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (BuildContext context, int index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskComplete: db.toDoList[index][1],
                  editFunction: (value) => editTask(index),
                  deleteFunction: (value) => deleteTask(index),
                  onChanged: (value) => checkboxchanged(value, index),
                );
              },
            ),
    );
  }
}
