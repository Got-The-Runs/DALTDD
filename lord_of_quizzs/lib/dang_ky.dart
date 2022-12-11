// ignore: unnecessary_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:lord_of_quizzs/dang_nhap.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';

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
  CollectionReference thongTin = FirebaseFirestore.instance.collection('thong_tin');
  TextEditingController txtTenNguoiChoi = TextEditingController();
  int tienAo = 0;
  int trangThai = 1;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMatKhau = TextEditingController();
  TextEditingController txtNhapLaiMatKhau = TextEditingController();
  final _auth = FirebaseAuth.instance;
  List<ThongTinObject> thongTinEmail= [];
  bool trungEmail = false;
 // ignore: non_constant_identifier_names
 void _LoadThongTin() async {
    final data = await ThongTinProvider.getEmail();
    thongTinEmail= data;
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _LoadThongTin();
  }
  @override
  Widget build(BuildContext context) {

    Future<void> addUser() async{
      // Call the user's CollectionReference to add a new user
      return thongTin
          .add({
            'email': txtEmail.text,
            'ten_nguoi_choi': txtTenNguoiChoi.text,
            'tien_ao': tienAo,
            'trang_thai': trangThai
          })
          .then((value) => Navigator.pop(context, 'Đăng ký thành công'))
          .catchError(
              (error) => Navigator.pop(context, 'Đăng ký thất bại $error'));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          iconSize: 35,
        ),
      ),
      body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
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
                  child: Image.asset('images/Logo.png',
                      fit: BoxFit.cover, height: 120, width: 120),
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
                    child: TextField(
                      controller: txtTenNguoiChoi,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Tên Người chơi',
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
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: txtEmail,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
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
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: txtMatKhau,
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
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: txtNhapLaiMatKhau,
                    obscureText: true,
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
                      if (txtEmail.text == "" ||
                          txtTenNguoiChoi.text == "" ||
                          txtMatKhau.text == "" ||
                          txtNhapLaiMatKhau.text == "") {
                        final snackBar = SnackBar(
                            content: Text('Chưa điền thông tin tài khoản'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (txtMatKhau.text.length < 6 ||
                          txtMatKhau.text.length > 16) {
                        final snackBar = SnackBar(
                            content: Text(
                                'Mật khẩu phải nhập ít nhất 6 ký tự và không quá 16 ký tự'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (txtNhapLaiMatKhau.text != txtMatKhau.text) {
                        final snackBar = SnackBar(
                            content: Text(
                                'Nhập lại mật khẩu không trùng với mật khẩu'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      else {
                        for(int i =0; i<thongTinEmail.length;i++){
                          if(txtEmail.text == thongTinEmail[i].email){
                              trungEmail=true;
                          }
                        }
                        if(trungEmail==true){
                          final snackBar = SnackBar(
                                  content: Text('Email đã được sử dụng'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              trungEmail=false;
                        }else{
                          try {
                           final newUser = await _auth.createUserWithEmailAndPassword(
                              email: txtEmail.text, password: txtMatKhau.text);
                          if (newUser != null) {
                            addUser();
                              txtTenNguoiChoi.clear();
                              txtEmail.clear();
                              txtMatKhau.clear();
                              txtNhapLaiMatKhau.clear();
                              return;                  
                          } 
                        } catch (e) {
                          final snackBar =
                              SnackBar(content: Text('Email đã tồn tại'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        }
                        
                      }
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Đăng ký',
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
            )),
        ),
    );
  }
}
