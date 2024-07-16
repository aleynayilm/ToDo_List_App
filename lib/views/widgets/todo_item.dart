import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool isComplated;
  final void Function(bool?)? onChanged;
  const ToDoItem(
      {super.key,
      required this.taskName,
      this.onChanged,
      required this.isComplated});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[350], borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                value: isComplated,
                onChanged: onChanged,
                activeColor: Colors.pink,
                checkColor: Colors.white,
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: isComplated
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
