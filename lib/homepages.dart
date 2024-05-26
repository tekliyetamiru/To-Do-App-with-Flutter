// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:app/Utill/dialogbox.dart';
import 'package:app/Utill/todotile.dart';
import 'package:app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDoData db = ToDoData();

  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createIntialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(
      () {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      },
    );
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void deleteTask(int indext) {
    setState(() {
      db.toDoList.removeAt(indext);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 216, 212, 178),
        appBar: AppBar(
          title: Text(
            "To Do App",
          ),
          backgroundColor: Color.fromARGB(255, 32, 207, 35),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return Todotile(
              taskNamed: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
