import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MuaCredit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MuaCreditState();
  }
}

class MuaCreditState extends State<MuaCredit>{
  final credit = ['100','300','700','1200','2500','5000','10.000','15.000','20.000'];
  final money = ['20.000 VND','50.000 VND','100.000 VND','200.000 VND','300.000 VND','600.000 VND','1.000.000VND','1.600.000VND','2.000.000VND'];
  bool selectionIsActive = false;
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
        actions: <Widget>[
          const Icon(Icons.diamond_rounded, size: 30),
          const Center(
            child: Text(
              '9999',
                style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                ),
              ),
            ),
          IconButton(
            disabledColor: Colors.redAccent,
            icon: const Icon(Icons.add_circle_outline),
            onPressed: selectionIsActive
              ? null: () {
                setState(() {
                  selectionIsActive = true;
                });
              },
            iconSize: 30,
          ),
        ],
        bottom: PreferredSize(
        child: Text("Cửa hàng Credit", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
        preferredSize: Size.fromHeight(50)),
      ),
      body:Container(
        padding: EdgeInsets.only(top: 150),
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
     child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (1/1.25), 
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ), 
            padding: EdgeInsets.all(10),
            itemCount: credit.length,
            itemBuilder:(context, index) {
              final item = credit[index];
              final item2 = money[index];
              return buildCredit(item, item2);
            }
          ),
      )
     );
  }
  
  Widget buildCredit(String item, String money) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Color.fromARGB(255, 131, 197, 8),
      child: GridTile(
        header: Icon(Icons.diamond_rounded, size: 50, color: Colors.white),
        child: Center(
          child: Text(item, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
        footer: TextButton(
          onPressed: () {},
          child: Text(
            money,
             style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 20,
                color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
      ),
    );
  }

}