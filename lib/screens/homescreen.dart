import 'package:flutter/material.dart';
import 'package:todos/api_services/api_service.dart';
import 'package:todos/models/get_all_todos.dart';
import 'package:todos/screens/addtaskscreen.dart';
import 'package:todos/screens/todoscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  GetAllTodosModel getAllTodosModel = GetAllTodosModel();
  List<Items>? inCompleteTodo = [];
  List<Items>? completeTodo = [];
  bool isloading = false;
  getAllTodo() async {
    setState(() {
      isloading = true;
    });
    await ApiService().getAllTodos().then((value) {
      getAllTodosModel = value;
      for (var todo in value.items!) {
        if (todo.isCompleted == true) {
          completeTodo!.add(todo);
        }else{
          inCompleteTodo!.add(todo);
          }
          isloading = false;

      setState(() {});
      }

      setState(() {});
    }).onError((error, stackTrace) {
      debugPrint("Error: $error");
    });
  }

  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          centerTitle: true,
          title: const Text('TodoList',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 195, 145, 255),
          bottom: const TabBar(
            indicatorColor: Colors.deepPurpleAccent,
            labelPadding: EdgeInsets.symmetric(vertical: 7),
            labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 20, 235)),
            unselectedLabelColor: Color.fromARGB(255, 243, 226, 246),
            unselectedLabelStyle:
                TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            tabs: [
              Tab(text: "All"),
              Tab(text: "Incomplete"),
              Tab(text: "Complete"),
            ],
          ),
        ),
        body:isloading? Center(child: CircularProgressIndicator.adaptive(),): TabBarView(children: [
          Todoscreen(todoList: getAllTodosModel.items ?? [],),
          Todoscreen(todoList: inCompleteTodo ?? []),
          Todoscreen(todoList: completeTodo ?? []),
        ]),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.deepPurple, width: 2)),
          onPressed: () {
            
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addtaskscreen()));
          },
          label: const Text(
            "Add Task",
            style: TextStyle(color: Colors.deepPurple),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
