import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'todo.dart';

class Todos with ChangeNotifier {
  List<Todo> _todoList = [];

  List<Todo> get getTodoList => _todoList;

  void addTodo(String task, String desc) async {
    var box = await Hive.openBox('todo');
    var id = await box.add({
      "task": task,
      "desc": desc,
      "isDone": false,
    });
    _todoList.add(Todo(desc: desc, task: task, id: id));
    print(box.toMap());

    notifyListeners();
  }

  void sortTodoList() async {
    var box = await Hive.openBox('todo');
    // box.clear();
    _todoList.sort((a, b) => (a.isDone) ? 1 : -1);
    notifyListeners();
  }

  void initData() async {
    _todoList.clear();
    var box = await Hive.openBox('todo');
    var data = box.toMap();
    for (var data in data.entries) {
      _todoList.add(
        Todo(
            desc: data.value["desc"],
            task: data.value["task"],
            id: data.key,
            isDone: data.value["isDone"]),
      );
    }
    notifyListeners();
  }
}
