import 'package:flutter/material.dart';
import 'package:flutter_todo/data/todo.dart';
import 'package:flutter_todo/writeplan.dart';


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
  List<Todo> todayPlan = [
    Todo(
      title : "출근1",
      memo : "개발1",
      category : "일",
      color : Colors.red.value,
      done : 1,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          print(DateTime.now());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx)=>WritePlan(todo: Todo(
                title : "",
                category:"",
                memo:"",
                done:0,
                color:0,
                date:Utils.getFormatTime(DateTime.now())
              ))
            )
          );
        },
      ),
      body: ListView.builder(itemBuilder: (ctx, idx) {
            if(idx==0){
              return Container(child : Text("오늘 할일", style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
            }else if(idx==1){

              List<Todo> undone = todayPlan.where((t){
                return t.done==0;
              }).toList();

              return Container(
                margin : EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child:Column(
                  children : List.generate(undone.length, (index){
                    Todo t = undone[index];
                    return Container(
                      decoration: BoxDecoration(
                        color : Color(t.color),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding : EdgeInsets.symmetric(horizontal:5, vertical:5),
                      margin : EdgeInsets.symmetric(vertical: 3),
                      child : Row(
                        children:[
                          Column(children:[
                            Text(t.title, style:TextStyle(fontSize : 17, fontWeight: FontWeight.bold, color: Colors.white)),
                            Text(t.memo,style:TextStyle(fontSize : 13, fontWeight: FontWeight.bold, color: Colors.white)),
                          ]),
                          Column(children : [
                            Text("미완료",style:TextStyle(fontSize : 17, fontWeight: FontWeight.bold, color: Colors.white))
                          ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                    );
                  })
                ),
              );
            }
            else if(idx==2){
              return Container(child : Text("실천 완료", style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
            }else if(idx==3){

              List<Todo> done = todayPlan.where((t){
                return t.done==1;
              }).toList();

              return Container(
                margin : EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child:Column(
                    children : List.generate(done.length, (index){
                      Todo t = done[index];
                      return Container(
                        decoration: BoxDecoration(
                          color : Color(t.color),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding : EdgeInsets.symmetric(horizontal:5, vertical:5),
                        margin : EdgeInsets.symmetric(vertical: 3),
                        child : Row(
                          children:[
                            Column(children:[
                              Text(t.title, style:TextStyle(fontSize : 17, fontWeight: FontWeight.bold, color: Colors.white)),
                              Text(t.memo,style:TextStyle(fontSize : 13, fontWeight: FontWeight.bold, color: Colors.white)),
                            ]),
                            Column(children : [
                              Text("완료",style:TextStyle(fontSize : 17, fontWeight: FontWeight.bold, color: Colors.white))
                            ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                      );
                    })
                ),
              );
            }
            return Container();
          },
          itemCount : 4
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
