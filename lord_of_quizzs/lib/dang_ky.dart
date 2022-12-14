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
          .then((value) => Navigator.pop(context, '????ng k?? th??nh c??ng'))
          .catchError(
              (error) => Navigator.pop(context, '????ng k?? th???t b???i $error'));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('????ng K??',
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
                  'B???n ch??a c?? t??i kho???n?',
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
                      labelText: 'T??n Ng?????i ch??i',
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
                      labelText: 'M???t kh???u',
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
                    labelText: 'Nh???p l???i m???t kh???u',
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
                  onPressed: ()  {
                    //Ki???m tra ch??a nh???p t???t c???
                    if (txtEmail.text == "" &&
                        txtTenNguoiChoi.text == "" &&
                        txtMatKhau.text == "" &&
                        txtNhapLaiMatKhau.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui l??ng nh???p th??ng tin t??i kho???n!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    //Ki???m tra t??n ng?????i ch??i
                    if (txtTenNguoiChoi.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui l??ng nh???p t??n ng?????i ch??i!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if ((txtTenNguoiChoi.text.substring(0, 1) == " ")) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'T??n ng?????i ch??i c?? kho???ng tr???ng ??? ?????u\nVui l??ng nh???p l???i t??n ng?????i ch??i'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtTenNguoiChoi.text.length < 2 ||
                        txtTenNguoiChoi.text.length > 16) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'T??n ng?????i ch??i t???i thi???u 2 k?? t??? v?? t???i ??a 16 k?? t???!\nVui l??ng nh???p l???i t??n ng?????i ch??i!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    //Ki???m tra Email
                    if (txtEmail.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui l??ng nh???p Email!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if ((txtEmail.text.contains(' ') && (txtEmail.text.indexOf("@gmail.com") == - 1) || txtEmail.text.contains(' '))) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Email c?? kho???ng tr???ng\nVui l??ng nh???p l???i Email!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if ((txtEmail.text.indexOf("@gmail.com") == -1)) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Email ch??a ????ng ?????nh d???ng, vui l??ng nh???p l???i Email!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    //Ki???m tra m???t kh???u
                    if (txtMatKhau.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui l??ng nh???p m???t kh???u!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtMatKhau.text.contains(' ')) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'M???t kh???u c?? kho???ng tr???ng\nVui l??ng nh???p m???t kh???u!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtMatKhau.text.length < 6 ||
                        txtMatKhau.text.length > 16) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'M???t kh???u t???i thi???u 6 k?? t??? v?? t???i ??a 16 k?? t???\nVui l??ng nh???p l???i m???t kh???u!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    //Ki???m tra nh???p l???i m???t kh???u
                    if (txtNhapLaiMatKhau.text == "") {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Vui l??ng nh???p nh???p l???i m???t kh???u!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if (txtNhapLaiMatKhau.text != txtMatKhau.text) {
                      final snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Nh???p l???i m???t kh???u kh??ng tr??ng v???i m???t kh???u'));
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
                                  'T??n ng?????i ch??i ??? gi???a t???i thi???u 1 kho???ng tr???ng\nVui l??ng nh???p l???i t??n ng?????i ch??i!'));
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
                              content: Text('Email ???? ???????c s??? d???ng'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          trungEmail = false;
                        }
                        if (trungTenNguoiChoi == true) {
                          final snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('T??n ng?????i ch??i ???? ???????c s??? d???ng'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          trungTenNguoiChoi = false;
                        }
                      } else {
                        try {
                          final newUser =
                               _auth.createUserWithEmailAndPassword(
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
                              content: Text('????ng k?? th???t b???i!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                      }
                    }
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    '????ng k??',
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
