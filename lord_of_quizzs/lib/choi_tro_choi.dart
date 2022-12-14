// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/bang_xep_hang_object.dart';
import 'package:lord_of_quizzs/model/bang_xep_hang_provider.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_provider.dart';
import 'package:lord_of_quizzs/model/cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/cau_hoi_provider.dart';
import 'package:lord_of_quizzs/model/ct_bo_cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/ct_bo_cau_hoi_provider.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';
import 'man_hinh_chinh.dart';

// ignore: must_be_immutable
class ChoiTroChoi extends StatefulWidget {
  int idLinhVuc, randomIdBoCauHoi;
  String email;
  ChoiTroChoi(
      {Key? key,
      required this.idLinhVuc,
      required this.email,
      required this.randomIdBoCauHoi})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return ChoiTroChoiState(
        idLinhVucState: idLinhVuc,
        email: email,
        randomIdBoCauHoi: randomIdBoCauHoi);
  }
}

class ChoiTroChoiState extends State<ChoiTroChoi> {
  int idLinhVucState, randomIdBoCauHoi;
  String email;
  ChoiTroChoiState(
      {Key? key,
      required this.idLinhVucState,
      required this.email,
      required this.randomIdBoCauHoi});
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  late int idBoCauHoi, soCauHoiBoCauHoi, troGiup5050, idCauHoi, khangia;
  int diem = 0, mang = 5, i = 0, soCauHoi = 1, soCauDung = 0, soLanMuaCredit = 0;
  String a = "", b = "", c = "", d = "", dapAn = "";
  bool truyenA = true, truyenB = true, truyenC = true, truyenD = true, suDungTroGiup5050 = true, khanGia = true,
      goiDien = true, daMuaDapAn = false, highlight = false, truyenCre = false;
  List<Color> cau1 = [Colors.white];
  List<Color> cau2 =[ Colors.white];
  List<Color> cau3 = [Colors.white];
  List<Color> cau4 = [Colors.white];
  // ignore: unnecessary_new
  Random random = new Random();
  List<ThongTinObject> thongTin = [];
  List<BangXepHangObject> thongTinBangXepHang =[];
  CollectionReference nguoiChoi = FirebaseFirestore.instance.collection('nguoi_choi');
  DateTime ngay = DateTime.now();
  late var docID, querySnapshots, docIDBXH;
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  CollectionReference bangXepHang = FirebaseFirestore.instance.collection("bang_xep_hang");
  late num credit_0;
  num diemBXH = 0;
  late String ngayHienTai;
  bool hasDataBXH = false;
  static int c1 = Random().nextInt(60) + 41;
  static int c2 = Random().nextInt((100 - c1) + 1);
  static int c3 = Random().nextInt((100 - c1 - c2) + 1);
  static int c4 = 100 - c1 - c2 - c3;

  //resetColor
  resetColor(){
      cau1[0] = Colors.white;
      cau2[0] =Colors.white;
      cau3[0] =Colors.white;
      cau4[0] = Colors.white;
  }
  //?????m th???i gian
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds--);
    });
  }

  void tro_Giup_50_50() {
    troGiup5050 = random.nextInt(4) + 1;
  }
  //L???y th??ng tin ng?????i ch??i
  void loadThongTin() async {
    final data = await ThongTinProvider.get(email);
    setState(() {});
    thongTin = data;
  }
  //L???y th??ng tin t???t c??? user trong b???ng x???p h???ng
  void loadBangXepHang() async{
    final data = await BangXepHangProvider.getAllBXH();
    setState(() {});
    thongTinBangXepHang = data;
  }
  //L???y ng??y hi???n t???i
  void getNgay() {
    ngayHienTai = DateFormat('dd/MM/yyyy').format(ngay);
  }

  @override
  void initState() {
    super.initState();
    getNgay();
    loadThongTin();
    loadBangXepHang();
    startTimer();
  }
