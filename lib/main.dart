import 'package:flutter/material.dart';
import 'package:todos/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Sans-serif-light"
      ),
      debugShowCheckedModeBanner: false,
      home:  Splashscreen());
  }
}
