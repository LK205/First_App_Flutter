class ToDo{
  int? id;
  String? todoText;
  bool isDelete;

  ToDo({required this.id, required this.todoText, this.isDelete = false});

  static List<ToDo> todoList(){
    return [
      ToDo(id: 1,todoText: 'Morning Excercise',isDelete: false),
      ToDo(id: 2,todoText: 'Eat Breakfast',isDelete: true),
      ToDo(id: 3,todoText: 'Check Email',isDelete: false),
      ToDo(id: 4,todoText: 'Team Meating',isDelete: true),
      ToDo(id: 5,todoText: 'Work on mobile app for 2 hour',isDelete: false),
      ToDo(id: 6,todoText: 'Dinner with Thuffy',isDelete: false),
    ];
  }
}