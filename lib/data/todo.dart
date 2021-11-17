
class Todo{
  int? id;
  String title;
  String memo;
  String category;
  int color;
  int done;
  int date; // 날짜비교를 위해서 int 사용..??

  Todo(
      {
        this.id, required this.title, required this.memo, required this.category, required this.color, required this.done, required this.date
      }
      );

  Map<String, dynamic> getMap(){
    Map<String, dynamic> map={
      "id":this.id,
      "title":this.title,
      "memo":this.memo,
      "category":this.category,
      "color":this.color,
      "done":this.done,
      "date":this.date
    };
    return map;
  }

}