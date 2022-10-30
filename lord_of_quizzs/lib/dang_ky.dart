// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:lord_of_quizzs/dang_nhap.dart';

class DangKi extends StatefulWidget {
  const DangKi({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return DangKiState();
  }
}

class DangKiState extends State<DangKi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Đăng ký'),
          backgroundColor: Colors.transparent, 
          elevation: 0, 
          leading: IconButton(
           icon: Icon(Icons.chevron_left),
           onPressed: () => Navigator.pop(context),
           iconSize: 30,  
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF701ebd),
              Color(0xFF873bcc),
              Color(0xFFfe4a97),
              Color(0xFFe17763),
              Color(0xFF68998c),
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
                padding: const EdgeInsets.all(35),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'images/Untitled-3.png',
                ),
              ),  
              Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Bạn chưa có tài khoản?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  style:const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Tên đăng nhập',
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
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                )
               ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
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
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  obscureText: true,
                  style:const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
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
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  obscureText: true,
                  style:const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
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
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: 200,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {},
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(110, 52, 243, 218)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
              )
            ],
          )
        ),
      ),
    );
  }
}
