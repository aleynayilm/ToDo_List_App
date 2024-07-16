import 'package:flutter/material.dart';
import 'package:to_do_list_app/views/widgets/todo_item.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Center(child: Text('To Do')),
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoItem(
              taskName: toDoList[index][0],
              isComplated: toDoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
            );
          },
        ));
  }
}
