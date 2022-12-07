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
  int diem = 0, mang = 5, i = 0, soCauHoi = 1, soCauDung = 0,soLanMuaCredit = 0;
  String a="",b="",c="",d="" ;
  bool truyenA=true,truyenB=true,truyenC=true,truyenD=true,suDungTroGiup5050=true,daMuaDapAn=false,highlight = false,truyenCre=false;
  Random random = new Random();
  List<ThongTinObject> thongTin = [];
  CollectionReference nguoiChoi =FirebaseFirestore.instance.collection('nguoi_choi');
  DateTime ngay = DateTime.now();
  late var docID;
  late var querySnapshots;
  final _formKey = GlobalKey<FormState>();
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  late num credit_0;
  late String ngayHienTai;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds--);
    });
  }
  void tro_Giup_50_50(){
    troGiup5050 = random.nextInt(4)+1;
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
  Future<void> updateUser(var docID, var  cre) {
    return user
        .doc(docID)
        .update({'tien_ao': cre});
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
      truyenA=true;
      truyenB=true;
      truyenC=true;
      truyenD=true;
      daMuaDapAn=false;
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
                if(truyenA==true)
                a = chiTietCauHoi[0].cauTraLoi1;
                if(truyenB==true)
                b = chiTietCauHoi[0].cauTraLoi2;
                if(truyenC==true)
                c = chiTietCauHoi[0].cauTraLoi3;
                if(truyenD==true)
                d = chiTietCauHoi[0].cauTraLoi4;
                if(truyenCre == false){
                  credit_0=thongTin[0].money;
                  truyenCre=true;
                }
                
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
                              '${credit_0}',
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
                          if(truyenA == true){
                            setState(() {
                            if(chiTietCauHoi[0].dapAn == 1){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              truyenB=true;
                              truyenC=true;
                              truyenD=true;
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                             else{
                              mang = mang -1;
                              truyenB=true;
                              truyenC=true;
                              truyenD=true;
                              if(mang ==0){
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                          daMuaDapAn=false;
                          }
                        },
                        // ignore: sort_child_properties_last
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            a
                            ,
                            style: TextStyle(
                              fontSize: 20,
                              color:chiTietCauHoi[0].dapAn == 1 && daMuaDapAn == true?Colors.green:Colors.white,
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
                          if(truyenB==true){
                            setState(() {
                            if(chiTietCauHoi[0].dapAn == 2){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              truyenA=true;
                              truyenC=true;
                              truyenD=true;
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                            else{
                              mang = mang -1;
                              truyenA=true;
                              truyenC=true;
                              truyenD=true;
                              if(mang ==0){
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                          daMuaDapAn=false;
                          }
                        },
                        // ignore: sort_child_properties_last
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                           b,
                            style: TextStyle(
                              fontSize: 20,
                              color: chiTietCauHoi[0].dapAn == 2 && daMuaDapAn == true?Colors.green:Colors.white,
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
                         if(truyenC==true){
                           setState(() {
                            if(chiTietCauHoi[0].dapAn == 3){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              truyenA=true;
                              truyenB=true;
                              truyenD=true;
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                            else{
                              mang = mang -1;
                              truyenA=true;
                              truyenB=true;
                              truyenD=true;
                              if(mang ==0){
                                
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                          daMuaDapAn=false;
                         }
                        },
                        // ignore: sort_child_properties_last
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            c,
                            style: TextStyle(
                              fontSize: 20,
                              color:  chiTietCauHoi[0].dapAn == 3 && daMuaDapAn == true?Colors.green:Colors.white,
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
                         if(truyenD == true){
                           setState(() {
                            if(chiTietCauHoi[0].dapAn == 4){
                              soCauDung++;
                              diem = diem + (100*seconds);
                              truyenA=true;
                              truyenB=true;
                              truyenC=true;
                              ngungChoi(soCauHoiBoCauHoi);
                            }
                            else{
                              mang = mang -1;
                              truyenA=true;
                              truyenB=true;
                              truyenC=true;
                              if(mang ==0){
                                
                                truMang();
                              }
                              else               
                                ngungChoi(soCauHoiBoCauHoi);
                            }
                          });
                          daMuaDapAn=false;
                         }                      
                        },
                        // ignore: sort_child_properties_last
                        child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                             d,
                            style: TextStyle(
                              fontSize: 20,
                              color:  chiTietCauHoi[0].dapAn == 4 && daMuaDapAn == true?Colors.green:Colors.white,
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
                                     { 
                                      if(suDungTroGiup5050 == true){
                                        suDungTroGiup5050=false;
                                      tro_Giup_50_50();
                                    while(chiTietCauHoi[0].dapAn == troGiup5050){
                                      tro_Giup_50_50();
                                    }
                                    if(troGiup5050 != 1 && chiTietCauHoi[0].dapAn != 1){
                                      a = "";
                                      truyenA=false;
                                    }
                                    if(troGiup5050 != 2 && chiTietCauHoi[0].dapAn != 2){
                                      b = "";
                                      truyenB=false;
                                    }
                                    if(troGiup5050 != 3 && chiTietCauHoi[0].dapAn != 3){
                                      c = "";
                                      truyenC=false;
                                    }
                                    if(troGiup5050 != 4 && chiTietCauHoi[0].dapAn != 4){
                                      d = "";       
                                      truyenD=false;              
                                    }
                                    }

                                    setState(() {
                                      
                                    });
                                      }

                                  },
                                  child: Text(
                                    '50:50',
                                    style: TextStyle(
                                        fontSize: 17, color: suDungTroGiup5050==true?Colors.white:Color.fromARGB(134, 158, 158, 158),),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                        color: suDungTroGiup5050==true?Colors.white:Color.fromARGB(134, 158, 158, 158),
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
                                  child: Icon(Icons.phone, color:Colors.white),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                         BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                        style: BorderStyle.solid,
                                      ))),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    if(daMuaDapAn==false){
                                      showDialog(
                                    barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Mua câu trả lời bằng credit'),
                                          content: Text('Bạn có chắc muốn dùng ${(soLanMuaCredit+1)*100} để mua đáp án' ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () async{
                                                  try {
                                                        if(credit_0>= (soLanMuaCredit+1)*100){
                                                          daMuaDapAn=true;                                       
                                                            querySnapshots = await user.get();
                                                            for (var snapshot in querySnapshots.docs) {
                                                              if (email == snapshot['email']) {
                                                                docID = snapshot.id;
                                                                credit_0=snapshot['tien_ao'];
                                                              }
                                                            }    
                                                            soLanMuaCredit++;     
                                                            credit_0 -=(soLanMuaCredit*100);                                                                                                                               
                                                            updateUser (docID,credit_0);                       
                                                            setState(() { });
                                                              
                                                            Navigator.pop(context);                                                       
                                                        }
                                                        else{
                                                          Navigator.pop(context);
                                                          showDialog(context: context, builder: (context)
                                                          {
                                                            return AlertDialog(
                                                              title: Text('Thông báo'),
                                                              content: Text('Không đủ credit'),);
                                                          });
                                                          
                                                        }
                                                          } catch (e) {
                                                            final snackBar =
                                                                SnackBar(content: Text('Có lỗi xảy ra !'));
                                                            ScaffoldMessenger.of(context)
                                                                .showSnackBar(snackBar);
                                                          }
                                                          setState(() {
                                                            
                                                          });                   
                                                        },                
                                            child: Text('Yes')
                                          ),
                                          TextButton(
                                                onPressed: () {
                                                    Navigator.pop(context);
                                              },
                                            child: Text('No')
                                        )],
                                      );
                                    }
                                  );
                                    }
                                  },
                                  child: Icon(Icons.diamond_rounded,
                                      color: daMuaDapAn==false?Colors.white:Color.fromARGB(134, 158, 158, 158)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                           BorderSide(
                                        color:  daMuaDapAn==false?Colors.white:Color.fromARGB(134, 158, 158, 158),
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