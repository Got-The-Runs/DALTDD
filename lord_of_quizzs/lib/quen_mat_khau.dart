// ignore: unnecessary_import
// ignore: unnecessary_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class QuenMatKhau extends StatefulWidget{
  const QuenMatKhau({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return QuenMatKhauState();
  }
}

class QuenMatKhauState extends State<QuenMatKhau> {

  final _formKey = GlobalKey<FormState>();
  var txtEmail = TextEditingController();
  var txtMatKhau = TextEditingController();
  var txtMatKhauXT = TextEditingController();

  var querySnapshots;
  var documentID;
  var passNow;
  final _auth = FirebaseAuth.instance;

  CollectionReference user = FirebaseFirestore.instance.collection("thong_tin");
  Future<void> updateUser(var docID){
    return user
    .doc(docID)
    .update({'mat_khau' : passNow})
    .then((value) => Navigator.pop(context, 'Quên mật khẩu thành công'))
    .catchError((error) => Navigator.pop(context, 'Quên mật khẩu thất bại $error'));   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,   
        backgroundColor: Colors.transparent,     
        leading: IconButton(
          icon:const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          iconSize: 35,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF701ebd),
            Color.fromARGB(255, 57, 86, 250),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          ),
        ),  
        child: SingleChildScrollView(
            // physics:const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60),
                child: Image.asset(
                  'images/Logo.png',
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120
                ),
              ),     
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Text('Bạn quên mật khẩu?',
                  style: TextStyle(fontSize: 15, 
                  color: Colors.white,
                  fontWeight: FontWeight.bold ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child:  TextField(
                  controller: txtEmail,
                  style:const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder:  OutlineInputBorder(
                        borderSide:const BorderSide(
                          color: Colors.white
                        ),                   
                        borderRadius: BorderRadius.circular(25),
                      ),       
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ), 
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(15),
              width: 200,
              height: 80,
              child: OutlinedButton(       
                onPressed: () async {
                      try{
                          querySnapshots = await user.get();
                          for (var snapshot in querySnapshots.docs) {
                          if(txtEmail.text == snapshot['email']){
                            documentID = snapshot.id;
                          }
  }
                        if(txtMatKhau.text == txtMatKhauXT.text){  
                          final user = _auth.sendPasswordResetEmail(email: txtEmail.text);

                          // for (var snapshot in querySnapshots.docs) {
                          //   if(txtEmail.text == snapshot['email']){
                          //     documentID = snapshot.id;
                          //     passNow = snapshot['mat_khau'];
                          //   }   
                          // }
                          // updateUser(documentID);
                            Navigator.pop(context, 'Quên mật khẩu thành công');
                            
                          }else {
                            final snackBar = SnackBar(content: Text('Mật khẩu xác nhận không trùng khớp'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                      }
                      catch(e){
                        final snackBar = SnackBar(content: Text('Có lỗi xảy ra !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }                       
                                                         
                  },
                // ignore: sort_child_properties_last
                child: const Text('Xác nhận', 
                  style: TextStyle(fontSize: 20,
                  color: Colors.white),
                ), 
                style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Colors.transparent),  
                   side: MaterialStateProperty.all(                 
                    const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                      style: BorderStyle.solid
                    )
                  )              
                ),  
               ),
              ),
            ],    
          ),
        ),
      ),
    );
  }
}
