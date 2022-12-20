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
  CollectionReference thongTin =
      FirebaseFirestore.instance.collection('thong_tin');
  TextEditingController txtTenNguoiChoi = TextEditingController();
  int tienAo = 0;
  int trangThai = 1;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMatKhau = TextEditingController();
  TextEditingController txtNhapLaiMatKhau = TextEditingController();
  final _auth = FirebaseAuth.instance;
  List<ThongTinObject> thongTinEmail = [];
  bool trungEmail = false;
  bool trungTenNguoiChoi = false;
  bool _obscureText = true;
  bool _obscureText_accuracy = true;
  // ignore: non_constant_identifier_names
  void _LoadThongTin() async {
    final data = await ThongTinProvider.getEmail();
    thongTinEmail = data;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle_accuracy() {
    setState(() {
      _obscureText_accuracy = !_obscureText_accuracy;
    });
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
    Future<void> addUser() async {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Đăng Ký',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        // elevation: 0,
        // backgroundColor: Colors.transparent,
        flexibleSpace: Container(
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
      body: Stack(
        children: [
          Container(
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
          ),
          SingleChildScrollView(
              // physics:const NeverScrollableScrollPhysics(),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset('images/Logo.png',
                    fit: BoxFit.cover, height: 110, width: 110),
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
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
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
                    obscureText: _obscureText,
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
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white),
                        onPressed: _toggle,
                      ),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: txtNhapLaiMatKhau,
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
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
                  onPressed: () async {
                    //Kiểm tra chưa nhập tất cả
                    if (txtEmail.text == "" &&
                        txtTenNguoiChoi.text == "" &&
                        txtMatKhau.text == "" &&
                        txtNhapLaiMatKhau.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui lòng nhập thông tin tài khoản!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    //Kiểm tra tên người chơi
                    if (txtTenNguoiChoi.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui lòng nhập tên người chơi!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if ((txtTenNguoiChoi.text.substring(0, 1) == " ")) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Tên người chơi có khoảng trắng ở đầu\nVui lòng nhập lại tên người chơi'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtTenNguoiChoi.text.length < 2 ||
                        txtTenNguoiChoi.text.length > 16) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Tên người chơi tối thiểu 2 ký tự và tối đa 16 ký tự!\nVui lòng nhập lại tên người chơi!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    //Kiểm tra Email
                    if (txtEmail.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui lòng nhập Email!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if ((txtEmail.text.contains(' ') &&
                                    (txtEmail.text.indexOf("@gmail.com") ==
                                        1) ||
                                txtEmail.text.contains(' ')) &&
                            (txtEmail.text.indexOf("@caothang.edu.vn") == 1) ||
                        txtEmail.text.contains(' ')) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Email có khoảng trắng\nVui lòng nhập lại Email!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if ((txtEmail.text.indexOf("@gmail.com") == 1) ||
                        (txtEmail.text.indexOf("@caothang.edu.vn") == 1)) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Email chưa đúng định dạng, vui lòng nhập lại Email!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    //Kiểm tra mật khẩu
                    if (txtMatKhau.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui lòng nhập mật khẩu!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtMatKhau.text.contains(' ')) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Mật khẩu có khoảng trắng\nVui lòng nhập mật khẩu!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtMatKhau.text.length < 6 ||
                        txtMatKhau.text.length > 16) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Mật khẩu tối thiểu 6 ký tự và tối đa 16 ký tự\nVui lòng nhập lại mật khẩu!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    //Kiểm tra nhập lại mật khẩu
                    if (txtNhapLaiMatKhau.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui lòng nhập nhập lại mật khẩu!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtNhapLaiMatKhau.text != txtMatKhau.text) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Nhập lại mật khẩu không trùng với mật khẩu'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    } else {
                      for (int i = 0;
                          i < (txtTenNguoiChoi.text.length - 1);
                          i++) {
                        if (txtTenNguoiChoi.text.substring(i, i + 2) == "  ") {
                          final snackBar = SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(
                                  'Tên người chơi ở giữa tối thiểu 1 khoảng trắng\nVui lòng nhập lại tên người chơi!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                      }
                      for (int i = 0; i < thongTinEmail.length; i++) {
                        if (txtEmail.text == thongTinEmail[i].email) {
                          trungEmail = true;
                        }
                        if (txtTenNguoiChoi.text == thongTinEmail[i].name) {
                          trungTenNguoiChoi = true;
                        }
                      }
                      if (trungEmail == true || trungTenNguoiChoi == true) {
                        if (trungEmail == true) {
                          final snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Email đã được sử dụng'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          trungEmail = false;
                        }
                        if (trungTenNguoiChoi == true) {
                          final snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Tên người chơi đã được sử dụng'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          trungTenNguoiChoi = false;
                        }
                      } else {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: txtEmail.text,
                                  password: txtMatKhau.text);
                          if (newUser != null) {
                            addUser();
                            FirebaseAuth.instance.signOut();
                            txtTenNguoiChoi.clear();
                            txtEmail.clear();
                            txtMatKhau.clear();
                            txtNhapLaiMatKhau.clear();
                            return;
                          }
                        } catch (e) {
                          final snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Đăng ký thất bại!'));
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
        ],
      ),
    );
  }
}
