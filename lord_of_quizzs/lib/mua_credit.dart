

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';

import 'model/thong_tin_provider.dart';

class MuaCredit extends StatefulWidget{
  String email;
  MuaCredit({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MuaCreditState(email: email);
  }
}

class MuaCreditState extends State<MuaCredit>{
  String email;
  MuaCreditState({Key? key, required this.email});

  final credit = ['100','300','700','1200','2500','5000','10.000','15.000','20.000'];
  final credit_Pri = [100,300,700,1200,2500,5000,10.000,15.000,20.000];
  final money = ['20.000 VND','50.000 VND','100.000 VND','200.000 VND','300.000 VND','600.000 VND','1.000.000VND','1.600.000VND','2.000.000VND'];
  bool selectionIsActive = false;
  var showCredit=0;
  late num credit_0 ;
  var docID;
  var querySnapshots;
  final _formKey = GlobalKey<FormState>();
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  Future<void> updateUser(var docID, int cre) {
    return user
        .doc(docID)
        .update({'tien_ao': cre});
  }


  @override
  Widget build(BuildContext context) {
     return FutureBuilder<List<ThongTinObject>>(
        future: ThongTinProvider.get(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ThongTinObject> thongTin = snapshot.data!;
            credit_0 = thongTin[0].money;
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
           Center(
            child: Text(
              credit_0.toString(),
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
              final item1 =credit_Pri[index];
              final item2 = money[index];
             return Container(
              
      padding: EdgeInsets.only(top: 10),
      color: Color.fromARGB(255, 131, 197, 8),
      child: GridTile(
        header: Icon(Icons.diamond_rounded, size: 50, color: Colors.white),
        child: Center(
          child: Text(item, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
        footer: TextButton(
          onPressed: () async {
                              try {
                                querySnapshots = await user.get();
                                for (var snapshot in querySnapshots.docs) {
                                  if (email == snapshot['email']) {
                                    docID = snapshot.id;
                                    credit_0 = snapshot['tien_ao'];
                                  }
                                }
                                credit_0 = credit_0 +item1;  
                                int creditd = int.parse(credit_0.toString());                 
                                updateUser(docID,creditd);
                                // setState(){

                                // };
                              } catch (e) {
                                final snackBar =
                                    SnackBar(content: Text('Có lỗi xảy ra !'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
          child: Text(
            item2,
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
          ),
      )
     );
  }
  

return Text('');
});
}}