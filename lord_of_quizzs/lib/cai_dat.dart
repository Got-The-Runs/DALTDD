import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lord_of_quizzs/dang_nhap.dart';
import 'package:lord_of_quizzs/man_hinh_chinh.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';

import 'bang_xep_hang.dart';
import 'chon_linh_vuc.dart';

class CaiDat extends StatefulWidget {
  const CaiDat({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return CaiDatState();
  }
}

class CaiDatState extends State<CaiDat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
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
        alignment: AlignmentDirectional.centerStart.resolve(TextDirection.ltr),
        constraints: BoxConstraints(
          maxHeight: 400,
          maxWidth: 300,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManHinhChinh(),
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
              padding: const EdgeInsets.all(5.5),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: 300,
              height: 80,
              child: OutlinedButton(
                onPressed: () {},
                // ignore: sort_child_properties_last
                child: const Text(
                  'Tài Khoản',
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: 300,
              height: 80,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DoiMatKhau(),
                    ),
                  );
                },
                // ignore: sort_child_properties_last
                child: const Text(
                  'Đổi Mật Khẩu',
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: 300,
              height: 80,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DangNhap(),
                    ),
                  );
                },
                // ignore: sort_child_properties_last
                child: const Text(
                  'Đăng Xuất',
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: 300,
              height: 80,
              child: OutlinedButton(
                onPressed: () => exit(0),
                // ignore: sort_child_properties_last
                child: const Text(
                  'Thoát',
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
      )),
    );
  }
}
