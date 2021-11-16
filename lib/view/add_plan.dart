import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';


class Add_Plan extends StatefulWidget {
  final Todo todo;

  Add_Plan({Key? key, required this.todo}) : super(key: key);
  @override
  _Add_PlanState createState() => _Add_PlanState();
}

class _Add_PlanState extends State<Add_Plan> {
  TextEditingController nameCotroller = TextEditingController();

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
      body : ListView.builder(itemBuilder: (ctx, idx){
        if(idx==0){
          return Container(child : Text("제목", style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
        }else if(idx==1){
          return Container(
            child : TextField(
              controller : nameCotroller,
            )
          );
        }else if(idx==2){
          return Container(
            child : Row(
              children:[
                Text("색상"),
                Container(
                  width:10, height:10,color:Color(widget.todo.color),
                )
              ]
            )
          );
        }
        return Container();
      })
    );
  }
}
