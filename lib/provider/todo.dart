import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/provider/todos.dart';

class Todo {
  int id;
  bool isDone;
  String desc, task;

  Todo({
    required this.id,
    this.isDone = false,
    required this.desc,
    required this.task,
  });

  void toggleIsDone() {
    isDone = !isDone;
  }
}
