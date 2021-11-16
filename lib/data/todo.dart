
class Todo{
  String title;
  String memo;
  String category;
  int color;
  int done;
  int date; // 날짜비교를 위해서 int 사용..??

  Todo(
      {
        required this.title, required this.memo, required this.category, required this.color, required this.done, required this.date
      }
      );

}