import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/bang_xep_hang_object.dart';
import 'package:lord_of_quizzs/model/bang_xep_hang_provider.dart';
import 'package:lord_of_quizzs/model/linh_vuc_object.dart';
import 'package:lord_of_quizzs/model/linh_vuc_provider.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';

// ignore: must_be_immutable
class BangXepHang extends StatefulWidget{
  int idLinhVuc;
  BangXepHang({Key? key, required this.idLinhVuc}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return BangXepHangState(idLinhVuc: idLinhVuc);
  }
}

class BangXepHangState extends State<BangXepHang>{
  int idLinhVuc;
  BangXepHangState({Key? key, required this.idLinhVuc});
  List<BangXepHangObject> bangXepHang = [];
  String tenNguoiChoi ="";
  // ignore: non_constant_identifier_names
  void _LoadBangXepHang() async {
    final data = await BangXepHangProvider.getdata(idLinhVuc);
    setState(() {});
    bangXepHang = data;
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _LoadBangXepHang();
  }
  @override
  Widget build(BuildContext context) {
   return FutureBuilder<List<LinhVucObject>>(
      future: LinhVucProvider.getDataByID(idLinhVuc),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<LinhVucObject> linhVuc = snapshot.data!;    
          return Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 65,
              title: Text( 'Bảng Xếp Hạng \n${linhVuc[0].tenLinhVuc}',
                        style: TextStyle( fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center
                      ),
              // elevation: 0,
              // backgroundColor: Colors.transparent,
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
              children:[
              Container(
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
              ),
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  shrinkWrap: true,
                  itemCount: bangXepHang.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder<List<ThongTinObject>>(
                       future: ThongTinProvider.getEmail(),
                       builder: (context, snapshot) {
                          if (snapshot.hasData) {
                             List<ThongTinObject> thongTin = snapshot.data!;
                             for(int i=0; i< thongTin.length; i++)
                             {
                                if(bangXepHang[index].email == thongTin[i].email){
                                   tenNguoiChoi= thongTin[i].name;
                                 }
                             }
                        return Card(
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
                              title: Text( tenNguoiChoi, style: TextStyle(fontSize: 20)),
                              subtitle: Text('${bangXepHang[index].tongDiem}', style: TextStyle(fontSize: 20),),
                              trailing: Text("${index + 1}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              ),
                            );  
                          }
                        return Text('');
                      }
                    );      
                  },
                ),        
              ]
            )
          );
        }   
        return Text('');
      }
    );
  }
}