import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  CollectionReference thongTinBanBe = FirebaseFirestore.instance.collection("ban_be");
  String email = "";  
  String emailBanBe ="";
 var docID, docID2,querySnapshots; 
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
  Future<void> deleteBanBe(var docID){
      return thongTinBanBe.doc(docID).delete();
  }
  Future<void> updateBanBe(var docID) {
    return thongTinBanBe
        .doc(docID)
        .update({'trang_thai': 1});
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
                                          trailing: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                            IconButton(icon: Icon(FontAwesomeIcons.userXmark), onPressed: ()async {
                                              try {
                                                querySnapshots = await thongTinBanBe.get();
                                                for (var snapshot in querySnapshots.docs) {
                                                  if (email == snapshot['email'] && banBe[index].emailBanBe == snapshot['email_ban_be']) {
                                                    docID = snapshot.id;
                                                    deleteBanBe(docID);
                                                    break;
                                                  }
                                                }    
                                                for (var snapshot in querySnapshots.docs) {
                                                  if (email == snapshot['email_ban_be'] && banBe[index].emailBanBe == snapshot['email']) {
                                                    docID2 = snapshot.id;
                                                    deleteBanBe(docID2);
                                                    break;
                                                  }
                                                }           
                                                final snackBar =
                                                    SnackBar(
                                                      duration: Duration(seconds: 1),
                                                      content: Text('Xóa lời mời thành công'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);  
                                                    setState((){});                                                   
                                              } catch (e) {
                                                final snackBar =
                                                    SnackBar(
                                                      duration: Duration(seconds: 1),
                                                      content: Text('Có lỗi xảy ra !'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                          }
                                        ),
                                            IconButton(icon: Icon(FontAwesomeIcons.userCheck), onPressed: ()async{
                                               try {
                                                querySnapshots = await thongTinBanBe.get();
                                                for (var snapshot in querySnapshots.docs) {
                                                  if (email == snapshot['email'] && banBe[index].emailBanBe == snapshot['email_ban_be']) {
                                                    docID = snapshot.id;
                                                    updateBanBe(docID);
                                                    break;
                                                  }
                                                }    
                                                for (var snapshot in querySnapshots.docs) {
                                                  if (email == snapshot['email_ban_be'] && banBe[index].emailBanBe == snapshot['email']) {
                                                    docID2 = snapshot.id;
                                                    updateBanBe(docID2);
                                                    break;
                                                  }
                                                }           
                                                final snackBar =
                                                    SnackBar(
                                                      duration: Duration(seconds: 1),
                                                      content: Text('Chấp nhận lời mời thành công'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);  
                                                    setState((){});                                                   
                                              } catch (e) {
                                                final snackBar =
                                                    SnackBar(
                                                      duration: Duration(seconds: 1),
                                                      content: Text('Có lỗi xảy ra !'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                          }
                                        ),
                                    ],
                                  )
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
