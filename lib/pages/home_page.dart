import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/pages/add_todo_page.dart';
import 'package:todo_list_app/provider/todos.dart';
import 'package:todo_list_app/widget/TodoTile.dart';

import '../provider/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = false;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      final todos = Provider.of<Todos>(context);
      todos.initData();
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<Todos>(context);
    List<Todo> todoList = todos.getTodoList;

    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Ilham Wisnu"),
                accountEmail: Text("ilhamwisnu42@gmail.com"),
                decoration: BoxDecoration(color: Colors.amber),
                currentAccountPicture:
                    CircleAvatar(backgroundColor: Colors.white),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text("Favorite"),
              )
            ],
          ),
        ),
        drawerEnableOpenDragGesture: true,
        backgroundColor: Colors.white,
        appBar: appBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoPage(),
                ));
          },
        ),
        body: Center(
          child: Container(
              margin: EdgeInsets.all(16).copyWith(top: 0, bottom: 0),
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) => TodoTile(
                    todo: todoList[index],
                    onCheckTap: () {
                      todoList[index].toggleIsDone();
                      todos.sortTodoList();
                    }),
              )),
        ));
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "TODO",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.amber,
    );
  }
}
