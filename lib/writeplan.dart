
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';

class WritePlan extends StatefulWidget {
  WritePlan({Key? key, required this.todo}) : super(key: key);
  Todo todo;


  @override
  _WritePlanState createState() => _WritePlanState();
}

class _WritePlanState extends State<WritePlan> {
  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();
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
              margin:EdgeInsets.only(left:25, right:25, top:20),
            child:Text("제목", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
          );
        } else if(idx==1){
          return Container(
            margin:EdgeInsets.only(left:25, right:25, bottom:10),
            child: TextField(
              controller: titleController,
            )
          );
        } else if(idx==2){
          return InkWell(child:Container(
              margin:EdgeInsets.symmetric(vertical:10, horizontal: 25),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children:[
                Text("색상", style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Container(
                    color:Color(widget.todo.color==0?Colors.grey.value:widget.todo.color),
                    width:15,
                    height:15,
                  margin:EdgeInsets.only(right:20)
                )
              ]
            )
          ),
          onTap: (){
            List<Color> colors = [
              Color(0xff80d3f4),
              Color(0xffa794fa),
              Color(0xfffb91d1),
              Color(0xfffb8a94),
              Color(0xfffebd9a),
              Color(0xff51e29d),
              Color(0xffffffff),
            ];


          },
          );
        } else if(idx==3){
          return Container(
              margin:EdgeInsets.symmetric(vertical:10, horizontal: 25),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text("카테고리",style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text(widget.todo.category),
              ]
            )
          );
        } else if(idx==4){
          return Container(
            margin:EdgeInsets.only(left:25, right:25, top:20, bottom:10),
            child:Text("내용",style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          );
        } else if(idx==5){
          return Container(
              margin:EdgeInsets.only(left:25, right:25, bottom:10),
            child: TextField(
              controller:memoController,
              maxLines: 10,
              minLines: 10,
              decoration: InputDecoration(
                border:OutlineInputBorder(borderSide:BorderSide(color:Colors.black))
              ),
            )
          );
        }
        return Container();
    }),

    );
  }
}
