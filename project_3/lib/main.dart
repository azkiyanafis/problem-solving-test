import 'package:flutter/material.dart';
import 'package:project_3/highestpalindrome.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Highestpalindrome(),
      debugShowCheckedModeBanner: false,
    );
  }
}