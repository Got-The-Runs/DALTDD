// ignore: unused_import
import 'dart:ffi';
// ignore: unnecessary_import
import 'dart:ui';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuenMatKhau extends StatefulWidget{
  const QuenMatKhau({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return QuenMatKhauState();
  }
}

class QuenMatKhauState extends State<QuenMatKhau> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text('QUÊN MẬT KHẨU',style: TextStyle(fontSize: 30, 
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
                labelText: 'Mật khẩu mới',
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
                // ignore: sort_child_properties_last
                child: const Text('Xác nhận', 
                style: TextStyle(fontSize: 20),
                ), 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(188, 51, 129, 247)), 
                ),  
              ),
            ),
          ],    
        ),
      ),
    );
  }
}
