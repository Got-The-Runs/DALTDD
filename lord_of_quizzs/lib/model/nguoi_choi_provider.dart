import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lord_of_quizzs/model/nguoi_choi_object.dart';

class NguoiChoiProvider{
  static Future<List<NguoiChoiObject>> getNguoiChoi(int idLinhVuc) async {
    List<NguoiChoiObject> ThongTinChoi = [];
    final snapshot = await FirebaseFirestore.instance.collection("nguoi_choi")
    .where('id_linh_vuc', isEqualTo: idLinhVuc).orderBy('tong_diem', descending: true).get();
    // .orderBy('tong_diem', descending: true)
    // ignore: no_leading_underscores_for_local_identifiers
     ThongTinChoi = snapshot.docs.map((json) => NguoiChoiObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return ThongTinChoi;
  }
}
