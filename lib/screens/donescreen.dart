import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todos/screens/homescreen.dart';

class Donescreen extends StatefulWidget {
  const Donescreen({super.key});

  @override
  State<Donescreen> createState() => _DonescreenState();
}

class _DonescreenState extends State<Donescreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Homescreen()));
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(child: Container(
            height: 400,
            width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(250),
          // color: Colors.white,
          // border: Border.all(color: Color.fromARGB(255, 236, 203, 241),width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
           Lottie.asset('assets/done.json',
             frameRate: FrameRate.max,
                repeat: false,
                width: 300,
                height: 300,
                 fit: BoxFit.fill,),
            
            Text("Task Added",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ],
        ),
      ),),
    );
  }
}