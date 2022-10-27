// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/dang_ky.dart';
import 'package:lord_of_quizzs/quen_mat_khau.dart';

class DangNhap extends StatefulWidget {
  const DangNhap({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return DangNhapState();
  }
}

class DangNhapState extends State<DangNhap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'ĐĂNG NHẬP',
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(195, 252, 251, 250),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Tên đăng nhập',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                ),
              )),
          Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Mật khẩu',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: const Icon(Icons.password, color: Colors.black),
                ),
              )),
          Container(
            padding: const EdgeInsets.all(15),
            width: 200,
            height: 80,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Đăng nhập'),
                        content:
                            const Text('Chúc mừng bạn đã đăng nhập thành công'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'))
                        ],
                      );
                    });
              },
              // ignore: sort_child_properties_last
              child: const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(188, 51, 129, 247)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuenMatKhau(),
                  ),
                );
              },
              child: const Text(
                'Quên mật khẩu',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DangKi(),
                  ),
                );
              },
              child: const Text(
                'Đăng ký',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
