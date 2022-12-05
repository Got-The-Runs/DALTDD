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
  var showEmail = "";
  bool check = true;
  bool _obscureText_password = true;

  void _toggle_pass() {
    setState(() {
      _obscureText_password = !_obscureText_password;
    });
  }

  _show_email() {
    setState(() {
      if (check == true) {
        for (int i = 0; i < email.length - 11; i++) {
          if (i == 0) {
            showEmail += email.substring(0, 1);
          } else {
            showEmail += "*";
          }
        }
        showEmail += email.substring((email.length - 11), email.length);
      }
      check = false;
    });
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          iconSize: 35,
        ),
      ),
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
                padding: const EdgeInsets.only(top: 70),
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
                      onTap: _show_email,
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: showEmail,
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.white),
                      ))),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: txtPass,
                    obscureText: _obscureText_password,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscureText_password
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white),
                        onPressed: _toggle_pass,
                      ),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                width: 200,
                height: 80,
                child: OutlinedButton(
                    onPressed: () async {
                      if (txtPass.text == "") {
                        final snackBar =
                            SnackBar(content: Text('Chưa nhập mật khẩu'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        try {
                          final _user = await _auth.signInWithEmailAndPassword(
                              email: email, password: txtPass.text);
                          await _auth.authStateChanges().listen((event) {
                            if (event != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoiMatKhau(
                                    email: email,
                                  ),
                                ),
                              );
                            }
                          });
                        } catch (e) {
                          final snackBar =
                              SnackBar(content: Text('Sai mật khẩu'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Xác thực',
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
