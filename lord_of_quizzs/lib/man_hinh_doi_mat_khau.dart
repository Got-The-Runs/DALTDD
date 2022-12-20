// ignore: unused_import
import 'dart:ffi';
// ignore: unnecessary_import
import 'dart:ui';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lord_of_quizzs/man_hinh_chinh.dart';

class DoiMatKhau extends StatefulWidget {
  String email;
  DoiMatKhau({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return DoiMatKhauState(email: email);
  }
}

class DoiMatKhauState extends State<DoiMatKhau> {
  String email;
  DoiMatKhauState({Key? key, required this.email});
  var txtMatKhauCu = TextEditingController();
  var txtMatKhauMoi = TextEditingController();
  var txtMatKhauXT = TextEditingController();
  bool _obscureText_old = true;
  bool _obscureText_new = true;
  bool _obscureText_accuracy = true;

  void _toggle_old() {
    setState(() {
      _obscureText_old = !_obscureText_old;
    });
  }

  void _toggle_new() {
    setState(() {
      _obscureText_new = !_obscureText_new;
    });
  }

  void _toggle_accuracy() {
    setState(() {
      _obscureText_accuracy = !_obscureText_accuracy;
    });
  }

  final _auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              centerTitle: true,
              title: const Text( 'Đổi Mật Khẩu',
                        style: TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center
                      ),
              // elevation: 0,
              // backgroundColor: Colors.transparent,
               flexibleSpace:  Container(
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
                ),
              leading: IconButton(
              icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context),
                iconSize: 25,  
              ),
            ),
      body:Stack(
      children: [
      Container(
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
      ),
         SingleChildScrollView(
          // physics:const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image.asset('images/Logo.png',
                    fit: BoxFit.cover, height: 120, width: 120),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Text(
                  'Bạn muốn đổi mật khẩu?',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: txtMatKhauMoi,
                    obscureText: _obscureText_new,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu mới',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon:
                          Icon(Icons.password_outlined, color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscureText_new
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white),
                        onPressed: _toggle_new,
                      ),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: txtMatKhauXT,
                  obscureText: _obscureText_accuracy,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon:
                        Icon(Icons.password_outlined, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText_accuracy
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: _toggle_accuracy,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: 200,
                height: 80,
                child: OutlinedButton(
                  onPressed: () {
                    if (txtMatKhauMoi.text == "" || txtMatKhauXT.text == "") {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                          content: Text("Vui lòng nhập mật khẩu mới!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (txtMatKhauMoi.text.contains(' ')) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                          content: Text(
                              "Mật khẩu mới có khoảng trắng\nVui lòng nhập lại!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (txtMatKhauMoi.text.length < 6 ||
                        txtMatKhauMoi.text.length > 16) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                          content: Text(
                              "Mật khẩu mới tối thiểu 6 ký tự và tối đa 16 ký tự\nVui lòng nhập lại mật khẩu"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    if (txtMatKhauXT.text == "") {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                          content: Text("Vui lòng nhập mật khẩu xác thực!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (txtMatKhauMoi.text != txtMatKhauXT.text) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                          content: Text(
                              "Mật khẩu xác thực không trùng khớp với mật khẩu mới\nVui lòng nhập lại mật khẩu xác thực!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final user = _auth?.updatePassword(txtMatKhauMoi.text);
                      final snackBar =
                          SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Đổi mật khẩu thành công"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManHinhChinh(),
                        ),
                      );
                    }
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                          style: BorderStyle.solid))),
                ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }
}
