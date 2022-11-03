import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/chon_linh_vuc.dart';

class ManHinhChinh extends StatefulWidget {
  const ManHinhChinh({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return ManHinhChinhState();
  }
}

class ManHinhChinhState extends State<ManHinhChinh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
          iconSize: 30,
        ),
        actions: <Widget> [
          const Icon(Icons.diamond_outlined, size: 35),
          const Text(
            '9999',
              style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
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
        child: SingleChildScrollView(
          // physics:const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(40),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset('images/Logo.png',
                    fit: BoxFit.cover, height: 145, width: 145),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Text(
                  'Tên Người Chơi',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: 350,
                height: 85,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChonLinhVuc(),
                      ),
                    );
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Chơi Mới',
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
                padding: const EdgeInsets.all(15),
                width: 350,
                height: 85,
                child: OutlinedButton(
                  onPressed: () {},
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Lịch Sử Chơi',
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
                padding: const EdgeInsets.all(15),
                width: 350,
                height: 85,
                child: OutlinedButton(
                  onPressed: () {},
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Bảng Xếp Hạng',
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
                padding: const EdgeInsets.all(15),
                width: 350,
                height: 85,
                child: OutlinedButton(
                  onPressed: () {},
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Hướng Dẫn',
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
                padding: EdgeInsets.all(5.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
