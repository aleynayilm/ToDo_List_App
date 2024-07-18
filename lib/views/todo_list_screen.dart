import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_app/services/todo_service.dart';
import 'package:to_do_list_app/views/widgets/alert_companent.dart';
import 'package:to_do_list_app/views/widgets/todo_item.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final _toDoBox = Hive.box('toDoBox');
  ToDoDatabase database = ToDoDatabase();

  @override
  void initState() {
    if (_toDoBox.get("TODOLIST") == null) {
      database.createInitialData();
    } else {
      database.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkboxChanged(bool? value, int index) {
    setState(() {
      database.toDoList[index][1] = !database.toDoList[index][1];
    });
    database.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      database.toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    _controller.clear();
    database.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertCompanent(
          controller: _controller,
          onSaved: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      database.toDoList.removeAt(index);
    });
    database.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Center(
              child: Text(
            'To Do',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: database.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoItem(
              taskName: database.toDoList[index][0],
              isComplated: database.toDoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
