import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_provider.dart';
import 'model/nguoi_choi_object.dart';

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
  List<NguoiChoiObject> nguoiChoi = [];
  void _LoadNguoiChoi() async {
    final data = await NguoiChoiProvider.getdata(email);
    setState(() {});
    nguoiChoi = data;
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return FutureBuilder<List<NguoiChoiObject>>(
        future: NguoiChoiProvider.getdata(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NguoiChoiObject> nguoiChoi = snapshot.data!;
            return Scaffold(
              // extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                title: Text( 'Lịch sử chơi', style: TextStyle( fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                ),
                // elevation: 0,
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
                // backgroundColor: Colors.lightBlue,
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => Navigator.pop(context),
                  iconSize: 30,
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
                  ListView.builder(
                        padding: EdgeInsets.only(bottom: 20, top: 10),
                        shrinkWrap: true,
                        itemCount: nguoiChoi.length,
                        itemBuilder: (BuildContext context, int index) {
                            return Card(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            shadowColor: Colors.blueGrey,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset('images/Logo.png'),
                              ),   
                              title: Text(nguoiChoi[index].tenNguoiChoi,
                                  style: TextStyle(fontSize: 20)),
                              subtitle: Text(
                                nguoiChoi[index].ngayChoi,
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: Text(
                                  "Số câu: ${nguoiChoi[index].soCauDung} \nĐiểm: ${nguoiChoi[index].tongDiem}",
                                  style: TextStyle(
                                    fontSize: 20,
                            )
                          ) ,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        return Text('');
      }
    );
  }
}
