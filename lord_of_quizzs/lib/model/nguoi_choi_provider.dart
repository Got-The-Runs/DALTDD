import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_object.dart';

class NguoiChoiProvider {

  static Future<List<NguoiChoiObject>> getdata(String email) async {
    List<NguoiChoiObject> ThongTinChoi = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("nguoi_choi")
        .where('email', isEqualTo: email)
        .orderBy('ngay_choi_2', descending: true)
        .get();
    ThongTinChoi = snapshot.docs
        .map((json) =>
            NguoiChoiObject.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return ThongTinChoi;
  }
}
