
import 'package:first_app/model/color.dart';
import '../model/toDo.dart';
import '../widgets/todo_items.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState(){
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top:50, bottom: 20),
                              child: const Text(
                                'All todo',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            for(ToDo e in _foundToDo)
                              TodoItem(
                                todo: e,
                                onTodoChanged: _handleToDoChange,
                                onDeleteItems: _DeleteById,
                              ),
                            const SizedBox(height: 35)
                          ],
                        ),
                      ),
                ],
              ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow:  const [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0,0.0),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: (){
                      if(_todoController.text != null && _todoController.text != ''){
                        _addTodoItem(_todoController.text);
                        _todoController.text = '';
                      }
                      else return;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize:  Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text('+', style: TextStyle(fontSize: 40),),
                  ) ,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDelete = !todo.isDelete;
    });
  }

  void _DeleteById(int id){
    setState(() {
      todoList.removeWhere((items) => items.id  == id );
    });
  }

  void _addTodoItem(String todo){
    setState(() {
      int a = todoList.last.id! + 1;
      todoList.add(ToDo(id: a, todoText: todo));
    });
  }

  void _runFilter(String keyWords){
    List<ToDo> result = [];
    if(keyWords.isEmpty || keyWords == ''){
      result = todoList;
    } else{
      result = todoList.where( (item) => item.todoText!.toLowerCase()
                       .contains(keyWords.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = result;
    });
  }
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20,),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search here!',
            hintStyle: TextStyle(color: tdGrey)
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         const Icon(Icons.menu, color: tdBlack, size: 30,),
          Container(
            height: 55,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/avatar.jpg'),
            ),
          )
        ],
      )
    );
  }
}
