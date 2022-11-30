import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';

class ManHinhTaiKhoan extends StatefulWidget {
  String email;
  ManHinhTaiKhoan({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ManHinhTaiKhoanState(email: email,); 
  }
}

class ManHinhTaiKhoanState extends State<ManHinhTaiKhoan> {
  String email;
  ManHinhTaiKhoanState({Key? key, required this.email});
  var txtEmail = TextEditingController();
  var txtName = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
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
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Đổi ảnh đại diện',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: txtName,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Tên người chơi',
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
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: txtEmail,
                    readOnly: true,
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
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                width: 200,
                height: 80,
                child: OutlinedButton(
                    onPressed: () {},
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Cập nhật',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
