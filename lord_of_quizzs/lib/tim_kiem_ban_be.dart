import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/ban_be_object.dart';
import 'package:lord_of_quizzs/model/ban_be_provider.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class TimKiemBanBe extends StatefulWidget{
  String email;
  TimKiemBanBe({Key? key, required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TimKiemBanBeState(email: email);
  }
}
class TimKiemBanBeState extends State<TimKiemBanBe>{
   String email;
  TimKiemBanBeState({Key? key, required this.email});
  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  CollectionReference loiMoiKetBan = FirebaseFirestore.instance.collection("ban_be");
  var txtSreach = TextEditingController();
  String fill = "";
    var querySnapshots;
  late String temp;
  var docID;
  List<ThongTinObject> thongTin=[];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool laBanBe = false, laBanBeAccept = false;
  bool checkLaBanBe = false, checkLaBanBeAccept = false;
  void getEmail() async {
    final user = _auth.currentUser;
    if (user != null) {
      email = user.email.toString();
    }
  }
  Future<void> insertLoiMoi(var emailBB) {
    return loiMoiKetBan.add({
      'email':email,
      'email_ban_be':emailBB,
      'trang_thai':2});
        
  }
  Future<void> insertGuiLoiMoi(var emailBB) {
    return loiMoiKetBan.add({
      'email':emailBB,
      'email_ban_be':email,
      'trang_thai':0});   
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
                  icon: Icon(FontAwesomeIcons.magnifyingGlass),
                  iconSize: 20,
                  onPressed: () async {
                    //  if(txtSreach.text != ""){
                        try {
                          thongTin.clear();
                                  querySnapshots = await user.get();
                                    for (var snapshot in querySnapshots.docs) {
                                      temp = snapshot['ten_nguoi_choi'];
                                      if ( temp.toUpperCase().contains(txtSreach.text.toUpperCase()) == true && snapshot['email'] != email) {
                                        ThongTinObject obj = ThongTinObject(snapshot['ten_nguoi_choi'], snapshot['email'], 0, 1);  
                                        thongTin.add(obj);
                                      }
                                    }
                                    setState(() {
                                      
                                    });
                                    
                                  } catch (e) {
                                    final snackBar =
                                        SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text('L???i k???t n???i'));
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
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "T??m ki???m",
                        border: InputBorder.none,
                        hintStyle:  TextStyle(color: Colors.white),
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
                             future: BanBeProvider.getBanBeRequest1(email),
                             builder: (context, snapshot) {
                               if (snapshot.hasData) {
                                List<BanBeObject> banBeAccept = snapshot.data!;
                                for(int i=0;i<banBe.length;i++){
                                  if(thongTin[index].email == banBe[i].emailBanBe){                  
                                     laBanBe = true;
                                     break;
                                  }
                                  else{
                                    laBanBe = false;
                                  }
                                }
                                for(int j=0; j<banBeAccept.length;j++){
                                  if(thongTin[index].email == banBeAccept[j].emailBanBe){
                                    laBanBeAccept = true;
                                    break;
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
                                        trailing: IconButton(icon: Icon(laBanBe == true?Icons.people:laBanBeAccept==true?FontAwesomeIcons.spinner:Icons.person_add),
                                          onPressed: (){
                                            setState((){
                                              for(int i=0;i<banBe.length;i++){
                                                if(thongTin[index].email == banBe[i].emailBanBe){                  
                                                  checkLaBanBe = true;
                                                  break;
                                                }
                                              }
                                               for(int j=0; j<banBeAccept.length;j++){
                                                if(thongTin[index].email == banBeAccept[j].emailBanBe){
                                                  checkLaBanBeAccept = true;
                                                  break;
                                                }
                                              }
                                          if(checkLaBanBe == true && checkLaBanBeAccept == false){
                                              final snackBar = SnackBar(
                                                duration: Duration(seconds: 2),
                                                content: Text('B???n v?? ${thongTin[index].name} ??ang l?? b???n b??'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            checkLaBanBeAccept = false;
                                            checkLaBanBe = false;
                                          }
                                          else if (checkLaBanBeAccept == true && checkLaBanBe == false){
                                             for(int i=0; i<banBeAccept.length;i++){
                                                if(thongTin[index].email == banBeAccept[i].emailBanBe && banBeAccept[i].trangThai == 2){
                                                  final snackBar = SnackBar(
                                                        duration: Duration(seconds: 2),
                                                        content: Text('??ang ch??? ${thongTin[index].name} ch???p nh???n k???t b???n'));
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    checkLaBanBeAccept = false;
                                                    checkLaBanBe = false;
                                                  break;
                                                  }
                                                }
                                                  for(int i=0; i<banBeAccept.length;i++){
                                                if(thongTin[index].email == banBeAccept[i].emailBanBe && banBeAccept[i].trangThai == 0){
                                                            final snackBar = SnackBar(
                                                          duration: Duration(seconds: 2),
                                                          content: Text('${thongTin[index].name} ??ang ch??? b???n ch???p nh???n k???t b???n'));
                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                      checkLaBanBeAccept = false;
                                                      checkLaBanBe = false;
                                                  break;
                                                  }
                                                }    
                                          }
                                          else {
                                            insertLoiMoi(thongTin[index].email);
                                            insertGuiLoiMoi(thongTin[index].email);
                                            final snackBar = SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: Text('G???i l???i m???i k???t b???n th??nh c??ng'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                                            setState((){
                                              checkLaBanBeAccept = false;
                                              checkLaBanBe = false;
                                            });                 

                                        }
                                      }
                                    );   
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
  