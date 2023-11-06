import 'package:flutter/material.dart';

import 'model.dart';

class Items extends StatelessWidget {
  Items(
      {super.key,
      required this.todo,
      required this.onChanged,
      required this.onDelete});
  final Model todo;
  final onChanged;
  final onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          onChanged(todo);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          todo.isComplete == true
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank,
          color: Colors.white,
        ),
        title: Text(
          todo.text!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              decoration: todo.isComplete == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
              onPressed: () {
                onDelete(todo.id);
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.white,
                size: 16,
              )),
        ),
      ),
    );
  }
}
