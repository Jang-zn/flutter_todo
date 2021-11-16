
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';

class WritePlan extends StatefulWidget {
  WritePlan({Key? key, required this.todo}) : super(key: key);
  Todo todo;


  @override
  _WritePlanState createState() => _WritePlanState();
}

class _WritePlanState extends State<WritePlan> {
  //TextEditingController titleController = TextEditingController();
  //TextEditingController memoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child:Text("저장", style: TextStyle(color: Colors.white),),
            onPressed: (){

            },
          ),
        ],
      ),
      body : ListView.builder(
          itemCount:6,
          itemBuilder: (ctx, idx) {
        if(idx==0){
          return Container(
            child:Text("제목")
          );
        } else if(idx==1){
          return Container(
          );
        }
        return Container();
    }),

    );
  }
}