//C???p nh???t ti???n ???o
  Future<void> updateUser(var docID, var cre) {
    return user.doc(docID).update({'tien_ao': cre});
  }
//Th??m th??ng tin ng?????i ch??i
  Future<void> addNguoiChoi() {
    return nguoiChoi.add({
      'email': email,
      'ten_nguoi_choi': thongTin[0].name,
      'ngay_choi': ngayHienTai,
      'so_cau_dung': soCauDung,
      'ngay_choi_2':ngay,
      'tong_diem': diem
    });
  }
  //Th??m th??ng tin b???ng x???p h???ng
  Future<void> addBXH() {
    return bangXepHang.add({
      'email': email,
      'id_linh_vuc': idLinhVucState,
      'tong_diem': diem
    });
  }
  //C???p nh???t b???ng x???p h???ng
 Future<void> updateBXH() async {
    querySnapshots = await bangXepHang.get();
    for (var snapshot in querySnapshots.docs) {
       if (email == snapshot['email'] && idLinhVucState == snapshot['id_linh_vuc']) {
         docIDBXH = snapshot.id;
     }
    }
    return bangXepHang.doc(docIDBXH).update({'tong_diem': diem});
  }
    //Th??m ho???c update user b???ng x???p h???ng
  Future<void> userBXH() async{
    for(int i=0; i<thongTinBangXepHang.length;i++){
      if(email == thongTinBangXepHang[i].email && idLinhVucState == thongTinBangXepHang[i].idLinhVuc){
        hasDataBXH = true;
        diemBXH = thongTinBangXepHang[i].tongDiem;
      }
    }
    if(hasDataBXH == true && diem > diemBXH){
      updateBXH();
    }
    if(hasDataBXH == false){
      addBXH();
    }
  }
