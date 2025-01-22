import 'package:flutter/material.dart';
import 'package:todos/api_services/api_service.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});

  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool is_completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Task", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 195, 145, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Add Task",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                hintText: "Add a task",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Add Description",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: description,
              decoration: InputDecoration(
                hintText: "Add a description",
                hintStyle: TextStyle(color: Colors.grey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "Complete Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 20,
                    ),
                  ),
                ),
                Switch(
                  activeColor: const Color.fromARGB(255, 20, 121, 23),
                  inactiveThumbColor: Colors.red,
                  value: is_completed,
                  onChanged: (bool value) {
                    setState(() {
                      is_completed = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        onPressed: () async {
          try {
            await ApiService().addTodo(
              title.text.toString(),
              description.text.toString(),
              is_completed,
            );
            Navigator.pop(context, true);
          } catch (error) {
            debugPrint("Error adding task: $error");
            ScaffoldMessenger.of(context).showSnackBar(
              
              SnackBar(content: Text('Failed to add task',style: TextStyle(color: Colors.red),)),
            );
          }
        },
        label: const Text(
          "Done",
          style: TextStyle(color: Colors.deepPurple),
        ),
        icon: const Icon(
          Icons.done,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
