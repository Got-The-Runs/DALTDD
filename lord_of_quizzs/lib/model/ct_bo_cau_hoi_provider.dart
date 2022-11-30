import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lord_of_quizzs/model/ct_bo_cau_hoi_object.dart';

class CTBoCauHoiProvider{
  static Future<List<CTBoCauHoiObject>> getDataByID(int idBoCauHoi) async {
    List<CTBoCauHoiObject> idCauHoi = []; 
    final snapshot = await FirebaseFirestore.instance.collection("ct_bo_cau_hoi")
    .where('id_bo_cau_hoi', isEqualTo:idBoCauHoi).get();
    // ignore: no_leading_underscores_for_local_identifiers
     idCauHoi = snapshot.docs.map((json) => CTBoCauHoiObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return idCauHoi;
  }
}