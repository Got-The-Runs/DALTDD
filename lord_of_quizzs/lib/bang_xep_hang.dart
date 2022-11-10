import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BangXepHang extends StatefulWidget{
  const BangXepHang({super.key});
  @override
  State<StatefulWidget> createState() {
    return BangXepHangState();
  }
}

class BangXepHangState extends State<BangXepHang>{
  var items = ['Khoa Học Kỹ Thuật','Văn Hóa-Xã Hội-Nghệ Thuật','Lịch Sử-Địa Lý','Thể Thao' ];
  String? selectedItem = 'Khoa Học Kỹ Thuật';
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
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
            ),
            Container(
                padding: const EdgeInsets.all(15),
                child: const Text(
                  'Bảng Xếp Hạng',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                    ),
                child: DropdownButton(
                  value: selectedItem,
                  items:  items.map((String items) {
                    return DropdownMenuItem(                      
                      value: items,
                      child: Text(items, style: TextStyle(color: Colors.black),),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                    },
                  );
                }
              )
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
            ),
            Card(
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
                    title: Text('Player', style: TextStyle(fontSize: 20)),
                    subtitle: Text('4000', style: TextStyle(fontSize: 20),),
                  ),
              ),
           Card(
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
                    title: Text('Player', style: TextStyle(fontSize: 20)),
                    subtitle: Text('4000', style: TextStyle(fontSize: 20),),
                  ),
              ),
               Card(
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
                    title: Text('Player', style: TextStyle(fontSize: 20)),
                    subtitle: Text('4000', style: TextStyle(fontSize: 20),),
                  ),
              ),
               Card(
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
                    title: Text('Player', style: TextStyle(fontSize: 20)),
                    subtitle: Text('4000', style: TextStyle(fontSize: 20),),
                  ),
              ),
               Card(
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
                    title: Text('Player', style: TextStyle(fontSize: 20)),
                    subtitle: Text('4000', style: TextStyle(fontSize: 20),),
                  ),
              ),
          ],      
        ),
      )
    );
  }

}