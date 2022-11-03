import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChonLinhVuc extends StatefulWidget {
  const ChonLinhVuc({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return ChonLinhVucState();
  }
}

class ChonLinhVucState extends State<ChonLinhVuc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          iconSize: 35,
        ),
        actions: <Widget>[
          const Icon(Icons.diamond_outlined, size: 35),
          const Text(
            '9999',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {},
            iconSize: 35,
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
                padding: const EdgeInsets.all(50),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: const <Widget>[
                        Text(
                          'Tên Người Chơi',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 26,
                          color: Colors.white,
                        ),
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 26,
                          color: Colors.white,
                        ),
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 26,
                          color: Colors.white,
                        ),
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 26,
                          color: Colors.white,
                        ),
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 26,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: const Text(
                  'Chọn Lĩnh Vực ',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                padding: const EdgeInsets.all(5.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
