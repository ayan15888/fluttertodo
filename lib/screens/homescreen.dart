import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todos/api_services/api_service.dart';
import 'package:todos/constants/appcolor.dart';
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
    inCompleteTodo?.clear();
    completeTodo?.clear();
    try {
      var value = await ApiService().getAllTodos();
      getAllTodosModel = value;
      for (var todo in value.items!) {
        if (todo.isCompleted == true) {
          completeTodo?.add(todo);
        } else {
          inCompleteTodo?.add(todo);
        }
      }
    } catch (error) {
      debugPrint("Error: $error");
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.purple[150],
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'TodoList',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Appcolor.appbarcolor,
          bottom: const TabBar(
            indicatorColor: Colors.deepPurpleAccent,
            labelPadding: EdgeInsets.symmetric(vertical: 7),
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 77, 20, 235),
            ),
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
        body: isloading
            ? _buildShimmerUI()
            : TabBarView(
                children: [
                  Todoscreen(todoList: getAllTodosModel.items ?? []),
                  Todoscreen(todoList: inCompleteTodo ?? []),
                  Todoscreen(todoList: completeTodo ?? []),
                ],
              ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          onPressed: () async {
            bool? isTaskAdded = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addtaskscreen()),
            );
            if (isTaskAdded == true) {
              getAllTodo();
            }
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

  Widget _buildShimmerUI() {
    return ListView.builder(
      itemCount: 12,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 14,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
