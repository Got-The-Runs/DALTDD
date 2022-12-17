import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lord_of_quizzs/model/bang_xep_hang_object.dart';

class BangXepHangProvider {
//Lấy thông tin bảng xếp hạng theo lĩnh vực
  static Future<List<BangXepHangObject>> getdata(int idLinhVuc) async {
    List<BangXepHangObject> thongTinBangXepHang = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("bang_xep_hang")
        .where('id_linh_vuc', isEqualTo: idLinhVuc)
        .orderBy('tong_diem', descending: true)
        .get();
    thongTinBangXepHang = snapshot.docs
        .map((json) =>
            BangXepHangObject.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return thongTinBangXepHang;
  }
//lấy thông tin tất cả bảng xếp hạng
  static Future<List<BangXepHangObject>> getAllBXH() async {
    List<BangXepHangObject> thongTinBangXepHang = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("bang_xep_hang")
        .get();
    thongTinBangXepHang = snapshot.docs
        .map((json) =>
            BangXepHangObject.fromJson(json.data() as Map<String, dynamic>))
        .toList();
    return thongTinBangXepHang;
  }
}
