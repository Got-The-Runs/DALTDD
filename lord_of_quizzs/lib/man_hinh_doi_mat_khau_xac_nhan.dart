// ignore: unnecessary_import
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/dang_ky.dart';
import 'package:lord_of_quizzs/man_hinh_chinh.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';
import 'package:lord_of_quizzs/quen_mat_khau.dart';

class DangNhapXN extends StatefulWidget {
  String email;
  DangNhapXN({Key? key, required this.email}) : super(key: key);
  

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return DangNhapXNState(email: email);
  }
}

class DangNhapXNState extends State<DangNhapXN> {
  String email;
  DangNhapXNState({Key? key, required this.email});
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  
  final _auth = FirebaseAuth.instance;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset('images/Logo.png',
                    fit: BoxFit.cover, height: 120, width: 120),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'ĐỔI MẬT KHẨU',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: txtPass,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                width: 200,
                height: 80,
                child: OutlinedButton(
                    onPressed: () async {
                      // try {
                      //   if(_xt?.email == txtEmail.text)
                      //   {
                      //     final _user = await _auth.signInWithEmailAndPassword(
                      //       email: txtEmail.text, password: txtPass.text);
                      //   }
                      //   await _auth.authStateChanges().listen((event) {
                      //     if (event != null) {
                      //       txtEmail.clear();
                      //       txtPass.clear();
                      //       MaterialPageRoute(
                      //       builder: (context) => const DoiMatKhau(),
                      //      );
                      //     }
                      //   });
                      // } catch (e) {                       
                      //     final snackBar = SnackBar(
                      //         content: Text('Email hoặc mật khẩu không đúng'));
                      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // }
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
