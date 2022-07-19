import 'package:flutter/material.dart';

import '../provider/todo.dart';

class TodoTile extends StatelessWidget {
  TodoTile({Key? key, required this.todo, required this.onCheckTap})
      : super(key: key);

  Todo todo;
  void Function() onCheckTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade200),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.task,
                    style: TextStyle(
                      fontSize: 18,
                      color: (todo.isDone) ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration:
                          (todo.isDone) ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    todo.desc,
                    style: TextStyle(
                      color: (todo.isDone) ? Colors.grey : Colors.black,
                      decoration:
                          (todo.isDone) ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: onCheckTap,
              child: Container(
                width: 24,
                height: 24,
                child: (todo.isDone)
                    ? Icon(
                        Icons.check,
                        color: Colors.grey,
                      )
                    : null,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(99)),
              ),
            )
          ],
        ));
  }
}
