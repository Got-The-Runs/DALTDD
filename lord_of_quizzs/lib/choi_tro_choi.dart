import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  ChoiTroChoi({Key? key, required this.idLinhVuc, required this.email,
   required this.randomIdBoCauHoi }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return ChoiTroChoiState(idLinhVucState: idLinhVuc, email: email, randomIdBoCauHoi: randomIdBoCauHoi);
    }
  }

class ChoiTroChoiState extends State<ChoiTroChoi> {
  int idLinhVucState, randomIdBoCauHoi;
  String email;
  ChoiTroChoiState({Key? key, required this.idLinhVucState, required this.email, required this.randomIdBoCauHoi});
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  late int idBoCauHoi, soCauHoiBoCauHoi, troGiup5050, idCauHoi;
  int diem = 0, mang = 5, i = 0, soCauHoi = 1, soCauDung = 0;
  late String a,b,c,d ;
  Random random = new Random();
  List<ThongTinObject> thongTin = [];
  CollectionReference nguoiChoi =FirebaseFirestore.instance.collection('nguoi_choi');
  DateTime ngay = DateTime.now();
  late String ngayHienTai;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds--);
    });
  }
  void tro_Giup_50_50(){
    troGiup5050 = random.nextInt(5);
  }
  void loadThongTin()async {
    final data = await ThongTinProvider.get(email);
    setState(() {});
    thongTin = data;
  }
  void getNgay(){
    ngayHienTai = DateFormat('dd/MM/yyyy').format(ngay); 
  }
  @override
  void initState() {
    super.initState(); 
    getNgay();
    loadThongTin();
    startTimer();
  }
    Future<void> addNguoiChoi() {
      // Call the user's CollectionReference to add a new user
      return nguoiChoi 
          .add({
            'email': email, 
            'ten_nguoi_choi': thongTin[0].name,
            'id_linh_vuc': idLinhVucState,
            'ngay_choi': ngayHienTai,
            'so_cau_dung': soCauDung,
            'tong_diem': diem
          });  
    }
  @override
  void setState(VoidCallback fn) {
    if(seconds == 1){
       mang--;
      if(mang > 0){
        ngungChoi(soCauHoiBoCauHoi);
      }
      else{
        timer?.cancel();
        addNguoiChoi();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
               title: Text('Kết thúc trò chơi'),
               content: Text('Số điểm của bạn: ${diem}'),
                 actions: <Widget>[
                   TextButton(
                     onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            ManHinhChinh(),
                      ),
                    );
                  },
                child: Text('Màn hình chính')
              )
            ],
          );
        }
      );
      }
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
       //Lấy id bộ câu hỏi dựa trên lĩnh vực
    return FutureBuilder<List<BoCauHoiObject>>(
      future: BoCauHoiProvider.getDataByID(idLinhVucState),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<BoCauHoiObject> linhVuc = snapshot.data!;
          idBoCauHoi = linhVuc[randomIdBoCauHoi].idBoCauHoi;     
          //Lấy id của câu hỏi dựa trên id bộ câu hỏi
        return FutureBuilder<List<CTBoCauHoiObject>>(
          future: CTBoCauHoiProvider.getDataByID(idBoCauHoi),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<CTBoCauHoiObject> cauHoi = snapshot.data!;      
                 idCauHoi = cauHoi[i].idCauHoi;
                 soCauHoiBoCauHoi = cauHoi.length;
              //Lấy id câu hỏi bằng id câu hỏi của ct bộ câu hỏi
         return FutureBuilder<List<CauHoiObject>>(
            future: CauHoiProvider.getDataById(idCauHoi),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                List<CauHoiObject> chiTietCauHoi = snapshot.data!;    
                a = chiTietCauHoi[0].cauTraLoi1;
                b = chiTietCauHoi[0].cauTraLoi2;
                c = chiTietCauHoi[0].cauTraLoi3;
                d = chiTietCauHoi[0].cauTraLoi4;  
              return  WillPopScope(
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
                                              'Quay lại',
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
                                                        style: BorderStyle
                                                            .solid))),
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
                                                        style: BorderStyle.solid
                                                )
                                              )
                                            ),
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
                              '${thongTin[0].money}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children:  <Widget>[
                                      Text(
                                        thongTin[0].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                CupertinoIcons.heart_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text('${mang}', style: TextStyle(fontSize: 20, color: Colors.white),
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
                          child: Text(
                            'Điểm :${diem}',
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
                        child: Text(
                          'Câu ${soCauHoi}: ${chiTietCauHoi[0].cauHoi}'
                          ,
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
                         onPressed: () {
                          setState(() {
                            if(chiTietCauHoi[0].dapAn == 1){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                             else{
                              mang = mang -1;
                              if(mang ==0){
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                        },
                        // ignore: sort_child_properties_last
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            a
                            ,
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
                          onPressed: () {
                          setState(() {
                            if(chiTietCauHoi[0].dapAn == 2){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                            else{
                              mang = mang -1;
                              if(mang ==0){
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                        },
                        // ignore: sort_child_properties_last
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                           b,
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
                          onPressed: () {
                          setState(() {
                            if(chiTietCauHoi[0].dapAn == 3){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                            else{
                              mang = mang -1;
                              if(mang ==0){
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                        },
                        // ignore: sort_child_properties_last
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            c,
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
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                      width: 350,
                      height: 75,
                      child: OutlinedButton(
                         onPressed: () {
                          setState(() {
                            if(chiTietCauHoi[0].dapAn == 4){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                            else{
                              mang = mang -1;
                              if(mang ==0){
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                        },
                        // ignore: sort_child_properties_last
                        child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                             d,
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
 
                      )
                    ),
                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                     { tro_Giup_50_50();
                                    while(chiTietCauHoi[0].dapAn == troGiup5050){
                                      troGiup5050 = random.nextInt(5);
                                    }
                                    if(troGiup5050 != 1 && chiTietCauHoi[0].dapAn != 1){
                                      a = "";
                                    }
                                    if(troGiup5050 != 2 && chiTietCauHoi[0].dapAn != 2){
                                      b = "";
                                    }
                                    if(troGiup5050 != 3 && chiTietCauHoi[0].dapAn != 3){
                                      c = "";
                                    }
                                    if(troGiup5050 != 4 && chiTietCauHoi[0].dapAn != 4){
                                      d = "";
                                    }}
                                    setState(() {
                                      
                                    });

                                  },
                                  child: Text(
                                    '50:50',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
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
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
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
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                        style: BorderStyle.solid,
                                      ))),
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.diamond_rounded,
                                      color: Colors.white),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
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
    void ngungChoi(int cauHoi){
       if(soCauHoi < cauHoi){
          soCauHoi++;
          i++;
          seconds = maxSeconds;
      }
      else{
        timer?.cancel();
        addNguoiChoi();
        showDialog(
           barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
               title: Text('Kết thúc trò chơi'),
               content: Text('Số điểm của bạn: ${diem}'),
                 actions: <Widget>[
                   TextButton(
                     onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            ManHinhChinh(),
                      ),
                    );
                  },
                child: Text('Màn hình chính')
              )
            ],
          );
        }
      );
    }
  }            
  void truMang(){
    timer?.cancel();
    addNguoiChoi();
      showDialog(
         barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
               title: Text('Kết thúc trò chơi'),
               content: Text('Số điểm của bạn: ${diem}'),
                 actions: <Widget>[
                   TextButton(
                     onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            ManHinhChinh(),
                      ),
                    );
                  },
                child: Text('Màn hình chính')
              )
            ],
          );
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