import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todos/api_services/api_service.dart';
import 'package:todos/screens/donescreen.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});

  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isComplete = false;
  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check),
      WidgetState.any: Icon(Icons.close),
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: const Color.fromARGB(255, 195, 145, 255),
      ),
      body: Padding(
        // Padding widget
        padding: const EdgeInsets.all(18.0),
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
                    color: Colors.deepPurple),
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                hintText: "Add a task",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a task";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Add Description",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Add a description",
                hintStyle: TextStyle(color: Colors.grey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a description";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 1,

            ),
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
                        fontSize: 20),
                  ),
                ),
                Switch(
                  thumbIcon: thumbIcon,
                  activeTrackColor: const Color.fromARGB(255, 20, 121, 23),
                  inactiveThumbColor: Colors.red,
                  value: isComplete,
                  onChanged: (bool value) {
                    setState(() {
                      isComplete = value;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
         floatingActionButton: FloatingActionButton.extended(
         
    
            
            backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.black, width: 1)),
          onPressed: (
            
          ) {
          ApiService().addTodo(taskController.text, descriptionController.text, isComplete);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Donescreen()));
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
