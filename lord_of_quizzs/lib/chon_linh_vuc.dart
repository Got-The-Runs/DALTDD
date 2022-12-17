import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/linh_vuc_object.dart';
import 'package:lord_of_quizzs/model/linh_vuc_provider.dart';
import 'package:lord_of_quizzs/choi_tro_choi.dart';
import 'model/thong_tin_object.dart';
import 'model/thong_tin_provider.dart';
import 'mua_credit.dart';

class ChonLinhVuc extends StatefulWidget {
  String name;
  String email;
  ChonLinhVuc({Key? key, required this.name, required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return ChonLinhVucState( email: name);
  }
}

class ChonLinhVucState extends State<ChonLinhVuc> {
  String email;
  ChonLinhVucState({Key? key, required this.email});
  late int randomIdBoCauHoi;
  int hasData =0;
  var querySnapshots;
  CollectionReference boCauHoi = FirebaseFirestore.instance.collection("bo_cau_hoi");
  List<LinhVucObject> linhVuc = [];
  void _LoadLinhVuc() async {
    final data = await LinhVucProvider.getData();
    setState(() {});
    linhVuc = data;
  }

  @override
  void initState() {
    randomIdBoCauHoi = Random().nextInt(2);
    // TODO: implement initState
    super.initState();
    _LoadLinhVuc();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThongTinObject>>(
        future: ThongTinProvider.get(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ThongTinObject> thongTin = snapshot.data!;
            email = thongTin[0].email;
            return Scaffold(
              appBar: AppBar(
                title: Text( 'Chọn Lĩnh Vực', style: TextStyle( fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold)),
                 flexibleSpace:  Container(
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
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => Navigator.pop(context),
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
                 Padding(padding: EdgeInsets.only(right: 20))
                ],
              ),
              body: Stack(children: [
                Container(
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
                ),          
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  shrinkWrap: true,
                  itemCount: linhVuc.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15),
                      width: 350,
                      height: 85, 
                      child: OutlinedButton(
                        onPressed: ()async {    
                          try {
                            querySnapshots = await boCauHoi.get();
                              for (var snapshot in querySnapshots.docs) {
                                if (linhVuc[index].idLinhVuc == snapshot['id_linh_vuc']) {
                                  hasData = 1;
                                  if(hasData == 1){
                                    // ignore: use_build_context_synchronously
                                     Navigator.push( context,
                                       MaterialPageRoute( 
                                        builder: (context) => 
                                          ChoiTroChoi(idLinhVuc: linhVuc[index].idLinhVuc, email: email,
                                                        randomIdBoCauHoi: randomIdBoCauHoi
                                        ),
                                      )
                                    );
                                    break;
                                  }
                                }
                              }
                              if(hasData ==0){
                                  final snackBar = SnackBar(content: Text('Lĩnh vực này đang được cập nhật'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                return;
                                }
                            }
                            catch(e){
                              final snackBar = SnackBar(content: Text('Lĩnh vực này đang được cập nhật'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                return;
                                }
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
                                          style: BorderStyle.solid
                              )
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ]
              ),
            );
          }
        return Text('');
      }
    );
  }
}
