import 'package:flutter/material.dart';
import 'package:project_1/A000124App.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: A000124App(),
      debugShowCheckedModeBanner: false,
    );
  }
}

