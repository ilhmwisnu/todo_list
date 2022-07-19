import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/provider/todo.dart';

import '../provider/todos.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController descCont = TextEditingController();
  TextEditingController taskCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _todos = Provider.of<Todos>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.amber,
          ),
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                if (descCont.text != "" || taskCont.text != "") {
                  _todos.addTodo(taskCont.text, descCont.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Save"))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(children: [
        TextField(
          controller: taskCont,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            hintText: "Task",
            border: InputBorder.none,
          ),
        ),
        Expanded(
          child: TextField(
            expands: true,
            maxLines: null,
            controller: descCont,
            style: TextStyle(fontSize: 20),
            cursorColor: Colors.amber,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintText: "Description",
              border: InputBorder.none,
            ),
          ),
        ),
      ]),
    );
  }
}
