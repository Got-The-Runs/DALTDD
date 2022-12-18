// ignore: unnecessary_import
// ignore: unnecessary_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class QuenMatKhau extends StatefulWidget {
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
  Future<void> updateUser(var docID) {
    return user
        .doc(docID)
        .update({'mat_khau': passNow})
        .then((value) => Navigator.pop(context, 'Quên mật khẩu thành công'))
        .catchError(
            (error) => Navigator.pop(context, 'Quên mật khẩu thất bại $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
              centerTitle: true,
              title: const Text( 'Quên Mật Khẩu',
                        style: TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
      children: [
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
      SingleChildScrollView(
          // physics:const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70, bottom: 10),
                child: Image.asset('images/Logo.png',
                    fit: BoxFit.cover, height: 110, width: 110),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Text(
                  'Bạn quên mật khẩu?',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: txtEmail,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
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
                    if (txtEmail.text == "") {
                      final snackBar =
                          SnackBar(content: Text('Chưa nhập Email'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      try {
                        querySnapshots = await user.get();
                        for (var snapshot in querySnapshots.docs) {
                          if (txtEmail.text == snapshot['email']) {
                            documentID = snapshot.id;
                            final user = await _auth.sendPasswordResetEmail(
                                email: txtEmail.text);
                            Navigator.pop(context, 'Gửi mã xác nhận thành công');
                          }
                        }
                        if(documentID == null){
                          final snackBar =
                          SnackBar(content: Text('Email chưa được đăng ký tài khoản'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } 
                      } catch (e) {
                        final snackBar =
                            SnackBar(content: Text('Có lỗi xảy ra!'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Gửi ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                          style: BorderStyle.solid))),
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}
