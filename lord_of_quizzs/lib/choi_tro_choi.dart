import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_provider.dart';
import 'package:lord_of_quizzs/model/ct_bo_cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/ct_bo_cau_hoi_provider.dart';
import 'man_hinh_chinh.dart';

class ChoiTroChoi extends StatefulWidget {
  int idLinhVuc;
  ChoiTroChoi({Key ? key, required this.idLinhVuc}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    return ChoiTroChoiState(idLinhVucState: idLinhVuc);
  }
}

class ChoiTroChoiState extends State<ChoiTroChoi>{
  int idLinhVucState;
  ChoiTroChoiState({Key ? key, required this.idLinhVucState});
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  late int idBoCauHoi;
  late int idCauHoi;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => seconds--);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      timer?.cancel();
    }
    return FutureBuilder<List<BoCauHoiObject>>(
      future: BoCauHoiProvider.getDataByID(idLinhVucState),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<BoCauHoiObject> linhVuc = snapshot.data!;
          idBoCauHoi = linhVuc[0].idBoCauHoi;       
        return FutureBuilder<List<CTBoCauHoiObject>>(
          future: CTBoCauHoiProvider.getDataByID(idBoCauHoi),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<CTBoCauHoiObject> cauHoi = snapshot.data!;
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  height: 80,
                                  width: 30,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ManHinhChinh(),
                                        ),
                                      );
                                    },
                                    // ignore: sort_child_properties_last
                                    child: const Text(
                                      'Quay lại',
                                      style:
                                          TextStyle(fontSize: 25, color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
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
                                  height: 80,
                                  width: 30,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => exit(0),
                                        ),
                                      );
                                    },
                                    // ignore: sort_child_properties_last
                                    child: const Text(
                                      'Thoát',
                                      style:
                                          TextStyle(fontSize: 25, color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.white,
                                                width: 2.0,
                                                style: BorderStyle.solid))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  iconSize: 30,
                ),
                actions: <Widget>[
                  const Icon(Icons.diamond_rounded, size: 30),
                  const Center(
                    child: Text(
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
                // child: SingleChildScrollView(
                // physics:const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 87),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: const <Widget>[
                              Text(
                                'Tên Người Chơi',
                                style: TextStyle(
                                    fontSize: 20,
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
                                size: 20,
                                color: Colors.white,
                              ),
                              Icon(
                                CupertinoIcons.heart_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              Icon(
                                CupertinoIcons.heart_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              Icon(
                                CupertinoIcons.heart_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              Icon(
                                CupertinoIcons.heart_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          child:  Text(
                            'Điểm : ${cauHoi[0].idCauHoi}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 150),
                          child: buildTimer(),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                    ),
                    Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "Câu 1: Đại Ngu là quốc hiệu của triều đại nào ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      width: 350,
                      height: 75,
                      child: OutlinedButton(
                        onPressed: () {},
                        // ignore: sort_child_properties_last
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'A. Triều Ngô',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
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
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      width: 350,
                      height: 75,
                      child: OutlinedButton(
                        onPressed: () {},
                        // ignore: sort_child_properties_last
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'B. Triều Hồ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
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
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      width: 350,
                      height: 75,
                      child: OutlinedButton(
                        onPressed: () {},
                        // ignore: sort_child_properties_last
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'C. Các chúa Nguyễn',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
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
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      width: 350,
                      height: 75,
                      child: OutlinedButton(
                        onPressed: () {},
                        // ignore: sort_child_properties_last
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'D. Nhà Tây Sơn',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
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
                      padding: EdgeInsets.all(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            '50:50',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ))),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ))),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Icon(Icons.phone, color: Colors.white),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ))),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Icon(Icons.diamond_rounded, color: Colors.white),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid,
                            ))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return Text('');
          }
        );
      }
      return Text('');
    }
  );
}
  Widget buildTime() {
    return Text(
      '$seconds',
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget buildTimer() => SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds,
              valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
              strokeWidth: 10,
              backgroundColor: Colors.red,
            ),
            Center(child: buildTime())
          ],
        ),
  );
}
