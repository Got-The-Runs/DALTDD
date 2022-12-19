import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/danh_sach_ban_be.dart';
import 'package:lord_of_quizzs/loi_moi.dart';
import 'package:lord_of_quizzs/tim_kiem_ban_be.dart';

class BanBe extends StatefulWidget{
  String email;
  BanBe({Key? key, required this.email}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BanBeState(email: email);
  }
}

class BanBeState extends State<BanBe> with SingleTickerProviderStateMixin{
   String email;
  BanBeState({Key? key, required this.email});
  late TabController tabs;
  @override
  void initState() {
    super.initState();
    tabs = TabController(length: 2,vsync: this); 
    tabs.addListener( () {
      setState(() {});      
      });
  }
  @override
  void dispose(){
    tabs.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         toolbarHeight: 40,
         leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => Navigator.pop(context),
                  iconSize: 30,
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
              actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.person_add),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TimKiemBanBe(email: email,),
                            ));
                      }),
                      iconSize: 30,
                    ),
                    Padding(padding: EdgeInsets.only(right: 20))
                  ],
        bottom: TabBar(
          controller: tabs,
          tabs:const [
            Tab(text: 'Danh Sách Bạn Bè', icon: Icon(Icons.people)), 
            Tab(text: 'Lời mời kết bạn', icon: Icon(Icons.group_add),)       
          ],
        ),
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
        TabBarView(
              controller: tabs,
             children: [
              DanhSachBanBe(),
              LoiMoi(),
            ],
          ),
        ]
      )
    );
  }
}