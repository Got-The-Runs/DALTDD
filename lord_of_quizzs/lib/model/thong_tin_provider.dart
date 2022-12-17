import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lord_of_quizzs/model/thong_tin_object.dart';

class ThongTinProvider{
  static Future<List<ThongTinObject>> get(String email) async {
    List<ThongTinObject> ThongTin = [];
    final snapshot = await FirebaseFirestore.instance.collection("thong_tin")
    .where('email', isEqualTo: email).get();
    // ignore: no_leading_underscores_for_local_identifiers
     ThongTin = snapshot.docs.map((json) => ThongTinObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return ThongTin;
  }
   static Future<List<ThongTinObject>> getEmail() async {
    List<ThongTinObject> ThongTin = [];
    final snapshot = await FirebaseFirestore.instance.collection("thong_tin")
    .get();
    // ignore: no_leading_underscores_for_local_identifiers
     ThongTin = snapshot.docs.map((json) => ThongTinObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return ThongTin;
  }
   static Future<List<ThongTinObject>> fill(String email) async {
    List<ThongTinObject> ThongTin = [];
    final snapshot = await FirebaseFirestore.instance.collection("thong_tin")
    .where('email', arrayContains: email).get();
    // ignore: no_leading_underscores_for_local_identifiers
     ThongTin = snapshot.docs.map((json) => ThongTinObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return ThongTin;
  }
}