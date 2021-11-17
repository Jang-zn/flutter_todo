import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';
import 'package:flutter_todo/writeplan.dart';

import 'data/database.dart';
import 'data/util.dart';

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
  List<Todo> todayPlan = [];
  final dbHelper = DatabaseHelper.instance;


  void getTodayTodo() async {
    todayPlan = await dbHelper.getTodoFromDate(Utils.getFormatTime(DateTime.now()));
    setState(() {});
  }

  void getAllTodo() async {
    allTodo = await dbHelper.getAllTodo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          print(DateTime.now());
          Todo todo = await Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => WritePlan(
                  todo: Todo(
                      title: "",
                      category: "",
                      memo: "",
                      done: 0,
                      color: 0,
                      date: Utils.getFormatTime(DateTime.now()))
              )));
          getTodayTodo();
        },
      ),
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "오늘"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기"),
        ],
        currentIndex: _idx,
        onTap: (idx) {
          print(idx);
          if(idx==1){
            getAllTodo();
          }
          setState(() {
            _idx = idx;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    getTodayTodo();
  }

  Widget getPage(){
    if(_idx==0){
      return getMain();
    }else{
      return getHistory();
    }
  }
  Widget getMain(){
    return ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return Container(
                margin:EdgeInsets.only(top:30),
                child: const Text("오늘 할일",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)));
          } else if (idx == 1) {
            List<Todo> undone = todayPlan.where((t) {
              return t.done == 0;
            }).toList();

            return Container(
              padding : EdgeInsets.only(top:10),
              child: Column(
                  children: List.generate(undone.length, (index) {
                    Todo t = undone[index];
                    return InkWell(
                        child: TodoCardWidget(todo: t),
                        onTap: () async {
                          if(t.done==1) {
                            t.done = 0;
                          }else{
                            t.done = 1;
                          }
                          await dbHelper.updateTodo(t);
                          getTodayTodo();
                        },
                        onLongPress: () async {
                          Todo todo = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => WritePlan(todo: t)));
                          getTodayTodo();
                        });
                  })),
            );
          } else if (idx == 2) {
            return Container(
                margin:EdgeInsets.only(top:30),
                child: Text("실천 완료",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)));
          } else {
            List<Todo> done = todayPlan.where((t) {
              return t.done == 1;
            }).toList();

            return Container(
              child: Column(
                  children: List.generate(done.length, (index) {
                    Todo t = done[index];
                    return InkWell(
                        child: TodoCardWidget(todo: t),
                        onTap: () async {
                          if(t.done==1) {
                            t.done = 0;
                          }else{
                            t.done = 1;
                          }
                          await dbHelper.updateTodo(t);
                          getTodayTodo();
                        },
                        onLongPress: () async {
                          Todo todo = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => WritePlan(todo: t)));
                          getTodayTodo();
                        });
                  })),
            );
          }
        },
        itemCount: 4);
  }

  List<Todo> allTodo = [];

  Widget getHistory(){
    return ListView.builder(
        itemBuilder:(ctx, idx) {
          if (idx == 0) {
            return Container(child: Column(children: [
              Text("${Utils.numToDateTime(allTodo[idx].date).month}월 ${Utils.numToDateTime(allTodo[idx].date).day}일", style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TodoCardWidget(todo: allTodo[idx]),
            ]));
          }else{
            if(allTodo[idx].date==allTodo[idx-1].date){
              return TodoCardWidget(todo: allTodo[idx]);
            }else{
              return Container(child: Column(children: [
                Text("${Utils.numToDateTime(allTodo[idx].date).month}월 ${Utils.numToDateTime(allTodo[idx].date).day}일", style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TodoCardWidget(todo: allTodo[idx]),
              ]));
            }
          }
        },
      itemCount:allTodo.length
    );
  }

}

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
              Text("${todo.done==0?'미완료':'완료'}",
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

