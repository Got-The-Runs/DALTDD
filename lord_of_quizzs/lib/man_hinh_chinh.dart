import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/chon_linh_vuc.dart';
import 'package:lord_of_quizzs/lich_su.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau_xac_nhan.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';
import 'package:lord_of_quizzs/mua_credit.dart';
import 'package:lord_of_quizzs/tai_khoan.dart';

import 'dang_nhap.dart';

class ManHinhChinh extends StatefulWidget {
  String email;
  ManHinhChinh({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ManHinhChinhState(
      email: email,
    );
  }
}

class ManHinhChinhState extends State<ManHinhChinh> {
  String email;
  ManHinhChinhState({Key? key, required this.email});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
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
                  leading: IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: const Color(0xFF701ebd),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ManHinhChinh(
                                                  email: email,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      width: 300,
                                      height: 80,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ManHinhTaiKhoan(
                                                email: email,
                                              ),
                                            ),
                                          );
                                        },
                                        // ignore: sort_child_properties_last
                                        child: const Text(
                                          'Tài Khoản',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      width: 300,
                                      height: 80,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                   DangNhapXN(email: email,),
                                            ),
                                          );
                                        },
                                        // ignore: sort_child_properties_last
                                        child: const Text(
                                          'Đổi Mật Khẩu',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      width: 300,
                                      height: 80,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              'welcome',
                                              (route) => false);
                                        },
                                        // ignore: sort_child_properties_last
                                        child: const Text(
                                          'Đăng Xuất',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      width: 300,
                                      height: 80,
                                      child: OutlinedButton(
                                        onPressed: () => exit(0),
                                        // ignore: sort_child_properties_last
                                        child: const Text(
                                          'Thoát',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 33),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    iconSize: 30,
                  ),
                  actions: <Widget>[
                    const Icon(Icons.diamond_rounded, size: 30),
                     Center(
                      child: Text(
                        '${thongTin[0].money}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MuaCredit(),
                            ));
                      }),
                      iconSize: 30,
                    ),
                  ]),
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
                      padding: const EdgeInsets.all(20),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('images/Logo.png',
                          fit: BoxFit.cover, height: 120, width: 120),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child:  Text(
                        thongTin[0].name,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                      width: 350,
                      height: 85,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChonLinhVuc(
                                name: email,
                                email: email,
                              ),
                            ),
                          );
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'Chơi Mới',
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                      width: 350,
                      height: 85,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LichSu(),
                              ));
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'Lịch Sử Chơi',
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                      width: 350,
                      height: 85,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BangXepHang(),
                            ),
                          );
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'Bảng Xếp Hạng',
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                      width: 350,
                      height: 85,
                      child: OutlinedButton(
                        onPressed: () {},
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'Hướng Dẫn',
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
                    Container(
                      padding: const EdgeInsets.all(5.5),
                    )
                  ],
                ),
              ),
            );
          }

          return Text('');
        });
  }
}
