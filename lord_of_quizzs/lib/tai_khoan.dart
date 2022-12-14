// ignore_for_file: sort_child_properties_last

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/man_hinh_chinh.dart';
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
  bool trungTenNguoiChoi = false;
  var docID;
  var querySnapshots;
  final _formKey = GlobalKey<FormState>();
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  late String name;
  Future<void> updateUser(var docID, String name) {
    return user
        .doc(docID)
        .update({'ten_nguoi_choi': name})
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManHinhChinh(),
              ),
            ));
  }

  List<ThongTinObject> thongTinAll = [];
  void _LoadThongTinAll() async {
    final data = await ThongTinProvider.getEmail();
    setState(() {});
    thongTinAll = data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadThongTinAll();
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
              appBar: AppBar(
                centerTitle: true,
                title: const Text('T??i Kho???n',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
              body: Stack(children: [
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
                          'Th??ng Tin T??i Kho???n',
                          style: TextStyle(
                              fontSize: 25,
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
                          onPressed: ()  {
                            if (txtName.text == "") {
                              final snackBar = SnackBar(
                                 duration: Duration(seconds: 1),
                                  content:
                                      Text('Vui l??ng nh???p t??n ng?????i ch??i'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (txtName.text.length < 8 ||
                                txtName.text.length > 16) {
                              final snackBar = SnackBar(
                                 duration: Duration(seconds: 1),
                                  content: Text(
                                      'T??n ng?????i ch??i t???i thi???u 8 k?? t??? v?? t???i ??a 16 k?? t???\nVui l??ng nh???p l???i t??n ng?????i ch??i'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if ((txtName.text.substring(0, 1) == " ")) {
                              final snackBar = SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                      'T??n ng?????i ch??i c?? kho???ng tr???ng ??? ?????u\nVui l??ng nh???p l???i t??n ng?????i ch??i'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            } else {
                              for (int i = 0;i < (txtName.text.length - 1);i++) {
                                if (txtName.text.substring(i, i + 2) == "  ") {
                                  final snackBar = SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          'T??n ng?????i ch??i ??? gi???a t???i thi???u 1 kho???ng tr???ng\nVui l??ng nh???p l???i t??n ng?????i ch??i!'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                              }
                              for (int i = 0; i < thongTinAll.length; i++) {
                                if (txtName.text == thongTinAll[i].name) {
                                  final snackBar = SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          'T??n ng?????i ch??i ???? ???????c s??? d???ng\nVui l??ng nh???p l???i t??n ng?????i ch??i!'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                } 
                              }
                              try {
                                querySnapshots = user.get();
                                for (var snapshot in querySnapshots.docs) {
                                  if (email == snapshot['email']) {
                                    docID = snapshot.id;
                                    name = snapshot['ten_nguoi_choi'];
                                  }
                                }
                                name = txtName.text;
                                updateUser(docID, name);
                                setState(() {});
                              } catch (e) {
                                final snackBar =
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                      content: Text('C?? l???i x???y ra !'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                            setState(() {});
                          },
                          child: const Text(
                            'C???p nh???t',
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
              ]),
            );
          }
          return Text('');
        });
  }
}
