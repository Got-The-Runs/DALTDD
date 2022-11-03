// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/dang_ky.dart';
import 'package:lord_of_quizzs/man_hinh_chinh.dart';
import 'package:lord_of_quizzs/quen_mat_khau.dart';

class DangNhap extends StatefulWidget {
  const DangNhap({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return DangNhapState();
  }
}

class DangNhapState extends State<DangNhap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF701ebd),
              Color.fromARGB(255, 57, 86, 250),
          ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),  
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [         
            Container(
              padding: const EdgeInsets.all(17),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'images/Logo.png',
                fit: BoxFit.cover,
                height: 120,
                width: 120

              ),
            ),  
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'ĐĂNG NHẬP',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Tên đăng nhập',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:const BorderSide(
                      color: Colors.white
                    ),                   
                    borderRadius: BorderRadius.circular(25),
                  ),       
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ), 
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                obscureText: true,
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder:  OutlineInputBorder(
                      borderSide:const BorderSide(
                        color: Colors.white
                      ),                   
                      borderRadius: BorderRadius.circular(25),
                    ),       
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ), 
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: 200,
              height: 80,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                    MaterialPageRoute(
                      builder: (context) => const ManHinhChinh(),
                    ),
                  );
                },
              // ignore: sort_child_properties_last
              child: const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 20,
                color: Colors.white 
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),  
                side: MaterialStateProperty.all(                 
                  const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                    style: BorderStyle.solid
                    )
                  )
                )
              ),
            ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuenMatKhau(),
                  ),
                );
              },
              child: const Text(
                'Quên mật khẩu',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DangKi(),
                  ),
                );
              },
              child: const Text(
                'Đăng ký',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}