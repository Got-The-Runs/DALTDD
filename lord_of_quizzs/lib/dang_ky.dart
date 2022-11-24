// ignore: unnecessary_import
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:lord_of_quizzs/dang_nhap.dart';

class DangKi extends StatefulWidget {
  const DangKi({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return DangKiState();
  }
}

class DangKiState extends State<DangKi> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference thongTin = FirebaseFirestore.instance.collection('thong_tin');
  TextEditingController txtTenTaiKhoan = TextEditingController();
  int tienAo =0;
  int trangThai = 1;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMatKhau = TextEditingController();
  TextEditingController txtNhapLaiMatKhau = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> listThongTin = FirebaseFirestore.instance.collection('thong_tin');

  @override
  Widget build(BuildContext context) {
    // Future<int> countUsers() async {
    //   AggregateQuerySnapshot query = await listThongTin.count().get();
    //   int id = query.count;
    //   return id ;
    // }
     Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return thongTin 
          .add({
            'id': 3 ,
            'email': txtEmail.text, 
            'mat_khau': txtMatKhau.text, 
            'ten_nguoi_choi': txtTenTaiKhoan.text,
            'ten_tai_khoan': txtTenTaiKhoan.text,
            'tien_ao': tienAo,
            'trang_thai': trangThai
          })
          .then((value) => Navigator.pop(context, 'Đăng ký thành công'))
          .catchError((error) => Navigator.pop(context, 'Đăng ký thất bại $error'));        
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent, 
          elevation: 0, 
          leading: IconButton(
           icon:const Icon(Icons.chevron_left),
           onPressed: () => Navigator.pop(context),
           iconSize: 35,  
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF701ebd),
              Color.fromARGB(255, 57, 86, 250),
              // Color(0xFF701ebd),
              // Color(0xFF873bcc),
              // Color(0xFFfe4a97),
              // Color(0xFFe17763),
              // Color(0xFF68998c),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            ),
          ),  
         child: SingleChildScrollView(
            // physics:const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [       
              Container(
                padding: const EdgeInsets.only(top: 60),
                child: Image.asset(
                  'images/Logo.png',
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120
                ),
              ),  
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Text(
                  'Bạn chưa có tài khoản?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtTenTaiKhoan,
                  style:const TextStyle(color: Colors.white),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Tên tài khoản trống';
                    }
                    return null;
                  },
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
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtEmail,
                  style:const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email trống';
                    }
                    return null;
                  },
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
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtMatKhau,
                  obscureText: true,
                  style:const TextStyle(color: Colors.white),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Mật khẩu trống';
                    }
                    return null;
                  },
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
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller:  txtNhapLaiMatKhau,
                  obscureText: true,
                  style:const TextStyle(color: Colors.white),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Nhập lại mật khẩu trống';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
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
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: 200,
                height: 80,
                child: OutlinedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try{
                        final newUser = _auth.createUserWithEmailAndPassword(
                          email: txtEmail.text, password: txtMatKhau.text);                          
                          if(newUser != null){                 
                            Navigator.pop(context, 'Đăng ký thành công');
                            addUser();
                          }else {
                            final snackBar = SnackBar(content: Text('Tài khoản này không hợp lệ'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                      }
                      catch(e){
                        final snackBar = SnackBar(content: Text('Có lỗi xảy ra !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }                       
                    }                                     
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 20, 
                    color: Colors.white),
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
                    ),
                  ),
                ),
              ],
            )
          ),
        )  
      ),
    );
  }
}

