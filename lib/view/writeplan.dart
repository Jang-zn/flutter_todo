import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';


class WritePlan extends StatefulWidget {
  Todo todo;

  WritePlan({Key? key, required this.todo}) : super(key: key);
  @override
  _WritePlanState createState() => _WritePlanState();
}

class _WritePlanState extends State<WritePlan> {
  TextEditingController nameCotroller = TextEditingController();
  TextEditingController memoCotroller = TextEditingController();

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
        }else if(idx==3){
          return Container(child : Row(
            children:[
             Text("카테고리"),
             Text(widget.todo.category),
            ]
          ));
        }else if(idx==4){
          return Container(
            child : Text("메모")
          );
        }else if(idx==5){
          return Container(
            child : TextField(
              controller : memoCotroller,
              maxLines:10,
              minLines:10,
              decoration: InputDecoration(
                border : OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.black)
                )
              ),
            )
          );
        }
        return Container();
      })
    );
  }
}
