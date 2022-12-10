import 'package:flutter/material.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_provider.dart';
import 'model/nguoi_choi_object.dart';

class HuongDan extends StatefulWidget {
  HuongDan({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return HuongDanState();
  }
}

class HuongDanState extends State<HuongDan> {
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
              ),
              body: Container(
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
           child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                      Container(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: const Text(
                          'Hướng Dẫn Chơi',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                    ),              
                  ),         
                  Card(
                        margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            shadowColor: Colors.blueGrey,
                            child: ListTile(
                              title: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text('1. Cách chơi', style: TextStyle(fontWeight: FontWeight.bold),),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft,
                                child: Container(
                                     padding: EdgeInsets.all(5),
                                  child: Text('   - Bạn chọn chơi mới để bắt đầu trò chơi, tiếp theo chọn lĩnh vực muốn chơi, sau đó bạn sẽ được chuyển đến màn hình trả lời câu hỏi để bắt đầu trò chơi.', style: TextStyle(fontSize: 15),),
                                )),  
                                Align(
                                  alignment: Alignment.centerLeft,                     
                                child: Container(
                                     padding: EdgeInsets.all(5),
                                  child: Text('   - Sau khi chơi xong 1 lượt bạn có thể xem lại số điểm và số câu đạt được trong Lịch Sử.' ,style: TextStyle(fontSize: 15)),
                                )),     
                                Align(
                                  alignment: Alignment.centerLeft, 
                                 child: Container(
                                  child: Text('2. Luật chơi' , style: TextStyle(fontWeight: FontWeight.bold)),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft, 
                                  child: Container(
                                       padding: EdgeInsets.all(5),
                                  child: Text('   - Bạn sẽ có 5 mạng mỗi lần chơi.' ,style: TextStyle(fontSize: 15)),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft, 
                                  child: Container(
                                       padding: EdgeInsets.all(5),
                                  child: Text('   - Thời gian trả lời cho mỗi câu hỏi là 30 giây.' ,style: TextStyle(fontSize: 15)),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft, 
                                  child: Container(
                                       padding: EdgeInsets.all(5),
                                  child: Text('   - Trả lời sai sẽ bị trừ  1 mạng, bị trừ hết mạng sẽ kết thúc trò chơi.' ,style: TextStyle(fontSize: 15)),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft, 
                                  child: Container(
                                       padding: EdgeInsets.all(5),
                                  child: Text('   - Không trả lời sẽ bị trừ 1 mạng, bị trừ hết mạng sẽ kết thúc trò chơi' ,style: TextStyle(fontSize: 15)),
                                )),
                                 Align(
                                  alignment: Alignment.centerLeft, 
                                  child: Container(
                                       padding: EdgeInsets.all(5),
                                  child: Text('   - Khi trả lời đúng sẽ được cộng điểm theo công thức sau: 100*Số thời gian còn lại',style: TextStyle(fontSize: 15)),
                                )),
                                 Align(
                                  alignment: Alignment.centerLeft, 
                                 child: Container(
                                     padding: EdgeInsets.all(5),
                                  child: Text('   - Sau khi kết thúc trò chơi sẽ hiện lên thông báo số điểm của bạn.' ,style: TextStyle(fontSize: 15)),
                                )),
                               Align(
                                  alignment: Alignment.centerLeft, 
                                child: Container(
                                  child: Text('3. Các chức năng trợ giúp' , style: TextStyle(fontWeight: FontWeight.bold)),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft, 
                                child: Container(
                                     padding: EdgeInsets.all(5),
                                  child: Text('   - Bạn sẽ có 4 chức năng trợ giúp trong đó 3 chức năng 50:50, trợ giúp từ khán giả và gọi điện từ người thân chỉ được dùng 1 lần trong 1 lượt chơi.' ,style: TextStyle(fontSize: 15)),
                                )),
                               Align(
                                  alignment: Alignment.centerLeft, 
                                child: Container(
                                     padding: EdgeInsets.all(5),
                                  child: Text('   - 50:50 giúp cho bạn loại 2 đáp án sai và để lại 2 đáp án trong đó có 1 đáp án đúng.' ,style: TextStyle(fontSize: 15)),
                                )),
                                Align(
                                  alignment: Alignment.centerLeft, 
                                child: Container(
                                        padding: EdgeInsets.all(5),
                                  child: Text('   - Trợ giúp từ khán giả sẽ hiện lên tỉ lệ % đáp án đúng mà khán giả bình chọn.' ,style: TextStyle(fontSize: 15)),
                                )),
                               Align(
                                  alignment: Alignment.centerLeft, 
                                child: Container(
                                        padding: EdgeInsets.all(5),
                                  child: Text('   - Gọi điện từ người thân sẽ hiện lên đáp án mà người thân gợi ý cho bạn.' ,style: TextStyle(fontSize: 15)),
                                )),
                              Align(
                                  alignment: Alignment.centerLeft, 
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text('   - Mua đáp án bằng credit sẽ dùng credit bạn có để mua đáp án, số credit cần mua đáp án sẽ tăng theo số lần bạn mua.' ,style: TextStyle(fontSize: 15)),
                                )),
                              ],
                            )
                   ),
                  )
                ],
              )
          ),
              ),
    );
  }
}
