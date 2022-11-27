import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lord_of_quizzs/model/bo_cau_hoi_object.dart';
import 'linh_vuc_object.dart';

class BoCauHoiProvider{
  static Future<List<BoCauHoiObject>> getDataByID(int idLinhVuc) async {
    List<BoCauHoiObject> boCauHoi = [];
    final snapshot = await FirebaseFirestore.instance.collection("bo_cau_hoi")
    .where('id_linh_vuc', isEqualTo: idLinhVuc).get();
    // ignore: no_leading_underscores_for_local_identifiers
     boCauHoi = snapshot.docs.map((json) => BoCauHoiObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return boCauHoi;
  }
}