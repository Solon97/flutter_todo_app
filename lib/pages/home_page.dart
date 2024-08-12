import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/dialog_create_task.dart';
import 'package:todo_app/components/todo_item.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box("taskBox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_box.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value;
      db.updateDatabase();
    });
  }

  void addTask() {
    setState(() {
      db.todoList.add([
        _controller.text,
        false,
      ]);
      db.updateDatabase();
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.updateDatabase();
    });
  }

  void showNewTaskDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogCreateTask(
            textFieldController: _controller,
            onSave: addTask,
            onCancel: () {
              Navigator.of(context).pop();
              _controller.clear();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNewTaskDialog,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoItem(
              taskName: db.todoList[index][0],
              isCompleted: db.todoList[index][1],
              onChecked: (value) => checkBoxChanged(value, index),
              deleteTaskFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
