import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/cai_dat.dart';
// ignore: unused_import
import 'package:lord_of_quizzs/dang_ky.dart';
import 'package:lord_of_quizzs/dang_nhap.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DangNhap(),
        );
  }
}
