import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/linh_vuc_object.dart';
import 'package:lord_of_quizzs/model/linh_vuc_provider.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_object.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_provider.dart';

import 'mua_credit.dart';

class BangXepHang extends StatefulWidget{
  int idLinhVuc;
  BangXepHang({Key? key, required this.idLinhVuc}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return BangXepHangState(idLinhVuc: idLinhVuc);
  }
}

class BangXepHangState extends State<BangXepHang>{
  int idLinhVuc;
  BangXepHangState({Key? key, required this.idLinhVuc});
  List<NguoiChoiObject> nguoiChoi = [];
  void _LoadNguoiChoi() async {
    final data = await NguoiChoiProvider.getNguoiChoi(idLinhVuc);
    setState(() {});
    nguoiChoi = data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadNguoiChoi();
  }
  @override
  Widget build(BuildContext context) {
   return FutureBuilder<List<LinhVucObject>>(
      future: LinhVucProvider.getDataByID(idLinhVuc),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<LinhVucObject> linhVuc = snapshot.data!;    
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
                  gradient: LinearGradient(colors: 
                  [
                    Color(0xFF701ebd),
                    Color.fromARGB(255, 57, 86, 250),
                    // Color(0xFF701ebd),
                    // Color(0xFF873bcc),
                    // Color(0xFFfe4a97),
                    // Color(0xFFe17763),
                    // Color(0xFF68998c),
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
                    padding: const EdgeInsets.all(15),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: Text(
                        'Bảng Xếp Hạng \n${linhVuc[0].tenLinhVuc}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                      ),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(bottom: 20, top: 10),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: nguoiChoi.length,
                        itemBuilder: (BuildContext context, int index) {
                        return  Card(
                        margin: EdgeInsets.only(left: 20,right: 20, top: 5, bottom: 5),
                          shape:const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20),
                              ),
                            ),
                            shadowColor: Colors.blueGrey,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset('images/Logo.png'),
                              ),           
                              title: Text(nguoiChoi[index].tenNguoiChoi, style: TextStyle(fontSize: 20)),
                              subtitle: Text('${nguoiChoi[index].tongDiem}', style: TextStyle(fontSize: 20),),
                              trailing: Text("${index + 1}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                        );        
                      },
                  ),        
                ],      
              ),
            ),
            )
          );
        }   
          return Text('');
      }
    );
  }
}