import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do App",
      theme: ThemeData.light(),
      home: ToDoMain(title: "To-Do App"),
    );
  }
}

class ToDoMain extends StatefulWidget {
  const ToDoMain({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ToDoMainState createState() => _ToDoMainState();
}

class _ToDoMainState extends State<ToDoMain> {
  int _idx = 0;
  List<ListTile> todayPlan = [];
  List<ListTile> completePlan = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child : AppBar(
      ), preferredSize: Size.fromHeight(0),),
      body: ListView(
        padding : EdgeInsets.all(30),
        children : <Widget>[
          Text("오늘 할일",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ListTile(tileColor: Colors.red,),
          Container(height:40),
          Text("완료한 일",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(height:30),
        ]
      )
      ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //TODO : 계획 작성 페이지로 이동
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "오늘"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기"),
        ],
        onTap: (idx) {
          print(idx);
          setState(() {
            _idx = idx;
          });
        },
        currentIndex: _idx,
      ),
    );
  }
}
