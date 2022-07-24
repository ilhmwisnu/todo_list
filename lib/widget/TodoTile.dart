import 'package:flutter/material.dart';

import '../provider/todo.dart';

class TodoTile extends StatefulWidget {
  TodoTile(
      {Key? key,
      required this.todo,
      required this.isSelected,
      required this.onCheckTap,
      required this.onTap,
      required this.onPress})
      : super(key: key);

  Todo todo;
  void Function() onCheckTap;
  void Function() onTap;
  void Function() onPress;
  bool isSelected;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onPress,
      child: Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: (widget.isSelected)
                      ? Colors.amber
                      : Colors.grey.shade200),
              color: (!widget.isSelected) ? Colors.white : Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo.task,
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            (widget.todo.isDone) ? Colors.grey : Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: (widget.todo.isDone)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    Text(
                      widget.todo.desc,
                      style: TextStyle(
                        color:
                            (widget.todo.isDone) ? Colors.grey : Colors.black,
                        decoration: (widget.todo.isDone)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: widget.onCheckTap,
                child: Container(
                  width: 24,
                  height: 24,
                  child: (widget.todo.isDone)
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
          )),
    );
  }
}
