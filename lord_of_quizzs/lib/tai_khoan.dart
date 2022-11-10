import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/chon_linh_vuc.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';

class ManHinhTaiKhoan extends StatefulWidget {
  const ManHinhTaiKhoan({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return ManHinhTaiKhoanState();
  }
}

class ManHinhTaiKhoanState extends State<ManHinhTaiKhoan> {
  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Container(
                height: 110,
                width: 110,
                child: CircleAvatar(
                  child: Image.asset('images/Logo.png',
                    fit: BoxFit.cover, height: 120, width: 120),
                ),
              ),
               Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Đổi ảnh đại diện',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ), 
           Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Tên người chơi',
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
                  prefixIcon: const Icon(Icons.man, color: Colors.white),
                ),
              )
            ),
              Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                style:const TextStyle(color: Colors.white),
                enabled: false,
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
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
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
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
              )
            ),
            
               Container(
              padding: const EdgeInsets.all(15),
              width: 200,
              height: 80,
              child: OutlinedButton(
                onPressed: () {},
              // ignore: sort_child_properties_last
              child: const Text(
                'Cập nhật',
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
        ],
          ),
        ),
    );
  }
}
