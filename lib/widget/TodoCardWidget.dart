import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(todo.color),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: [
          Column(children: [
            Text(todo.title,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(todo.memo,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ]),
          Column(
            children: [
              Text("${todo.done == 0 ? '미완료' : '완료'}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
