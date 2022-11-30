import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lord_of_quizzs/model/cau_hoi_object.dart';
import 'package:lord_of_quizzs/model/ct_bo_cau_hoi_object.dart';

class CauHoiProvider {
    static Future<List<CauHoiObject>> getDataById(int id) async {
     List<CauHoiObject> cauHoi =[];
      QuerySnapshot snapshot;
          snapshot = await FirebaseFirestore.instance.collection('cau_hoi')
              .where('id_cau_hoi', isEqualTo: id)
              .get();
          cauHoi = snapshot.docs.map((json) => CauHoiObject.fromJson(json.data()as Map<String, dynamic>)).toList(); 
    return cauHoi;
    // ignore: no_leading_underscores_for_local_identifiers
  }
}