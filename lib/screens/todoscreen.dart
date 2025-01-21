import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todos/models/get_all_todos.dart';

class Todoscreen extends StatelessWidget {
  const Todoscreen({super.key, required this.todoList});
final List<Items> todoList;
  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [   
           Lottie.asset('assets/empty.json',
             frameRate: FrameRate.max,
                repeat: true,
                    width: 400,
                 ),
          Text("Todo Not found",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 152, 21, 175)),),
        ],
      ),
    ) :
    
    ListView.separated(
        itemCount: todoList.length,
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemBuilder: (context, index) {
          final item = todoList[index];
          return Padding(
            padding:
                const EdgeInsets.only(top: 3, left: 15, right: 15,),
            child: Container(
    
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20)),
                  
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.purple, width: 0.6),
                ),
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title!,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19 ),),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 14),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 236, 203, 241),
                                    border: Border.all(
                                        color: Colors.purple, width: 0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                          Text( item.description??"",style: TextStyle(fontSize: 14),)
                          ,Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 14),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 236, 203, 241),
                                border: Border.all(
                                    color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(20)),
                            child:  Text(
                              item.isCompleted  ==true ? "Complete":"Incomplete",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 73, 23, 160)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            
          );
        });
  }
}
