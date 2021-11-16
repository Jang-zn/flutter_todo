import 'dart:ui';

import 'package:flutter/material.dart';

import 'data/todo.dart';

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
  List<Todo> todayPlan = [
    Todo(
      title : "출근1",
      memo : "개발1",
      category : "일",
      color : Colors.red.value,
      done : 0,
      date : 20211116,
    ),
    Todo(
        title : "출근2",
        memo : "개발2",
        category : "일",
        color : Colors.blue.value,
        done : 0,
        date : 20211116,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      body: ListView.builder(itemBuilder: (ctx, idx) {
            if(idx==0){
              return Container(child : Text("오늘 할일", style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
            }else if(idx==1){
              return Container(
                margin : EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child:Column(
                  children : List.generate(todayPlan.length, (index){
                    Todo t = todayPlan[index];
                    return Container(
                      margin : EdgeInsets.symmetric(vertical: 3),
                      child : Row(
                        children:[
                          Column(children:[
                            Text(t.title),
                            Text(t.memo),
                          ]),
                          Column(children : [
                            Text("${t.done==1?'완료':'미완료'}")
                          ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      color : Color(t.color),
                    );
                  })
                ),
              );
            }
            return Container();
          },
          itemCount : 4
      ),
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
