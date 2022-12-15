import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/ban_be_object.dart';
import 'package:lord_of_quizzs/model/ban_be_provider.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';

class LoiMoi extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoiMoiState();
  }
}

class LoiMoiState extends State<LoiMoi>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  String email = "";  
  String emailBanBe ="";

  void getEmail() async {
    final user = _auth.currentUser;
    if (user != null) {
      email = user.email.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  FutureBuilder<List<BanBeObject>>(
             future: BanBeProvider.getBanBeRequest(email),
              builder: (context, snapshot) {
               if (snapshot.hasData) {
                List<BanBeObject> banBe = snapshot.data!;
                return Scaffold(
                  body: Stack( 
                    children: [
                        Container(
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
                          itemCount: banBe.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {                   
                           return FutureBuilder<List<ThongTinObject>>(
                             future: ThongTinProvider.getEmail(),
                             builder: (context, snapshot) {
                               if (snapshot.hasData) {
                                  List<ThongTinObject> thongTin = snapshot.data!;
                                  for(int i=0; i< thongTin.length; i++)
                                  {
                                     if(banBe[index].emailBanBe == thongTin[i].email){
                                        emailBanBe= thongTin[i].name;
                                     }
                                  }
                                  return Card(
                                    margin: EdgeInsets.only(left: 20,right: 20, top: 7, bottom: 7),
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
                                          title: Text('${emailBanBe}'),
                                          // subtitle: Text('T', style: TextStyle(fontSize: 20),),
                                          trailing: IconButton(icon: Icon(Icons.check), onPressed: (){}),
                               ),
                             );  
                           }
                         return Text('');
                       }
                     );    
                   }         
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
