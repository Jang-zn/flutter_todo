import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';


class Add_Plan extends StatefulWidget {
  final Todo todo;
  Add_Plan({Key? key, required this.todo}) : super(key: key);
  @override
  _Add_PlanState createState() => _Add_PlanState();
}

class _Add_PlanState extends State<Add_Plan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions : [
          TextButton(child:Text("저장", style:TextStyle(color:Colors.white)), onPressed : (){
            //TODO : 페이지 저장로직
          }),

        ]
      ),
    );
  }
}
