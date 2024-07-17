import 'package:flutter/material.dart';
import 'package:to_do_list_app/views/widgets/my_box.dart';
import 'package:to_do_list_app/views/widgets/todo_item.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

final _controller = TextEditingController();

class _ToDoListScreenState extends State<ToDoListScreen> {
  List toDoList = [
    ['Eat Healty', false],
    ['Do Exercise', false]
  ];
  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return MyBox(
          controller: _controller,
          onSaved: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
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
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoItem(
              taskName: toDoList[index][0],
              isComplated: toDoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
