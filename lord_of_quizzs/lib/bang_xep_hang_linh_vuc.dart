import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/model/linh_vuc_object.dart';
import 'package:lord_of_quizzs/model/linh_vuc_provider.dart';

// ignore: must_be_immutable
class BangXepHangLinhVuc extends StatefulWidget {
  String email;
  BangXepHangLinhVuc({Key? key,required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    // ignore: no_logic_in_create_state
    return ChonLinhVucBangXepHangState( email: email);
  }
}

class ChonLinhVucBangXepHangState extends State<BangXepHangLinhVuc> {
  String email;
  ChonLinhVucBangXepHangState({Key? key, required this.email});
  List<LinhVucObject> linhVuc = [];
  
  // ignore: non_constant_identifier_names
  void _LoadLinhVuc() async {
    final data = await LinhVucProvider.getData();
    setState(() {});
    linhVuc = data;
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _LoadLinhVuc();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
           centerTitle: true,
              toolbarHeight: 65,
              title: Text( 'Bảng Xếp Hạng \nLĩnh Vực',
                        style: TextStyle( fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center
               ),
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
                iconSize: 25,  
              ),
            ),
              body: Stack(
                children: [
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BangXepHang(idLinhVuc: linhVuc[index].idLinhVuc)
                                  )
                                );
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
  }