//Ng???ng ch??i n???u h???t th???i gian v?? h???t m???ng
  @override
  void setState(VoidCallback fn) {
    if (seconds == 1) {
      truyenA = true;
      truyenB = true;
      truyenC = true;
      truyenD = true;
      daMuaDapAn = false;
      mang--;
      if (mang > 0) {
        ngungChoi(soCauHoiBoCauHoi);
      } else {
        timer?.cancel();
        addNguoiChoi();
        userBXH();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('K???t th??c tr?? ch??i'),
                content: Text('S??? ??i???m c???a b???n: ${diem}'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManHinhChinh(),
                          ),
                        );
                      },
                      child: Text('M??n h??nh ch??nh'))
                ],
              );
            });
      }
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //L???y id b??? c??u h???i d???a tr??n l??nh v???c
    return FutureBuilder<List<BoCauHoiObject>>(
        future: BoCauHoiProvider.getDataByID(idLinhVucState),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BoCauHoiObject> linhVuc = snapshot.data!;
            idBoCauHoi = linhVuc[randomIdBoCauHoi].idBoCauHoi;
            //L???y id c???a c??u h???i d???a tr??n id b??? c??u h???i
            return FutureBuilder<List<CTBoCauHoiObject>>(
                future: CTBoCauHoiProvider.getDataByID(idBoCauHoi),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CTBoCauHoiObject> cauHoi = snapshot.data!;
                    idCauHoi = cauHoi[i].idCauHoi;
                    soCauHoiBoCauHoi = cauHoi.length;
                    //L???y id c??u h???i b???ng id c??u h???i c???a ct b??? c??u h???i
                    return FutureBuilder<List<CauHoiObject>>(
                        future: CauHoiProvider.getDataById(idCauHoi),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<CauHoiObject> chiTietCauHoi = snapshot.data!;
                            if (truyenA == true)
                              a = chiTietCauHoi[0].cauTraLoi1;
                            if (truyenB == true)
                              b = chiTietCauHoi[0].cauTraLoi2;
                            if (truyenC == true)
                              c = chiTietCauHoi[0].cauTraLoi3;
                            if (truyenD == true)
                              d = chiTietCauHoi[0].cauTraLoi4;
                            if (truyenCre == false) {
                              credit_0 = thongTin[0].money;
                              truyenCre = true;
                            }                                           
                            return WillPopScope(
                              onWillPop: () async => false,
                              child: Scaffold(
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
                                            backgroundColor:
                                                const Color(0xFF701ebd),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 40,
                                                            vertical: 10),
                                                    height: 80,
                                                    width: 30,
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        timer?.cancel();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ManHinhChinh(),
                                                          ),
                                                        );
                                                      },
                                                      // ignore: sort_child_properties_last
                                                      child: const Text(
                                                        'Quay l???i',
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      Colors
                                                                          .transparent),
                                                          side: MaterialStateProperty
                                                              .all(const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2.0,
                                                                  style: BorderStyle
                                                                      .solid))),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 40,
                                                            vertical: 10),
                                                    height: 80,
                                                    width: 30,
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    exit(0),
                                                          ),
                                                        );
                                                      },
                                                      // ignore: sort_child_properties_last
                                                      child: const Text(
                                                        'Tho??t',
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      Colors
                                                                          .transparent),
                                                          side: MaterialStateProperty
                                                              .all(const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2.0,
                                                                  style: BorderStyle
                                                                      .solid))),
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
                                    Center(
                                      child: Text(
                                        '${credit_0}',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                     Padding(padding: EdgeInsets.only(right: 20))
                                  ],
                                ),
                                body: Stack(
                                children: [
                                Container(
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
                                  // child: SingleChildScrollView(
                                  // physics:const NeverScrollableScrollPhysics(),
                                 Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 87),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 30),
                                                child: Text(
                                                  thongTin[0].name,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(right: 40),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  CupertinoIcons.heart_fill,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  '${mang}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Text(
                                              '??i???m : ${diem}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: buildTimer(),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                                          child: Text(
                                            'C??u ${soCauHoi}: ${chiTietCauHoi[0].cauHoi}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 14),
                                        width: 350,
                                        height: 80,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if (truyenA == true) {
                                              setState(() {
                                                if (chiTietCauHoi[0].dapAn ==
                                                    1) {
                                                  soCauDung++;
                                                  diem = diem + (100 * seconds);
                                                  truyenB = true;
                                                  truyenC = true;
                                                  truyenD = true;
                                                  cau1[0] = Colors.lightGreen;
                                                  Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );
                                                } else {
                                                  mang = mang - 1;
                                                  truyenB = true;
                                                  truyenC = true;
                                                  truyenD = true;
                                                  cau1[0] = Colors.red;
                                                  if (mang == 0) {
                                                    truMang();
                                                  } else {
                                                    Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );              
                                                  }
                                                }
                                              });
                                              daMuaDapAn = false;
                                            }
                                          },
                                          // ignore: sort_child_properties_last
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "A: $a",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: chiTietCauHoi[0].dapAn ==
                                                            1 &&
                                                        daMuaDapAn == true
                                                    ? Colors.green
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                   cau1[0]),
                                              side: MaterialStateProperty.all(
                                                   BorderSide(
                                                      color: chiTietCauHoi[0].dapAn == 1 && daMuaDapAn == true ? Colors.green: Colors.white,
                                                      width: 2.0,
                                                      style:
                                                          BorderStyle.solid))),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 14),
                                        width: 350,
                                        height: 80,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if (truyenB == true) {
                                              setState(() {
                                                if (chiTietCauHoi[0].dapAn ==
                                                    2) {
                                                  soCauDung++;
                                                  diem = diem + (100 * seconds);
                                                  truyenA = true;
                                                  truyenC = true;
                                                  truyenD = true;
                                                  cau2[0] = Colors.lightGreen;
                                                   Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );  
                                                } else {
                                                  mang = mang - 1;
                                                  truyenA = true;
                                                  truyenC = true;
                                                  truyenD = true;
                                                  cau2[0] = Colors.red;
                                                  if (mang == 0) {
                                                    truMang();
                                                  } else {
                                                   Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );  
                                                  }
                                                }
                                              });
                                              daMuaDapAn = false; 
                                            }
                                          },
                                          // ignore: sort_child_properties_last
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "B: $b",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: chiTietCauHoi[0].dapAn ==
                                                            2 &&
                                                        daMuaDapAn == true
                                                    ? Colors.green
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                 cau2[0]),
                                              side: MaterialStateProperty.all(
                                                  BorderSide(
                                                      color: chiTietCauHoi[0].dapAn == 2 && daMuaDapAn == true ? Colors.green: Colors.white,
                                                      width: 2.0,
                                                      style:
                                                          BorderStyle.solid))),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 14),
                                        width: 350,
                                        height: 80,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if (truyenC == true) {
                                              setState(() {
                                                if (chiTietCauHoi[0].dapAn ==
                                                    3) {
                                                  soCauDung++;
                                                  diem = diem + (100 * seconds);
                                                  truyenA = true;
                                                  truyenB = true;
                                                  truyenD = true;
                                                  cau3[0] = Colors.lightGreen;
                                                   Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );
                                                } else {
                                                  mang = mang - 1;
                                                  truyenA = true;
                                                  truyenB = true;
                                                  truyenD = true;
                                                  cau3[0] = Colors.red;
                                                  if (mang == 0) {
                                                    truMang();
                                                  } else {
                                                     Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );
                                                  }
                                                }
                                              });
                                              daMuaDapAn = false;
                                            }
                                          },
                                          // ignore: sort_child_properties_last
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "C: $c",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: chiTietCauHoi[0].dapAn ==
                                                            3 &&
                                                        daMuaDapAn == true
                                                    ? Colors.green
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                    cau3[0]),
                                              side: MaterialStateProperty.all(
                                                   BorderSide(
                                                      color: chiTietCauHoi[0].dapAn == 3 && daMuaDapAn == true ? Colors.green: Colors.white,
                                                      width: 2.0,
                                                      style:
                                                          BorderStyle.solid))),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 14),
                                          width: 350,
                                          height: 80,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if (truyenD == true) {
                                                setState(() {
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      4) {
                                                    soCauDung++;
                                                    diem =
                                                        diem + (100 * seconds);
                                                    truyenA = true;
                                                    truyenB = true;
                                                    truyenC = true;
                                                    cau4[0] = Colors.lightGreen;
                                                   Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                   setState((){
                                                      ngungChoi(soCauHoiBoCauHoi);
                                                    });  
                                                  }  
                                                  );   
                                                  } else {
                                                    mang = mang - 1;
                                                    truyenA = true;
                                                    truyenB = true;
                                                    truyenC = true;
                                                    cau4[0] = Colors.red;
                                                    if (mang == 0) {
                                                      truMang();
                                                    } else {
                                                      Future.delayed(
                                                    const Duration(seconds: 1), () {
                                                      setState((){
                                                          ngungChoi(soCauHoiBoCauHoi);
                                                        });  
                                                      }  
                                                      );  
                                                    } 
                                                  }
                                                });
                                                daMuaDapAn = false;
                                              }
                                            },
                                            // ignore: sort_child_properties_last
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "D: $d",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: chiTietCauHoi[0].dapAn == 4 && daMuaDapAn == true ? Colors.green: Colors.black,
                                                ),
                                              ),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                      cau4[0]),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: chiTietCauHoi[0].dapAn == 4 && daMuaDapAn == true ? Colors.green: Colors.white,
                                                        width: 2.0,
                                                        style: BorderStyle
                                                            .solid))),
                                            )
                                          ),
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Align(
                                          alignment: Alignment.bottomCenter,
                                          child:OutlinedButton(
                                            onPressed: () {
                                              {
                                                if (suDungTroGiup5050 == true) {
                                                  suDungTroGiup5050 = false;
                                                  tro_Giup_50_50();
                                                  while (
                                                      chiTietCauHoi[0].dapAn ==
                                                          troGiup5050) {
                                                    tro_Giup_50_50();
                                                  }
                                                  if (troGiup5050 != 1 &&
                                                      chiTietCauHoi[0].dapAn !=
                                                          1) {
                                                    a = "";
                                                    truyenA = false;
                                                  }
                                                  if (troGiup5050 != 2 &&
                                                      chiTietCauHoi[0].dapAn !=
                                                          2) {
                                                    b = "";
                                                    truyenB = false;
                                                  }
                                                  if (troGiup5050 != 3 &&
                                                      chiTietCauHoi[0].dapAn !=
                                                          3) {
                                                    c = "";
                                                    truyenC = false;
                                                  }
                                                  if (troGiup5050 != 4 &&
                                                      chiTietCauHoi[0].dapAn !=
                                                          4) {
                                                    d = "";
                                                    truyenD = false;
                                                  }
                                                }

                                                setState(() {});
                                              }
                                            },
                                            child: Text(
                                              '50:50',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: suDungTroGiup5050 == true
                                                    ? Colors.white
                                                    : Color.fromARGB(
                                                        134, 158, 158, 158),
                                              ),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                  color: suDungTroGiup5050 ==
                                                          true
                                                      ? Colors.white
                                                      : Color.fromARGB(
                                                          134, 158, 158, 158),
                                                  width: 2.0,
                                                  style: BorderStyle.solid,
                                                ))),
                                          ),
                                          ),
                                          Align(
                                          alignment: Alignment.bottomCenter,
                                         child: OutlinedButton(
                                            onPressed: () {
                                              {
                                                if (khanGia == true) {
                                                  khanGia = false;
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      1) {
                                                    dapAn =
                                                        "A : ${c1}%\nB : ${c2}%\nC : ${c3}%\nD : ${c4}%";
                                                  }
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      2) {
                                                    dapAn =
                                                        "A : ${c4}%\nB : ${c1}%\nC : ${c2}%\nD : ${c3}%";
                                                  }
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      3) {
                                                    dapAn =
                                                        "A : ${c3}%\nB : ${c4}%\nC : ${c1}%\nD : ${c2}%";
                                                  }
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      4) {
                                                    dapAn =
                                                        "B : ${c2}%\nB : ${c3}%\nC : ${c4}%\nD : ${c1}%";
                                                  }
                                                  setState(() {});
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Tr??? gi??p t??? kh??n gi???'),
                                                          content: Text(
                                                            '$dapAn',
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text('Ok'))
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            },
                                            child: Icon(
                                              Icons.people,
                                              size: 17,
                                              color: khanGia == true
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      134, 158, 158, 158),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                  color: khanGia == true
                                                      ? Colors.white
                                                      : Color.fromARGB(
                                                          134, 158, 158, 158),
                                                  width: 2.0,
                                                  style: BorderStyle.solid,
                                                ))),
                                          ),
                                          ),
                                          Align(
                                          alignment: Alignment.bottomCenter,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              {
                                                if (goiDien == true) {
                                                  goiDien = false;
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      1) {
                                                    a = chiTietCauHoi[0]
                                                        .cauTraLoi1;
                                                    dapAn = "A";
                                                  }
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      2) {
                                                    b = chiTietCauHoi[0]
                                                        .cauTraLoi2;
                                                    dapAn = "B";
                                                  }
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      3) {
                                                    c = chiTietCauHoi[0]
                                                        .cauTraLoi3;
                                                    dapAn = "C";
                                                  }
                                                  if (chiTietCauHoi[0].dapAn ==
                                                      4) {
                                                    d = chiTietCauHoi[0]
                                                        .cauTraLoi4;
                                                    dapAn = "D";
                                                  }
                                                  setState(() {});
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'G???i ??i???n t??? ng?????i th??n'),
                                                          content: Text(
                                                              'C??u tr??? l???i g???i ?? t??? ng?????i th??n: ${dapAn}'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text('Ok'))
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            },
                                            child: Icon(
                                              Icons.phone,
                                              size: 17,
                                              color: goiDien == true
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      134, 158, 158, 158),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                  color: goiDien == true
                                                      ? Colors.white
                                                      : Color.fromARGB(
                                                          134, 158, 158, 158),
                                                  width: 2.0,
                                                  style: BorderStyle.solid,
                                                ))),
                                          ),
                                          ),
                                          Align(
                                          alignment: Alignment.bottomCenter,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if (daMuaDapAn == false) {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Mua c??u tr??? l???i b???ng credit'),
                                                        content: Text(
                                                            'B???n c?? ch???c mu???n d??ng ${(soLanMuaCredit + 1) * 100} ????? mua ????p ??n'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                try {
                                                                  if (credit_0 >=  (soLanMuaCredit + 1) *  100) {
                                                                    daMuaDapAn =  true;
                                                                    querySnapshots = await user.get();
                                                                    for (var snapshot in querySnapshots.docs) {
                                                                      if (email == snapshot['email']) {
                                                                        docID = snapshot.id;
                                                                        credit_0 = snapshot['tien_ao'];
                                                                      }
                                                                    }
                                                                    soLanMuaCredit++;
                                                                    credit_0 -=
                                                                        (soLanMuaCredit * 100);
                                                                    updateUser( docID, credit_0);
                                                                    setState(
                                                                        () {});

                                                                    Navigator.pop(context);
                                                                  } else {
                                                                    Navigator.pop( context);
                                                                    showDialog(context: context, builder:(context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Th??ng b??o'),
                                                                            content:
                                                                                Text('Kh??ng ????? credit'),
                                                                          );
                                                                        });
                                                                  }
                                                                } catch (e) {
                                                                  final snackBar =
                                                                      SnackBar(
                                                                          content:
                                                                              Text('C?? l???i x???y ra !'));
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);
                                                                }
                                                                setState(() {});
                                                              },
                                                              child:
                                                                  Text('Yes')),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                          },
                                                        child: Text('No'))
                                                      ],
                                                    );
                                                  }
                                                );
                                              }
                                            },
                                            child: Icon(Icons.diamond_rounded,
                                                color: daMuaDapAn == false
                                                    ? Colors.white
                                                    : Color.fromARGB(
                                                        134, 158, 158, 158)),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                  color: daMuaDapAn == false
                                                      ? Colors.white
                                                      : Color.fromARGB(
                                                          134, 158, 158, 158),
                                                  width: 2.0,
                                                  style: BorderStyle.solid,
                                            )
                                          )
                                        ),
                                      ),
                                          ),
                                    ],
                                  )
                              //   ],
                              // ),
                            ]
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
        return Text('');
      }
    );
  }

  void ngungChoi(int cauHoi) {
    if (soCauHoi < cauHoi) {
      soCauHoi++;
      i++;
      seconds = maxSeconds;   
      resetColor();
    } else {
      timer?.cancel();
      addNguoiChoi();
      userBXH();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('K???t th??c tr?? ch??i'),
              content: Text('S??? ??i???m c???a b???n: ${diem}'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManHinhChinh(),
                        ),
                      );
                    },
                    child: Text('M??n h??nh ch??nh'))
              ],
            );
          });
    }

  }

  void truMang() {
    timer?.cancel();
    addNguoiChoi();
    userBXH();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('K???t th??c tr?? ch??i'),
            content: Text('S??? ??i???m c???a b???n: ${diem}'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManHinhChinh(),
                      ),
                    );
                  },
                  child: Text('M??n h??nh ch??nh'))
            ],
          );
        });
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
