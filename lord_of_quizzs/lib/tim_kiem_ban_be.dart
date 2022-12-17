import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/ban_be_object.dart';
import 'package:lord_of_quizzs/model/ban_be_provider.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';

class TimKiemBanBe extends StatefulWidget{
  // String email;
  // TimKiemBanBe({Key? key, required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TimKiemBanBeState();
  }

}
class TimKiemBanBeState extends State<TimKiemBanBe>{
  //  String email;
  // TimKiemBanBeState({Key? key, required this.email});
  var txtEmail = TextEditingController();
  String fill = "b";
  @override
  Widget build(BuildContext context) {
     return FutureBuilder<List<ThongTinObject>>(
        future: ThongTinProvider.fill(fill),
      builder: (context, snapshot){
         List<ThongTinObject> thongTin = snapshot.data!;
           return Scaffold(
             extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
           );


      }
        );
  }


}