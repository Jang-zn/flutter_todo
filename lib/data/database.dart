import 'package:flutter_todo/data/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databaseName = "todo.db";
  static final _databaseVersion = 1;
  static final todoTable = "todo";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async{
    if(_database !=null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version:_databaseVersion, onCreate:_onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $todoTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER DEFAULT 0,
      title String,
      memo String, 
      color INTEGER,
      category String
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  //CRUD
  Future<int> insertTodo(Todo todo) async {
    Database? db = await instance.database;
    if(todo.id==null){
      Map<String, dynamic> row = {
        "title" : todo.title,
        "date" : todo.date,
        "memo" : todo.memo,
        "color" : todo.color,
        "category" : todo.category,
      };
      return await db!.insert(todoTable, row);
    }else{
      Map<String, dynamic> row = {
        "title" : todo.title,
        "date" : todo.date,
        "memo" : todo.memo,
        "color" : todo.color,
        "category" : todo.category,
        "done" : todo.done
      };
      return await db!.update(todoTable, row, where: "id=?", whereArgs: [todo.id]);
    }
  }

  Future<List<Todo>> getAllTodo() async {
    Database? db = await instance.database;
    List<Todo> list = [];

    var queries = await db!.query(todoTable);
    for(var q in queries){
      list.add(Todo(id : q["id"],
        title : q["title"],
        color : q["color"],
        memo : q["memo"],
        category: q["category"],
        date : q["date"],
        done : q["done"]
      ));
    }
    return list;
  }

  Future<List<Todo>> getTodoFromDate(int date) async {
    Database? db = await instance.database;
    List<Todo> list = [];

    var queries = await db!.query(todoTable, where: "date=?", whereArgs: [date]);
    for(var q in queries){
      list.add(Todo(id : q["id"],
          title : q["title"],
          color : q["color"],
          memo : q["memo"],
          category: q["category"],
          date : q["date"],
          done : q["done"]
      ));
    }
    return list;
  }
}