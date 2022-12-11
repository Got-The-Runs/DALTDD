// ignore_for_file: sort_child_properties_last

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/thong_tin_provider.dart';

class ManHinhTaiKhoan extends StatefulWidget {
  String email;
  ManHinhTaiKhoan({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ManHinhTaiKhoanState(
      email: email,
    );
  }
}

class ManHinhTaiKhoanState extends State<ManHinhTaiKhoan> {
  String email;
  ManHinhTaiKhoanState({Key? key, required this.email});
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  int temp1 = 0;
  var docID;
  var querySnapshots;
  final _formKey = GlobalKey<FormState>();
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  Future<void> updateUser(var docID) {
    return user
        .doc(docID)
        .update({'ten_nguoi_choi': txtName.text})
        .then((value) => Navigator.pop(context, 'Cập nhật thành công'))
        .catchError(
            (error) => Navigator.pop(context, 'Cập nhật thất bại $error'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThongTinObject>>(
        future: ThongTinProvider.get(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ThongTinObject> thongTin = snapshot.data!;
            email = thongTin[0].email;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
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
                          'THÔNG TIN TÀI KHOẢN',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            controller: txtName,
                            readOnly: false,
                            style: const TextStyle(color: Colors.white),
                            onTap: () {
                              temp1 = 1;
                            },
                            decoration: InputDecoration(
                              hintText: temp1 == 0 ? (thongTin[0].name) : '',
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
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
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            onTap: () {
                              temp1 = 0;
                            },
                            controller: txtEmail,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: thongTin[0].email,
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              prefixIcon:
                                  const Icon(Icons.email, color: Colors.white),
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: 200,
                        height: 80,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (txtName.text == "") {
                              final snackBar = SnackBar(
                                  content:
                                      Text('Vui lòng nhập tên người chơi'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (txtName.text.length < 8 ||
                                txtName.text.length > 16) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Tên người chơi tối thiểu 8 ký tự và tối đa 16 ký tự\nVui lòng nhập lại tên người chơi'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (txtName.text.contains(' ')) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Tên người chơi có khoảng trắng\nVui lòng nhập lại tên người chơi'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            } else {
                              try {
                                querySnapshots = await user.get();
                                for (var snapshot in querySnapshots.docs) {
                                  if (email == snapshot['email']) {
                                    docID = snapshot.id;
                                  }
                                }
                                updateUser(docID);
                              } catch (e) {
                                final snackBar =
                                    SnackBar(content: Text('Có lỗi xảy ra !'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: const Text(
                            'Cập nhật',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.5, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Text('');
        });
  }
}
