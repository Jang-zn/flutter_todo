import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';

class WritePlan extends StatefulWidget {
  WritePlan({Key? key, required this.todo}) : super(key: key);
  Todo todo;


  @override
  _WritePlanState createState() => _WritePlanState();
}

class _WritePlanState extends State<WritePlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child:Text("저장"),
            onPressed: (){

            },
          ),

        ],
      ),
    );
  }
}
