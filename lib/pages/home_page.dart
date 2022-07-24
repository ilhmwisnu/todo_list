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
  bool onSelectMode = false;
  List<int> selected = [];

  void updateSelected() {
    if (selected.length == 0) {
      onSelectMode = false;
    }
    setState(() {});
  }

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
    Todos todos = Provider.of<Todos>(context);
    List<Todo> todoList = todos.getTodoList;

    return Scaffold(
        drawer: (onSelectMode)
            ? null
            : Drawer(
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
        appBar: (onSelectMode) ? selectModeAppBar(todos) : defaultAppBar(),
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
                    isSelected: (selected.contains(todoList[index].id)),
                    onTap: () {
                      if (onSelectMode) {
                        if (selected.contains(todoList[index].id)) {
                          selected.removeWhere((e) => e == todoList[index].id);
                        } else {
                          selected.add(todoList[index].id);
                        }
                        updateSelected();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings:
                                  RouteSettings(arguments: todoList[index].id),
                              builder: (context) => AddTodoPage(),
                            ));
                      }
                    },
                    onPress: () {
                      if (!onSelectMode) {
                        setState(() {
                          onSelectMode = true;
                          selected.add(todoList[index].id);
                        });
                      }
                    },
                    todo: todoList[index],
                    onCheckTap: () {
                      todoList[index].toggleIsDone();
                      todos.sortTodoList();
                    }),
              )),
        ));
  }

  AppBar defaultAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "TODO",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.amber,
    );
  }

  AppBar selectModeAppBar(Todos todos) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.amber,
      leading: IconButton(
          onPressed: () {
            setState(() {
              onSelectMode = false;
              selected.clear();
            });
          },
          icon: Icon(Icons.close)),
      title: Text(
        selected.length.toString() + " Selected",
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              await todos.deleteData(selected);
              setState(() {
                onSelectMode = false;
                selected.clear();
              });
            },
            icon: Icon(Icons.delete))
      ],
    );
  }
}
