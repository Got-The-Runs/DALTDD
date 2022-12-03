// ignore_for_file: unused_import

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'linh_vuc_object.dart';
class LinhVucProvider {
  //ignore: non_constant_identifier_names
    static Future<List<LinhVucObject>> getData() async {
      List<LinhVucObject> linhVuc =[];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('linh-vuc').get();
    // ignore: no_leading_underscores_for_local_identifiers
     linhVuc = snapshot.docs.map((json) => LinhVucObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return linhVuc;
  }

   static Future<List<LinhVucObject>> getDataByID(int idLinhVuc) async {
      List<LinhVucObject> linhVuc =[];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('linh-vuc')
    .where("id_linh_vuc", isEqualTo: idLinhVuc).get();
    // ignore: no_leading_underscores_for_local_identifiers
     linhVuc = snapshot.docs.map((json) => LinhVucObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return linhVuc;
  }
}