import 'package:first_app/model/color.dart';
import 'package:flutter/material.dart';
import '../model/toDo.dart';

class TodoItem extends StatelessWidget{
  final ToDo todo;
  final onTodoChanged;
  final onDeleteItems;
  const TodoItem({Key? key,
    required this.todo,
    required this.onTodoChanged,
    required this.onDeleteItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: ListTile(
             onTap: (){
               onTodoChanged(todo);
             },
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                  ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.white,
            leading:  Icon(
                todo.isDelete? Icons.check_box : Icons.check_box_outline_blank,
                color: tdBlue,),
            title: Text(todo.todoText!, style:  TextStyle(fontSize: 16, color: tdBlack,
            decoration: (todo.isDelete)? TextDecoration.lineThrough : null),),
            trailing: Container(
              padding:const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: tdRed,
                  borderRadius:  BorderRadius.circular(5)),
              child: IconButton(
                  color: Colors.white,
                  iconSize: 18,
                icon: const Icon(Icons.delete),
                  onPressed: (){
                    onDeleteItems(todo.id);
                  },
              ),
            ),
          )
    );
  }
}
