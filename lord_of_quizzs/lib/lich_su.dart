import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/chon_linh_vuc.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_provider.dart';
import 'package:lord_of_quizzs/mua_credit.dart';

import 'model/nguoi_choi_object.dart';

class LichSu extends StatefulWidget {
  String email;
  LichSu({Key? key, required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return LichSuState(email: email);
  }
}

class LichSuState extends State<LichSu> {
  String email;
  LichSuState({Key? key, required this.email});
  List<NguoiChoiObject> nguoiChoi = [];
  void _LoadNguoiChoi() async {
    final data = await NguoiChoiProvider.getdata(email);
    setState(() {});
    nguoiChoi = data;
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return FutureBuilder<List<NguoiChoiObject>>(
        future: NguoiChoiProvider.getdata(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NguoiChoiObject> nguoiChoi = snapshot.data!;
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
                        padding: const EdgeInsets.all(25),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: const Text(
                          'Lịch sử chơi',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: 20, top: 10),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: nguoiChoi.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            shadowColor: Colors.blueGrey,
                            child: ListTile(
                              title: Text(nguoiChoi[index].tenNguoiChoi,
                                  style: TextStyle(fontSize: 20)),
                              subtitle: Text(
                                nguoiChoi[index].ngayChoi,
                                style: TextStyle(fontSize: 20),
                              ),
                              trailing: Text(
                                  "Số câu: ${nguoiChoi[0].soCauDung} \nĐiểm: ${nguoiChoi[index].tongDiem}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                          );
                        },
                      ),
                    ])),
              ),
            );
          }
          return Text('');
        });
  }
}
