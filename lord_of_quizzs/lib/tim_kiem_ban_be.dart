import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/ban_be_object.dart';
import 'package:lord_of_quizzs/model/ban_be_provider.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:lord_of_quizzs/model/thong_tin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  var txtSreach = TextEditingController();
  String fill = "";
    var querySnapshots;
  late String temp;
  List<ThongTinObject> thongTin=[];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  bool laBanBe = false, laBanBeAccept = false;
  void getEmail() async {
    final user = _auth.currentUser;
    if (user != null) {
      email = user.email.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
          getEmail();
           return FutureBuilder<List<BanBeObject>>(
             future: BanBeProvider.getBanBe(email),
              builder: (context, snapshot) {
               if (snapshot.hasData) {
                List<BanBeObject> banBe = snapshot.data!;
                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      toolbarHeight: 65,
    title: Row(
      textDirection: TextDirection.rtl,
              children: [
                Container(
                child: 
                IconButton(
                  icon: Icon(Icons.find_replace_outlined),
                  onPressed: () async {
                    //  if(txtSreach.text != ""){
                        try {
                          thongTin.clear();
                                  querySnapshots = await user.get();
                                    for (var snapshot in querySnapshots.docs) {
                                      temp = snapshot['ten_nguoi_choi'];
                                      if ( temp.toUpperCase().contains(txtSreach.text.toUpperCase()) == true) {
                                        ThongTinObject Obj = ThongTinObject(snapshot['ten_nguoi_choi'], snapshot['email'], 0, 1);  
                                        thongTin.add(Obj);
                                      }
                                    }
                                  } catch (e) {
                                    final snackBar =
                                        SnackBar(content: Text('Không tìm thấy'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                      // }
                      
                  },
                ),
                ),
                Expanded(
                  child: TextField(
                    controller: txtSreach,
                    decoration: const InputDecoration(
                        hintText:"Tìm kiếm",
                        border: InputBorder.none,
                    ),
                  ),
                ),
              ],
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
                  itemCount: thongTin.length == 0?0:thongTin.length,
                  itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder<List<BanBeObject>>(
                             future: BanBeProvider.getBanBeRequest(email),
                             builder: (context, snapshot) {
                               if (snapshot.hasData) {
                                List<BanBeObject> banBeAccept = snapshot.data!;
                                for(int i=0;i<banBe.length;i++){
                                  if(thongTin[index].email == banBe[i].emailBanBe){                  
                                     laBanBe = true;
                                  }
                                  else{
                                    laBanBe = false;
                                  }
                                }
                                for(int j=0; j<banBeAccept.length;j++){
                                  if(thongTin[index].email == banBeAccept[j].emailBanBe){
                                    laBanBeAccept = true;
                                  } else{
                                    laBanBeAccept = false;
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
                                        title: Text( thongTin[index].name, style: TextStyle(fontSize: 20)),
                                        trailing: IconButton(icon: Icon(laBanBe == true?Icons.people:laBanBeAccept==true?Icons.replay_outlined:Icons.person_add),
                                          onPressed: (){
                                          if(laBanBe == true && laBanBeAccept == false){
                                              final snackBar = SnackBar(content: Text('Bạn và ${thongTin[index].name} đang là bạn bè'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                          if(laBanBeAccept == true && laBanBe == false){
                                              final snackBar = SnackBar(content: Text('Đang chờ ${thongTin[index].name} chấp nhận kết bạn'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                  },
                                ),    
                              ),
                            );  
                          }
                          return Text('');
                        }
                      );        
                    }               
                  )            
                ]
              ),
            );
           }
         return Text('');
        }
      );
    }
  }