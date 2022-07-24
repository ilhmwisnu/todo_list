import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
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

  Future<void> toggleIsDone() async {
    isDone = !isDone;
    update();
  }

  Future<void> update() async {
    Box box = await Hive.openBox("todo");
    box.put(id, {
      "task": task,
      "desc": desc,
      "isDone": isDone,
    });
  }
}
