import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/dang_ky.dart';
import 'package:lord_of_quizzs/quen_mat_khau.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/nen_1.jpg"),
              fit: BoxFit.cover
            ),  
          ),
          child: QuenMatKhau(),
        ),
      )
    );   
  }
}
