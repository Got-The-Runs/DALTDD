import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/bang_xep_hang.dart';
import 'package:lord_of_quizzs/chon_linh_vuc.dart';
import 'package:lord_of_quizzs/man_hinh_doi_mat_khau.dart';
import 'package:lord_of_quizzs/mua_credit.dart';

class LichSu extends StatefulWidget {
  String email;
  LichSu({Key? key, required this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return LichSuState(email: email);
  }
}

class LichSuState extends State<LichSu> {
  String email;
  LichSuState({Key? key, required this.email});
  @override
  // ignore: dead_code
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
        actions: <Widget> [
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
            icon: const Icon(Icons.add_circle_outline),
            onPressed: (() {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MuaCredit(email:email ,),  
                )
               );
            }),
            iconSize: 30,
          ),
        ]
      ),
      body: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
              ),
             
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Text(
                  'Lịch sử chơi',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: 
              EdgeInsets.all(15),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 370,
                height: 85,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('Tên người chơi',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        
                        child: Text('Điểm: 2503',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topRight
                      ),    
                      ],
                     ), 
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('4/10/2022',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(
                        child: Text('Số câu: 30',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomRight
                      ),    
                      
                    ],
                  )
                    ]   
              ),
              ),
              ),
              Padding(padding: 
              EdgeInsets.all(10),
              child:  Container(
                padding: EdgeInsets.all(10),
                width: 370,
                height: 85,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('Tên người chơi',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        
                        child: Text('Điểm: 2203',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topRight
                      ),    
                      ],
                     ), 
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('3/10/2022',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(
                        child: Text('Số câu: 25',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomRight
                      ),    
                      
                    ],
                  )
                    ]   
              ),
              ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                padding: EdgeInsets.all(10),
                width: 370,
                height: 85,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('Tên người chơi',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        
                        child: Text('Điểm: 3020',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topRight
                      ),    
                      ],
                     ), 
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('2/10/2022',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(
                        child: Text('Số câu: 35',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomRight
                      ),    
                      
                    ],
                  )
                    ]   
              ),
              ), 
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                padding: EdgeInsets.all(10),
                width: 370,
                height: 85,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('Tên người chơi',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        
                        child: Text('Điểm: 1530',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.topRight
                      ),    
                      ],
                     ), 
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                        child: Text('29/9/2022',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(
                        child: Text('Số câu: 16',
                        style: TextStyle(fontSize: 20, color: Colors.white),),
                        alignment: Alignment.bottomRight
                      ),    
                      
                    ],
                  )
                    ]   
              ),
              ),)
              
              
          ])
            ),
          );
        ;
  }
}
