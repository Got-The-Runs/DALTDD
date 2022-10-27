import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DangKi extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DangKiState();
  }
}

class DangKiState extends State<DangKi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(95, 240, 98, 42),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text('ĐĂNG KÝ',style: TextStyle(fontSize: 30, 
              color: Color.fromARGB(195, 252, 251, 250),
              fontWeight: FontWeight.bold ),
              ),
            ),
            Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(                  
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Tên đăng nhập',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),            
                  ),
                  prefixIcon:const Icon(Icons.person,color: Colors.black),
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child:  TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon:const Icon(Icons.email,color: Colors.black),
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Mật khẩu',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon:const Icon(Icons.password,color: Colors.black),
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child:  TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Nhập lại mật khẩu',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon:const Icon(Icons.password,color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: 200,
            height: 80,
            child: ElevatedButton(
                onPressed: (){},
                child: const Text('Đăng ký', 
                style: TextStyle(fontSize: 20),
                ), 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(188, 51, 129, 247)), 
                ),  
              ),
            ),
          ],    
        )
      );
  }
}
