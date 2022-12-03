import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_provider.dart';
import 'package:lord_of_quizzs/model/linh_vuc_object.dart';
import 'package:lord_of_quizzs/model/linh_vuc_provider.dart';
import 'package:lord_of_quizzs/choi_tro_choi.dart';

import 'model/thong_tin_object.dart';
import 'model/thong_tin_provider.dart';
import 'mua_credit.dart';

class BangXepHangLinhVuc extends StatefulWidget {
  String email;
  BangXepHangLinhVuc({Key? key,required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return ChonLinBangXepHangLinhVucState( email: email);
  }
}

class ChonLinBangXepHangLinhVucState extends State<BangXepHangLinhVuc> {
  String email;
  ChonLinBangXepHangLinhVucState({Key? key, required this.email});
  List<LinhVucObject> linhVuc = [];
  void _LoadLinhVuc() async {
    final data = await LinhVucProvider.getData();
    setState(() {});
    linhVuc = data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadLinhVuc();
  }

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
                  iconSize: 30,
                ),
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
                // physics:const NeverScrollableScrollPhysics(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                                 
                      Container(
                        padding: const EdgeInsets.only(top: 70),
                             child: const Text(
                          'Bảng Xếp Hạng \n Lĩnh Vực ',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,             
                        ),
                       
                      ),
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: linhVuc.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            width: 350,
                            height: 85,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BangXepHang(idLinhVuc: linhVuc[index].idLinhVuc)
                                    ));
                              },
                              // ignore: sort_child_properties_last
                              child: Text(
                                linhVuc[index].tenLinhVuc,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                        );
                      },
                    ),
                  ],
               ),
             ),
          ),
        );
     }
  }
